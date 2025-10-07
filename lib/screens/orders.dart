import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/order_card.dart';
import 'settings.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          currentindex == 0 ? const Color(0xFFF2F4F5) : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor:
            currentindex == 0 ? Colors.white : const Color(0xFF43324D),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.3,
                color: Colors.black38,
              ),
            ),
          ),
        ),
        title: Text(
          "Мои заказы".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
        scrolledUnderElevation: 0,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "Активные заказы".tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: currentindex == 0 ? Colors.black : Colors.white,
                ),
              ),
            ),
            OrderCard(
              type: "ТАКСИ",
              driver: "Азимов Бобур",
              car: "белый NEXIA 3",
              licensePlate: "01 Q 363 KJ",
              date: "18.01.2025, 14:30",
              from: "Ташкент",
              to: "Бекабад",
              price: "70 000",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Text(
                "История заказов".tr(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: currentindex == 0 ? Colors.black : Colors.white,
                ),
              ),
            ),
            OrderCard(
              type: "ТАКСИ",
              driver: "Азимов Бобур",
              car: "белый NEXIA 3",
              licensePlate: "01 Q 363 KJ",
              date: "18.01.2025, 14:30",
              from: "Ташкент",
              to: "Бекабад",
              price: "70 000",
            ),
            OrderCard(
              type: "ПОЧТОВАЯ ПОСЫЛКА",
              driver: "Азимов Бобур",
              car: "белый NEXIA 3",
              licensePlate: "01 Q 363 KJ",
              date: "18.01.2025, 14:30",
              from: "Ташкент",
              to: "Бекабад",
              price: "45 000",
            ),
            OrderCard(
              type: "ГРУЗОПЕРЕВОЗКИ",
              driver: "Азимов Бобур",
              car: "белый NEXIA 3",
              licensePlate: "01 Q 363 KJ",
              date: "18.01.2025, 14:30",
              from: "Ташкент",
              to: "Бекабад",
              price: "340 000",
            ),
            OrderCard(
              type: "ТАКСИ",
              driver: "Азимов Бобур",
              car: "белый NEXIA 3",
              licensePlate: "01 Q 363 KJ",
              date: "18.01.2025, 14:30",
              from: "Ташкент",
              to: "Бекабад",
              price: "70 000",
            ),
            OrderCard(
              type: "ПОЧТОВАЯ ПОСЫЛКА",
              driver: "Азимов Бобур",
              car: "белый NEXIA 3",
              licensePlate: "01 Q 363 KJ",
              date: "18.01.2025, 14:30",
              from: "Ташкент",
              to: "Бекабад",
              price: "45 000",
            ),
            OrderCard(
              type: "ГРУЗОПЕРЕВОЗКИ",
              driver: "Азимов Бобур",
              car: "белый NEXIA 3",
              licensePlate: "01 Q 363 KJ",
              date: "18.01.2025, 14:30",
              from: "Ташкент",
              to: "Бекабад",
              price: "340 000",
            ),
          ],
        ),
      ),
    );
  }
}
