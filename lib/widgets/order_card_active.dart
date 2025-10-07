import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../screens/settings.dart';

class OrderCardActive extends StatelessWidget {
  const OrderCardActive({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: CircularProgressIndicator()),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: double.infinity,
                child: dropdownValue == 1
                    ? Text(
                        "Мы уже обрабатываем ваш запрос и подбираем ближайшего водителя. Осталось совсем немного...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              currentindex == 0 ? Colors.black : Colors.white,
                          fontSize: 14,
                        ),
                      )
                    : Text(
                        "Biz buyurtmangizni ko'rib chiqmoqdamiz va eng yaqin haydovchini tanlayapmiz. Juda oz qoldi...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              currentindex == 0 ? Colors.black : Colors.white,
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
