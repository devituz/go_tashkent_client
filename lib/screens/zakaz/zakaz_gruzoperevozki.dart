import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../widgets/zakaz taxi/time_picker.dart';
import '../settings.dart';

class ZakazGruzoperevozki extends StatefulWidget {
  const ZakazGruzoperevozki({super.key});

  @override
  State<ZakazGruzoperevozki> createState() => _ZakazGruzoperevozkiState();
}

class _ZakazGruzoperevozkiState extends State<ZakazGruzoperevozki> {
  final List<String> cities = ["Ташкент", "Бекабад", "Ширин"];
  final List<String> tashkentDestinations = ["Бекабад", "Ширин"];
  final List<String> dates = ["Сегодня", "Завтра"];

  String fromCity = "Ташкент";
  String toCity = "Бекабад";
  String selectedDate = "Сегодня";

  TextEditingController _addressController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _receiverNameController = TextEditingController();
  TextEditingController _receiverPhoneController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  void _updateFromCity(String? selectedCity) {
    if (selectedCity == null) return;
    setState(() {
      fromCity = selectedCity;
      if (fromCity == "Бекабад" || fromCity == "Ширин") {
        toCity = "Ташкент";
      } else if (fromCity == "Ташкент") {
        toCity = tashkentDestinations.first;
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
    return Scaffold(
      backgroundColor: currentindex == 0 ? const Color(0xFFF2F4F5) : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
        title: Text(
          "Грузоперевозки".tr(),
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
                color: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
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
                            availableCities: cities,
                            onChanged: _updateFromCity,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_circle_right, color: Colors.orange),
                        const SizedBox(width: 10),
                        Expanded(
                          child: fromCity == "Ташкент"
                              ? _buildDropdownField(
                                  label: "Куда".tr(),
                                  value: toCity,
                                  availableCities: tashkentDestinations,
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
                  _buildInputField(
                    label: "Откуда забрать груз?".tr(),
                    hint: "Выбрать на карте".tr(),
                    controller: _addressController,
                    icon: LucideIcons.mapPin,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    label: "Куда доставить груз?".tr(),
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
                  Row(
                    children: [
                      Expanded(
                        child: TimePickerInput(
                          label: "Время подачи машины".tr(),
                          hint: "",
                          icon: LucideIcons.clock,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildDropdownDateField(
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
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7625),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Оформить".tr(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
        Text(label, style: TextStyle(fontSize: 14, color: currentindex == 0 ? Colors.black54 : Colors.white)),
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildReadonlyDropdown({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: currentindex == 0 ? Colors.black54 : Colors.white)),
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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownDateField({
    required String label,
    required String value,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: currentindex == 0 ? Colors.black54 : Colors.white)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: dates.map((date) {
            return DropdownMenuItem(value: date, child: Text(date.tr()));
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
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
        Text(label, style: TextStyle(fontSize: 14, color: currentindex == 0 ? Colors.black54 : Colors.white)),
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
