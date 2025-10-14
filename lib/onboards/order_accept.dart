import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/settings.dart';

class OrderAccept extends StatefulWidget {
  const OrderAccept({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderAccept> createState() => _OrderAcceptState();
}

class _OrderAcceptState extends State<OrderAccept> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SvgPicture.asset('assets/icons/logo.svg'),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: SvgPicture.asset('assets/icons/order acccept.svg'),
          ),
          const SizedBox(
            height: 50,
          ),
          dropdownValue == 1
              ? Text(
                  'Ваш заказ принят!'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              : Text(
                  'Sizning buyurtmangiz qabul qilindi'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: dropdownValue == 1
                ? Text(
                    textAlign: TextAlign.center,
                    'Мы уже начали искать подходящего водителя для вас. Это займет всего несколько минут. Как только водитель будет найден, мы сразу сообщим вам его данные и время прибытия. Спасибо, что выбрали наш сервис! 😊'
                        .tr(),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                : Text(
                    textAlign: TextAlign.center,
                    'Biz allaqachon siz uchun mos haydovchi qidirishni boshladik. Bu bir necha daqiqa vaqt oladi. Haydovchi topilishi bilan biz darhol uning tafsilotlari va yetib kelish vaqti haqida xabar beramiz. Xizmatimizni tanlaganingiz uchun tashakkur! 😊'
                        .tr(),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFFF7625),
          ),
          child: Center(
            child: Text(
              'На главную'.tr(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
