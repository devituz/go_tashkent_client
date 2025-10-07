import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_tashkent_client/widgets/home/place_slider.dart';

import '../widgets/place_category.dart';
import 'settings.dart';

class Place extends StatelessWidget {
  const Place({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        scrolledUnderElevation: 0,
        title: Text(
          "Адреса".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            PlaceSlider(),
            SizedBox(
              height: 10,
            ),
            PlaceCategory(
              category: 'Клиники и\nцентры диагностики',
              text: 'Найдите ближайшие клиники\nи диагностические центры!',
              image: 'assets/images/hospital.png',
              onTap: () {
                Navigator.pushNamed(context, '/clinics');
              },
            ),
            PlaceCategory(
              category: 'Кафе и\nрестораны',
              text: 'Быстро находите, где вкусно перекусить!',
              image: 'assets/images/restaurant.png',
              onTap: () {
                Navigator.pushNamed(context, '/restaurant');
              },
            ),
            PlaceCategory(
              category: 'Гостиницы и\nхостелы',
              text:
                  'Лучшие гостиницы и хостелы\nс подробным описанием, контактами.',
              image: 'assets/images/hotel.png',
              onTap: () {
                Navigator.pushNamed(context, '/hotels');
              },
            ),
            PlaceCategory(
              category: 'Университеты и\nинституты',
              text:
                  'Cписок университетов и институтов\nс актуальной информацией.',
              image: 'assets/images/edu.png',
              onTap: () {
                Navigator.pushNamed(context, '/edu');
              },
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
