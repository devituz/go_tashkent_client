import 'dart:io' show Platform;
import 'package:geolocator/geolocator.dart';

Future<bool> checkAndRequestPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openAppSettings();
    if (Platform.isAndroid) {
      await Geolocator.openLocationSettings();
    }
    return false;
  }

  return permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse;
}

Future<double> getDistanceOnce({
  required String latitude,
  required String longitude,
}) async {
  final hasPermission = await checkAndRequestPermission();
  if (!hasPermission) return 0.0;

  final lat = double.tryParse(latitude);
  final lng = double.tryParse(longitude);
  if (lat == null || lng == null) return 0.0;

  try {
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final distance = Geolocator.distanceBetween(
      pos.latitude,
      pos.longitude,
      lat,
      lng,
    ) / 1000 * 1.1;

    return double.parse(distance.toStringAsFixed(1));
  } catch (e) {
    print('❌ Masofa hisoblashda xato: $e');
    return 0.0;
  }
}
