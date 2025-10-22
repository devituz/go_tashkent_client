import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../screens/settings.dart';

class OrderCard extends StatelessWidget {
  final String type;
  final String driver;
  final String car;
  final String licensePlate;
  final String date;
  final String from;
  final String to;
  final String price;

  const OrderCard({
    required this.type,
    required this.driver,
    required this.car,
    required this.licensePlate,
    required this.date,
    required this.from,
    required this.to,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      color: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: currentindex == 0 ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Водитель:  ".tr() + " " + driver,
                  style: TextStyle(
                    color: currentindex == 0 ? Colors.black : Colors.white,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  "Марка автомобиля:  ".tr() + " " + car,
                  style: TextStyle(
                    color: currentindex == 0 ? Colors.black : Colors.white,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  "Государственный номер:  ".tr() + " " + licensePlate,
                  style: TextStyle(
                    color: currentindex == 0 ? Colors.black : Colors.white,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  "Дата заказа:  ".tr() + date,
                  style: TextStyle(
                    color: currentindex == 0 ? Colors.black : Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      from.tr(),
                      style: TextStyle(
                        color: currentindex == 0 ? Colors.black : Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Icon(
                      Icons.arrow_circle_right,
                      color: Color(0xFFFF7625),
                      size: 15,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      to.tr(),
                      style: TextStyle(
                        color: currentindex == 0 ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7625),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    (price == "0" ? "Kelishiladi" : "$price сум").tr(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),


                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
