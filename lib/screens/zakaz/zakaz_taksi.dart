import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_tashkent_client/screens/FullMapScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

import '../../widgets/zakaz taxi/time_picker.dart';
import '../settings.dart';
import 'package:go_tashkent_client/bloc/order_store/order_store_bloc.dart';

class ZakazTaxi extends StatefulWidget {
  const ZakazTaxi({super.key});

  @override
  State<ZakazTaxi> createState() => _ZakazTaxiState();
}

class _ZakazTaxiState extends State<ZakazTaxi> {
  final Map<String, int> cityIds = {
    "Ташкент": 1,
    "Бекабад": 2,
    "Ширин": 3,
  };

  final Map<String, int> tashkentDestinations = {
    "Бекабад": 2,
    "Ширин": 3,
  };

  DateTime? selectedTime;


  // final List<String> tashkentDestinations = ["Бекабад", "Ширин"];
  final List<String> dates = ["Сегодня", "Завтра"];
  final List<int> passengerOptions = [1, 2, 3, 4];

  String fromCity = "Бекабад";
  String toCity = "Ташкент";
  String selectedDate = "Сегодня";
  int numberOfPassengers = 1;


  int totalPrice = 80000;
  String totalPriceFormatted = "80 000";

  bool isAirConditioningRequired = false;
  bool isBagajnikRequired = false; // «Багажник на крыше»
  bool vipmesto = false;
  LatLng? _currentLatLng; // nullable


  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();



  @override
  void initState() {
    super.initState();

    // Pickup controller listener
    _pickupController.addListener(() {
      setState(() {});
    });


    _destinationController.addListener(() {
      setState(() {});
    });
    _updateTotalPrice();
  }


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
      });
    }
  }

  void _updateTotalPrice() {
    if (isBagajnikRequired) {
      totalPriceFormatted = "Цена договорная";
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
      totalPrice += 10000; // faqat 1 marta qo‘shiladi
    }

    totalPriceFormatted = NumberFormat("#,##0", "en_US")
        .format(totalPrice)
        .replaceAll(',', ' ');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bool negotiable = isBagajnikRequired;

    final bool isDestinationFilled = _destinationController.text.isNotEmpty;
    final bool isPickupController = _pickupController.text.isNotEmpty;
    final bool isTimeSelected = selectedTime != null;
    final bool canOrder = isTimeSelected && isDestinationFilled && isPickupController;



    return BlocProvider(
      create: (_) => OrderStoreBloc(),
      child: Scaffold(
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
                              availableCities: cityIds.keys.toList(),
                              onChanged: _updateFromCity,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_circle_right,
                              color: Colors.orange),
                          const SizedBox(width: 10),
                          Expanded(
                            child: fromCity == "Ташкент"
                                ? _buildDropdownField(
                              label: "Куда".tr(),
                              value: toCity,
                              availableCities: tashkentDestinations.keys.toList(),
                              onChanged: _updateToCity,
                            )
                                : _buildReadonlyDropdownStyle(
                                label: "Куда".tr(), value: "Ташкент"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildMapPickerField(
                      context: context,
                      label: "Ваш текущий адрес или место подачи".tr(),
                      hint: _pickupController.text.isEmpty ? "Выбрать на карте".tr() : _pickupController.text,
                      controller: _pickupController,
                    ),

                    const SizedBox(height: 16),
                    _buildInputField(
                      context,
                      label: "Куда едем?".tr(),
                      hint: "Укажите, куда едем...".tr(),
                      controller: _destinationController,
                    ),
                    const SizedBox(height: 16),

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
                          color:
                          currentindex == 0 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: const Color(0xFFFF7625),
                      contentPadding: EdgeInsets.zero,
                    ),

                    CheckboxListTile(
                      value: isBagajnikRequired,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isBagajnikRequired = newValue ?? false;
                          _updateTotalPrice();
                        });
                      },
                      title: Text(
                        "Багажник на крыше".tr(),
                        style: TextStyle(
                          fontSize: 15,
                          color:
                          currentindex == 0 ? Colors.black : Colors.white,
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
                    negotiable
                        ? "Сумма договорная".tr()
                        : "${totalPriceFormatted.tr()} сум".tr(),
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
                          final priceToSend = negotiable ? 0 : totalPrice;

                          context.read<OrderStoreBloc>().add(
                            OrderStoreEvent.order(
                              fromWheresId: cityIds[fromCity]!,
                              whereTosId: cityIds[toCity]!,
                              latitude: _currentLatLng?.latitude ?? 41.2995, // default fallback
                              longitude: _currentLatLng?.longitude ?? 69.2401,
                              where: _destinationController.text,
                              time: "${selectedTime!.hour.toString().padLeft(2,'0')}:${selectedTime!.minute.toString().padLeft(2,'0')}",
                              passengersCount: numberOfPassengers,
                              frontSeat: vipmesto ? 1 : 0,
                              bagaj: isBagajnikRequired ? 1 : 0,
                              day: selectedDate,

                              toDriverComment: _commentController.text,
                              orderType: "taxi",
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
                          "Заказать".tr(),
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
      ),
    );
  }

  // ------- Helper UI widgets -------

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> availableCities,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.tr(),
            style: TextStyle(
                fontSize: 14,
                color: currentindex == 0 ? Colors.black54 : Colors.white)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: availableCities
              .map((city) =>
              DropdownMenuItem(value: city, child: Text(city).tr()))
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
        Text(label.tr(),
            style: TextStyle(
                fontSize: 14,
                color: currentindex == 0 ? Colors.black54 : Colors.white)),
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
                child: Text(value.tr(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
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
        Text(label,
            style: TextStyle(
                fontSize: 14,
                color: currentindex == 0 ? Colors.black54 : Colors.white)),
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
          context,
          label: label,
          hint: hint,
          controller: controller,
          icon: LucideIcons.mapPin,
        ),
      ),
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
        Text(label,
            style: TextStyle(
                fontSize: 14,
                color: currentindex == 0 ? Colors.black54 : Colors.white)),
        const SizedBox(height: 8),
        DropdownButtonFormField<int>(
          value: value,
          items: options
              .map((n) => DropdownMenuItem<int>(
            value: n,
            child: Row(
              children: [
                const Icon(LucideIcons.user, size: 18),
                const SizedBox(width: 8),
                Text(n.toString()),
              ],
            ),
          ))
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
