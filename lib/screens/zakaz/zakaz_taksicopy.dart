// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../bloc/order_store/order_store_bloc.dart';
// import '../../widgets/zakaz taxi/time_picker.dart';
// import '../settings.dart';
//
// class ZakazTaxi extends StatefulWidget {
//   const ZakazTaxi({super.key});
//
//   @override
//   State<ZakazTaxi> createState() => _ZakazTaxiState();
// }
//
// class _ZakazTaxiState extends State<ZakazTaxi> {
//   final List<String> cities = ["Ташкент", "Бекабад", "Ширин"];
//   final List<String> tashkentDestinations = ["Бекабад", "Ширин"];
//   final List<String> dates = ["Сегодня", "Завтра"];
//   final List<int> passengerOptions = [1, 2, 3, 4];
//
//   String fromCity = "Бекабад";
//   String toCity = "Ташкент";
//   String selectedDate = "Сегодня";
//   int numberOfPassengers = 1;
//
//   String? selectedTime; // vaqt tanlanadi
//   int totalPrice = 80000;
//   String totalPriceFormatted = "80 000";
//
//   bool isAirConditioningRequired = false;
//   bool isBagajnikRequired = false;
//   bool vipmesto = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _updateTotalPrice();
//   }
//
//   /// Har bir shaharga ID beramiz
//   int _getCityId(String city) {
//     switch (city) {
//       case "Ташкент":
//         return 1;
//       case "Бекабад":
//         return 2;
//       case "Ширин":
//         return 3;
//       default:
//         return 0;
//     }
//   }
//
//   void _updateFromCity(String? selectedCity) {
//     if (selectedCity == null) return;
//     setState(() {
//       fromCity = selectedCity;
//       if (fromCity == "Бекабад" || fromCity == "Ширин") {
//         toCity = "Ташкент";
//       } else if (fromCity == "Ташкент") {
//         toCity = tashkentDestinations.first;
//       }
//       _updateTotalPrice();
//     });
//   }
//
//   void _updateToCity(String? selectedCity) {
//     if (selectedCity == null) return;
//     setState(() {
//       toCity = selectedCity;
//       _updateTotalPrice();
//     });
//   }
//
//   void _updateDate(String? newDate) {
//     if (newDate != null) {
//       setState(() {
//         selectedDate = newDate;
//       });
//     }
//   }
//
//   void _updateTotalPrice() {
//     if (isBagajnikRequired) {
//       totalPriceFormatted = "Цена договорная";
//       return;
//     }
//
//     if ((fromCity == "Ташкент" && toCity == "Бекабад") ||
//         (fromCity == "Бекабад" && toCity == "Ташкент")) {
//       totalPrice = 80000 * numberOfPassengers;
//     } else if ((fromCity == "Ташкент" && toCity == "Ширин") ||
//         (fromCity == "Ширин" && toCity == "Ташкент")) {
//       totalPrice = 90000 * numberOfPassengers;
//     } else {
//       totalPrice = 0;
//     }
//
//     if (vipmesto) {
//       totalPrice += 10000 * numberOfPassengers;
//     }
//
//     totalPriceFormatted = NumberFormat("#,##0", "en_US")
//         .format(totalPrice)
//         .replaceAll(',', ' ');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final bool negotiable = isBagajnikRequired;
//
//     return BlocListener<OrderStoreBloc, OrderStoreState>(
//       listener: (context, state) {
//         state.whenOrNull(
//           loading: () => showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (_) => const Center(child: CircularProgressIndicator()),
//           ),
//           success: (_) {
//             Navigator.pop(context);
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Заказ успешно оформлен!')),
//             );
//           },
//           failure: (e) {
//             Navigator.pop(context);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Ошибка: ${e.message}')),
//             );
//           },
//         );
//       },
//       child: Scaffold(
//         backgroundColor: currentindex == 0
//             ? const Color(0xFFF2F4F5)
//             : const Color(0xFF33263C),
//         appBar: AppBar(
//           backgroundColor:
//           currentindex == 0 ? Colors.white : const Color(0xFF43324D),
//           title: Text(
//             "Заказать такси".tr(),
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: currentindex == 0 ? Colors.black : Colors.white,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 0.3,
//           leading: IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: Icon(
//               Icons.arrow_back_rounded,
//               color: currentindex == 0 ? Colors.black : Colors.white,
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     height: size.width / 2,
//                     width: size.width,
//                     color: Colors.grey[300],
//                     child: Image.asset(
//                       "assets/images/map_google.png",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 color: currentindex == 0
//                     ? Colors.white
//                     : const Color(0xFF43324D),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 110,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: _buildDropdownField(
//                               label: "Откуда".tr(),
//                               value: fromCity,
//                               availableCities: cities,
//                               onChanged: _updateFromCity,
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           const Icon(Icons.arrow_circle_right,
//                               color: Colors.orange),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: fromCity == "Ташкент"
//                                 ? _buildDropdownField(
//                               label: "Куда".tr(),
//                               value: toCity,
//                               availableCities: tashkentDestinations,
//                               onChanged: _updateToCity,
//                             )
//                                 : _buildReadonlyDropdownStyle(
//                               label: "Куда".tr(),
//                               value: "Ташкент",
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//
//                     // 🕒 Vaqt tanlash
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TimePickerInput(
//                             label: "Время подачи машины".tr(),
//                             hint: "Tanlang",
//                             icon: LucideIcons.clock,
//                             isTomorrow: selectedDate == "Завтра",
//                             onTimeSelected: (time) {
//                               setState(() {
//                                 selectedTime =
//                                     DateFormat('HH:mm').format(time); // ✅ tuzatildi
//                               });
//                             },
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         Expanded(
//                           child: _buildDropdownField(
//                             label: "Выберите дату".tr(),
//                             value: selectedDate,
//                             availableCities: dates,
//                             onChanged: _updateDate,
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 20),
//                     CheckboxListTile(
//                       value: vipmesto,
//                       onChanged: (v) {
//                         setState(() {
//                           vipmesto = v ?? false;
//                           _updateTotalPrice();
//                         });
//                       },
//                       title: Text("Передняя сиденья свободно".tr()),
//                       activeColor: const Color(0xFFFF7625),
//                     ),
//                     CheckboxListTile(
//                       value: isBagajnikRequired,
//                       onChanged: (v) {
//                         setState(() {
//                           isBagajnikRequired = v ?? false;
//                           _updateTotalPrice();
//                         });
//                       },
//                       title: Text("Багажник на крыше".tr()),
//                       activeColor: const Color(0xFFFF7625),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           child: BlocBuilder<OrderStoreBloc, OrderStoreState>(
//             builder: (context, state) {
//               final isLoading = state.maybeWhen(
//                 loading: () => true,
//                 orElse: () => false,
//               );
//
//               final bool negotiable = isBagajnikRequired;
//
//               return Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 50,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         negotiable
//                             ? "Сумма договорная".tr()
//                             : "$totalPriceFormatted сум".tr(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: SizedBox(
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: isLoading
//                             ? null
//                             : () {
//                           final fromId = _getCityId(fromCity);
//                           final toId = _getCityId(toCity);
//
//                           context.read<OrderStoreBloc>().add(
//                             OrderStoreEvent.order(
//                               fromWheresId: fromId,
//                               whereTosId: toId,
//                               latitude: 41.311081,
//                               longitude: 69.240562,
//                               where: "Manzil kiritilmagan",
//                               time: selectedTime ?? "Tanlanmagan",
//                               day: selectedDate,
//                               passengersCount: numberOfPassengers,
//                               frontSeat: vipmesto,
//                               bagaj: isBagajnikRequired,
//                               toDriverComment: "",
//                               price: totalPrice,
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFFF7625),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: isLoading
//                             ? const SizedBox(
//                           height: 22,
//                           width: 22,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2.5,
//                           ),
//                         )
//                             : Text(
//                           "Заказать".tr(),
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ------- helper widgetlar (senda borlari) -------
//   Widget _buildDropdownField({
//     required String label,
//     required String value,
//     required List<String> availableCities,
//     required void Function(String?) onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       items: availableCities
//           .map((city) => DropdownMenuItem(value: city, child: Text(city)))
//           .toList(),
//       onChanged: onChanged,
//       decoration: InputDecoration(
//         labelText: label,
//         filled: true,
//         fillColor: Colors.grey[200],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildReadonlyDropdownStyle({
//     required String label,
//     required String value,
//   }) {
//     return Container(
//       height: 55,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               value.tr(),
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//           const Icon(Icons.arrow_drop_down_rounded, color: Colors.grey),
//         ],
//       ),
//     );
//   }
// }
