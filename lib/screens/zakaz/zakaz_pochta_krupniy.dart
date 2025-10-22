import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_tashkent_client/screens/FullMapScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../bloc/order_store/order_store_bloc.dart';
import '../../widgets/zakaz taxi/time_picker.dart';
import '../settings.dart';

class ZakazPochtaKrupniy extends StatefulWidget {
  const ZakazPochtaKrupniy({super.key});

  @override
  State<ZakazPochtaKrupniy> createState() => _ZakazPochtaKrupniyState();
}

class _ZakazPochtaKrupniyState extends State<ZakazPochtaKrupniy> {
  final Map<String, int> cityIds = {
    "Ташкент": 1,
    "Бекабад": 2,
    "Ширин": 3,
  };

  int totalPrice = 0;


  final Map<String, int> tashkentDestinations = {
    "Бекабад": 2,
    "Ширин": 3,
  };

  DateTime? selectedTime;
  final List<String> dates = ["Сегодня", "Завтра"];

  String fromCity = "Ташкент";
  String toCity = "Бекабад";
  String selectedDate = "Сегодня";
  bool isBagajnikRequired = false;
  LatLng? _currentLatLng; // nullable


  final TextEditingController _pickupController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _receiverNameController = TextEditingController();
  TextEditingController _receiverPhoneController = TextEditingController();
  TextEditingController _commentController = TextEditingController();


  Future<LatLng> _getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return LatLng(pos.latitude, pos.longitude);
  }


  void _updateFromCity(String? selectedCity) {
    if (selectedCity == null) return;
    setState(() {
      fromCity = selectedCity;
      if (fromCity == "Бекабад" || fromCity == "Ширин") {
        toCity = "Ташкент";
      } else if (fromCity == "Ташкент") {
        toCity = tashkentDestinations.keys.first;
      }
    });
  }

  void _updateToCity(String? selectedCity) {
    if (selectedCity == null) return;
    setState(() {
      toCity = selectedCity;
    });
  }

  void _updateDate(String? newDate) {
    if (newDate != null) {
      setState(() {
        selectedDate = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    final bool isTimeSelected = selectedTime != null;

    final bool isReceiverNameController = _receiverNameController.text.isNotEmpty;
    final bool isReceiverPhoneController = _receiverPhoneController.text.isNotEmpty;
    final bool isPickupController = _pickupController.text.isNotEmpty;
    final bool isDestinationFilled = _destinationController.text.isNotEmpty;


    final bool canOrder = isTimeSelected && isDestinationFilled && isPickupController && isReceiverNameController &&isReceiverPhoneController;


    return Scaffold(
      backgroundColor: currentindex == 0
          ? const Color(0xFFF2F4F5)
          : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor: currentindex == 0
            ? Colors.white
            : const Color(0xFF43324D),
        title: Text(
          "Крупногабаритные почты".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0.3,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.width / 2,
              width: size.width,
              color: Colors.grey[300],
              child: Image.asset(
                "assets/images/map_google.png",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: currentindex == 0
                    ? Colors.white
                    : const Color(0xFF43324D),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField(
                            label: "Откуда".tr(),
                            value: fromCity,
                            availableCities: cityIds.keys.toList(),
                            onChanged: _updateFromCity,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_circle_right,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: fromCity == "Ташкент"
                              ? _buildDropdownField(
                                  label: "Куда".tr(),
                                  value: toCity,
                            availableCities: tashkentDestinations.keys.toList(),
                                  onChanged: _updateToCity,
                                )
                              : _buildReadonlyDropdown(
                                  label: "Куда".tr(),
                                  value: "Ташкент",
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildMapPickerField(
                    context: context,
                    label: "Откуда забрать посылку?".tr(),
                    hint: _pickupController.text.isEmpty ? "Выбрать на карте".tr() : _pickupController.text,
                    controller: _pickupController,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    label: "Куда доставить посылку?".tr(),
                    hint: "Адрес получателя...".tr(),
                    controller: _destinationController,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    label: "Получатель".tr(),
                    hint: "Имя получателя...".tr(),
                    controller: _receiverNameController,
                  ),
                  const SizedBox(height: 16),

                  _buildInputField(
                    label: "Номер телефона".tr(),
                    hint: "Номер телефона получателя".tr(),
                    controller: _receiverPhoneController,
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    value: isBagajnikRequired,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isBagajnikRequired = newValue ?? false;
                      });
                    },
                    title: Text(
                      "Багажник на крыше".tr(),
                      style: TextStyle(
                        fontSize: 15,
                        color: currentindex == 0 ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: const Color(0xFFFF7625),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TimePickerInput(
                          label: "Время подачи машины".tr(),
                          hint: "",
                          icon: LucideIcons.clock,
                          isTomorrow: selectedDate == "Завтра",
                          onTimeSelected: (time) {
                            setState(() {
                              selectedTime = time;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildDropdownData(
                          label: "Выберите дату".tr(),
                          value: selectedDate,
                          onChanged: _updateDate,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    label: "Напишите комментарий для водителя".tr(),
                    hint: "Напишите комментарии...".tr(),
                    controller: _commentController,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Сумма договорная".tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: BlocConsumer<OrderStoreBloc, OrderStoreState>(
                listener: (context, state) {
                  state.maybeWhen(
                    success: (result) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/order_accept');
                    },
                    failure: (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ошибка: ${error.message}')),
                      );
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                      loading: () => true, orElse: () => false);
                  return SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading || !canOrder
                          ? null
                          : () {
                        final priceToSend = totalPrice;

                        context.read<OrderStoreBloc>().add(
                          OrderStoreEvent.order(
                            fromWheresId: cityIds[fromCity]!,
                            whereTosId: cityIds[toCity]!,
                            latitude: _currentLatLng?.latitude ?? 41.2995,
                            longitude: _currentLatLng?.longitude ?? 69.2401,
                            receiverAddress: _destinationController.text,
                            receiverName: _receiverNameController.text,
                            receiverPhone: _receiverPhoneController.text,
                            frontSeat: 0,
                            bagaj: isBagajnikRequired ? 1 : 0,
                            time: "${selectedTime!.hour.toString().padLeft(2,'0')}:${selectedTime!.minute.toString().padLeft(2,'0')}",
                            day: selectedDate,
                            toDriverComment: _commentController.text,
                            orderType: "mail",
                            priceType: "cash",
                            price: priceToSend,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7625),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        "Оформить".tr(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownData({
    required String label,
    required String value,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: currentindex == 0 ? Colors.black54 : Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: dates.map((data) {
            return DropdownMenuItem(value: data, child: Text(data.tr()));
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> availableCities,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: currentindex == 0 ? Colors.black54 : Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: availableCities.map((city) {
            return DropdownMenuItem(value: city, child: Text(city.tr()));
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReadonlyDropdown({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: currentindex == 0 ? Colors.black54 : Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down_rounded, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMapPickerField({
    required BuildContext context,
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return GestureDetector(
      onTap: () async {
        // Hozirgi location olish
        LatLng currentLatLng = await _getCurrentLocation();

        // Go ekranini ochamiz va tanlangan manzilni kutamiz
        final result = await Navigator.push<Map<String, dynamic>>(
          context,
          MaterialPageRoute(
            builder: (_) => Go(initial: currentLatLng),
          ),
        );

        // Tanlangan manzilni controller ga yozamiz
        if (result != null) {
          controller.text = result['address'] ?? '';
          // kerak bo'lsa LatLng saqlash
          _currentLatLng = result['latLng'];
        }
      },
      child: AbsorbPointer(
        // TextField faqat display uchun, yozib bo‘lmaydi
        child: _buildInputField(
          label: label,
          hint: hint,
          controller: controller,
          icon: LucideIcons.mapPin,
        ),
      ),
    );
  }


  Widget _buildInputField({
    required String label,
    required String hint,
    TextEditingController? controller,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: currentindex == 0 ? Colors.black54 : Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon != null ? Icon(icon, size: 20) : null,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
