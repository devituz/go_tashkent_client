import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/app_theme.dart';

class Go extends StatefulWidget {
  final LatLng initial;
  const Go({super.key, required this.initial});

  @override
  State<Go> createState() => _GoState();
}

class _GoState extends State<Go> with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> _controller = Completer();
  late LatLng _selected = widget.initial;
  String _address = 'Manzil aniqlanmoqda...';

  bool _isLocating = false;
  bool _isMoving = false;
  bool _isSelectingDestination = false;
  int _selectedType = 0;

  List<Map<String, dynamic>> _searchResults = [];
  String? _selectedDestination;

  /// 🔹 Qo‘shimcha: chiziq va markerlar uchun
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  LatLng? _destinationLatLng;

  late AnimationController _pinController;
  late Animation<double> _pinAnim;

  @override
  void initState() {
    super.initState();
    _getAddress(_selected);

    _pinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _pinAnim = Tween<double>(begin: 0, end: -12)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(_pinController);
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _myLoc() async {
    if (_isLocating) return;
    setState(() => _isLocating = true);

    try {
      await Geolocator.requestPermission();
      Position? pos = await Geolocator.getLastKnownPosition();
      pos ??= await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        timeLimit: const Duration(seconds: 5),
      );

      final c = await _controller.future;
      final newLatLng = LatLng(pos.latitude, pos.longitude);

      await c.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: newLatLng,
            zoom: 18,
            tilt: 60,
            bearing: 45,
          ),
        ),
      );

      setState(() => _selected = newLatLng);
      _getAddress(newLatLng);
    } catch (e) {
      debugPrint('Location error: $e');
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  Future<void> _getAddress(LatLng pos) async {
    try {
      final placemarks =
      await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        setState(() {
          _address =
          '${p.street ?? ''}, ${p.locality ?? ''}, ${p.administrativeArea ?? ''}';
        });
      } else {
        setState(() => _address = 'Manzil topilmadi');
      }
    } catch (e) {
      setState(() => _address = 'Manzilni olishda xatolik');
    }
  }





  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.initial,
                zoom: 19,
                tilt: 90,
                bearing: 45,
              ),
              onMapCreated: (c) => _controller.complete(c),
              onCameraMoveStarted: () {
                if (!_isMoving) {
                  _isMoving = true;
                  _pinController.forward();
                }
              },
              onCameraMove: (pos) => _selected = pos.target,
              onCameraIdle: () {
                _isMoving = false;
                _pinController.reverse();
                _getAddress(_selected);
              },
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              markers: _markers,
              polylines: _polylines,
            ),

            /// Pin animatsiyasi
            AnimatedBuilder(
              animation: _pinController,
              builder: (_, __) {
                return Transform.translate(
                  offset: Offset(0, _pinAnim.value - 150), // 🔹 pin 20px yuqoriroq
                  child: CustomPin(isMoving: _isMoving),
                );
              },
            ),



            Positioned(
              right: 10, // o‘ng tomonda
              bottom: 180, // pastki qismdan 20px
              height: 50,
              width: 50,

              child: FloatingActionButton(
                onPressed: _myLoc,
                backgroundColor: const Color(0xFFFF7625),
                child: _isLocating
                    ? const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2.5)
                    : const Icon(Icons.my_location, color: Colors.white),
              ),
            ),


            /// Pastki panel
            _buildBottomPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {


    final panelHeight =
    _isSelectingDestination ? MediaQuery.of(context).size.height * 0.5 : null;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      bottom: 5,
      left: 0,
      right: 0,
      height: panelHeight,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Manzil qatori
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppTheme.gradinet1),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _address,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await   SharedPreferences.getInstance();

                    // 🔹 auth qiymatini false qilib saqlash
                    await prefs.setBool('auth', true);
                    Navigator.pop(context, {
                      'latLng': _selected,
                      'address': _address,
                    });
                    debugPrint('Buyurtma berildi: $_selectedType');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppTheme.gradinet1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Keyingisi",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

/// 🔹 Custom Pin o‘zgarmagan
class CustomPin extends StatelessWidget {
  final bool isMoving;
  const CustomPin({super.key, this.isMoving = false});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: isMoving ? 1 : 0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutQuart,
      builder: (context, value, _) {
        final bounce = math.sin(value * math.pi);
        final lift = -10.0 * bounce;
        final stretch = 1.0 + (0.15 * bounce);
        final shadowScale = 1.0 - (0.25 * bounce);
        final shadowOpacity = 0.25 + (0.25 * (1 - shadowScale));

        return Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -14,
              child: Transform.scale(
                scale: shadowScale,
                child: Container(
                  width: 65,
                  height: 22,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Colors.black.withOpacity(shadowOpacity),
                        Colors.transparent,
                      ],
                      stops: const [0.25, 1],
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, lift),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.gradinet1,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scaleY: stretch,
                    child: Container(
                      width: 3.5,
                      height: 30,
                      color: AppTheme.gradinet1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
