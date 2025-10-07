import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_tashkent_client/widgets/order_card_active.dart';
import '../widgets/home/home_button.dart';
import '../widgets/home/home_slider.dart';
import '../widgets/order_card.dart';
import 'settings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: currentindex == 0
          ? Colors.white
          : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor: currentindex == 0
            ? Colors.white
            : const Color(0xFF43324D),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.3, color: Colors.black38),
            ),
          ),
        ),
        scrolledUnderElevation: 0,
        title: SizedBox(
          width: size.width / 2.2,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: currentindex == 0
                ? SvgPicture.asset('assets/icons/logo.svg')
                : SvgPicture.asset('assets/icons/logo dark.svg'),
          ),
        ),
        toolbarHeight: 70,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 16),
            const HomeSlider(),
            const SizedBox(height: 16),

            // DRIVER QIDIRSH PAYTIDA
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: OrderCardActive(),
            // ),

            // DRIVER TANLAGANDAN SO'NG
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: OrderCard(
            //     type: "ТАКСИ",
            //     driver: "Азимов Бобур",
            //     car: "белый NEXIA 3",
            //     licensePlate: "01 Q 363 KJ",
            //     date: "18.01.2025, 14:30",
            //     from: "Ташкент",
            //     to: "Бекабад",
            //     price: "70 000",
            //   ),
            // ),
            HomeButton(
              category: 'ТАКСИ',
              description: 'Закажите такси легко!\nВсего в пару кликов!',
              image: 'assets/images/Gentra 2.png',
              onTap: () {
                Navigator.pushNamed(context, '/zakaz_taxi');
              },
            ),
            HomeButton(
              category: 'ПОЧТОВАЯ ПОСЫЛКА',
              description:
                  'Отправляйте посылки быстро\nи удобно – в любое время!',
              image: 'assets/images/Cobalt 2.png',
              onTap: () {
                Navigator.pushNamed(context, '/current_pochta');
              },
            ),
            HomeButton(
              category: 'ГРУЗОПЕРЕВОЗКИ',
              description: 'Доставка грузов\nбыстро и надежно',
              image: 'assets/images/Labo 2.png',
              onTap: () {
                Navigator.pushNamed(context, '/zakaz_gruz');
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
