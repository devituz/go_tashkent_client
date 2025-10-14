import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

import '../../widgets/zakaz taxi/time_picker.dart';
import '../settings.dart';

class ZakazTaxi extends StatefulWidget {
  const ZakazTaxi({super.key});

  @override
  State<ZakazTaxi> createState() => _ZakazTaxiState();
}

class _ZakazTaxiState extends State<ZakazTaxi> {
  final List<String> cities = ["Ташкент", "Бекабад", "Ширин"];
  final List<String> tashkentDestinations = ["Бекабад", "Ширин"];
  final List<String> dates = ["Сегодня", "Завтра"];
  final List<int> passengerOptions = [1, 2, 3, 4];

  String fromCity = "Бекабад";
  String toCity = "Ташкент";
  String selectedDate = "Сегодня";
  int numberOfPassengers = 1;

  int totalPrice = 80000;
  String totalPriceFormatted = "80 000";

  bool isAirConditioningRequired = false;
  bool isBagajnikRequired = false; // ← «Багажник на крыше»
  bool vipmesto = false;

  @override
  void initState() {
    super.initState();
    _updateTotalPrice();
  }

  void _updateFromCity(String? selectedCity) {
    if (selectedCity == null) return;
    setState(() {
      fromCity = selectedCity;
      if (fromCity == "Бекабад" || fromCity == "Ширин") {
        toCity = "Ташкент";
      } else if (fromCity == "Ташкент") {
        toCity = tashkentDestinations.first;
      }
      _updateTotalPrice();
    });
  }

  void _updateToCity(String? selectedCity) {
    if (selectedCity == null) return;
    setState(() {
      toCity = selectedCity;
      _updateTotalPrice();
    });
  }

  void _updateDate(String? newDate) {
    if (newDate != null) {
      setState(() {
        selectedDate = newDate;
        // дата на цену не влияет сейчас, но оставляем для будущего
      });
    }
  }

  /// Пересчёт цены.
  /// Если включён багажник на крыше — показываем «Цена договорная».
  void _updateTotalPrice() {
    if (isBagajnikRequired) {
      totalPriceFormatted = "Цена договорная"; // переведём при показе
      return;
    }

    if ((fromCity == "Ташкент" && toCity == "Бекабад") ||
        (fromCity == "Бекабад" && toCity == "Ташкент")) {
      totalPrice = 80000 * numberOfPassengers;
    } else if ((fromCity == "Ташкент" && toCity == "Ширин") ||
        (fromCity == "Ширин" && toCity == "Ташкент")) {
      totalPrice = 90000 * numberOfPassengers;
    } else {
      totalPrice = 0;
    }

    if (vipmesto) {
      totalPrice += 10000 * numberOfPassengers;
    }

    totalPriceFormatted = NumberFormat(
      "#,##0",
      "en_US",
    ).format(totalPrice).replaceAll(',', ' ');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bool negotiable = isBagajnikRequired;

    return Scaffold(
      backgroundColor: currentindex == 0
          ? const Color(0xFFF2F4F5)
          : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor: currentindex == 0
            ? Colors.white
            : const Color(0xFF43324D),
        title: Text(
          "Заказать такси".tr(),
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
            Stack(
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
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/zakaz_pustoy');
                    },
                    child: SizedBox(
                      width: size.width / 2,
                      child: dropdownValue == 1
                          ? Image.asset('assets/images/zakaz taksi ru.png')
                          : Image.asset('assets/images/zakaz taksi uz.png'),
                    ),
                  ),
                ),
              ],
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
                            availableCities: cities,
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
                                  availableCities: tashkentDestinations,
                                  onChanged: _updateToCity,
                                )
                              : _buildReadonlyDropdownStyle(
                                  label: "Куда".tr(),
                                  value: "Ташкент",
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildInputField(
                    context,
                    label: "Ваш текущий адрес или место подачи".tr(),
                    hint: "Выбрать на карте".tr(),
                    icon: LucideIcons.mapPin,
                  ),
                  const SizedBox(height: 16),
                  _buildInputField(
                    context,
                    label: "Куда едем?".tr(),
                    hint: "Укажите, куда едем...".tr(),
                  ),
                  const SizedBox(height: 16),

                  // Количество пассажиров (1–4)
                  _buildPassengerDropdown(
                    label: "Количество пассажиров".tr(),
                    value: numberOfPassengers,
                    options: passengerOptions,
                    onChanged: (val) {
                      if (val == null) return;
                      setState(() {
                        numberOfPassengers = val;
                        _updateTotalPrice();
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: TimePickerInput(
                          label: "Время подачи машины".tr(),
                          hint: "",
                          icon: LucideIcons.clock,
                          isTomorrow:
                              selectedDate == "Завтра", // <-- ключевая строка
                          // fixedTzOffsetHours: 5, // <-- если нужно считать время по GMT+5 независимо от девайса
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildDropdownField(
                          label: "Выберите дату".tr(),
                          value: selectedDate,
                          availableCities: dates,
                          onChanged: _updateDate,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Переднее место (добавка)
                  CheckboxListTile(
                    value: vipmesto,
                    onChanged: (bool? newValue) {
                      setState(() {
                        vipmesto = newValue ?? false;
                        _updateTotalPrice();
                      });
                    },
                    title: Text(
                      "Передняя сиденья свободно".tr(),
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

                  // Багажник на крыше → «Цена договорная»
                  CheckboxListTile(
                    value: isBagajnikRequired,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isBagajnikRequired = newValue ?? false;
                        _updateTotalPrice(); // пересчёт (меняем на договорную)
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
                  _buildInputField(
                    context,
                    label: "Напишите комментарий для водителя".tr(),
                    hint: "Напишите комментарии...".tr(),
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
                  negotiable
                      ? "Сумма договорная".tr()
                      : "${totalPriceFormatted.tr()}" + " сум".tr(),
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
                    "Заказать".tr(),
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

  // ------- UI helpers -------

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
          label.tr(),
          style: TextStyle(
            fontSize: 14,
            color: currentindex == 0 ? Colors.black54 : Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: availableCities
              .map(
                (city) => DropdownMenuItem(value: city, child: Text(city).tr()),
              )
              .toList(),
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

  Widget _buildReadonlyDropdownStyle({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.tr(),
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

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required String hint,
    TextInputType? Textinputtype,
    IconData? icon,
    TextEditingController? controller,
    Function(String)? onChanged,
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
          keyboardType: Textinputtype,
          controller: controller,
          onChanged: onChanged,
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

  Widget _buildPassengerDropdown({
    required String label,
    required int value,
    required List<int> options,
    required void Function(int?) onChanged,
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
        DropdownButtonFormField<int>(
          value: value,
          items: options
              .map(
                (n) => DropdownMenuItem<int>(
                  value: n,
                  child: Row(
                    children: [
                      const Icon(LucideIcons.user, size: 18),
                      const SizedBox(width: 8),
                      Text(n.toString()),
                    ],
                  ),
                ),
              )
              .toList(),
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
}
