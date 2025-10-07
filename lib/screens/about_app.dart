import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'settings.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: currentindex == 0
            ? const Color(0xFFF2F4F5)
            : const Color(0xFF33263C),
        appBar: AppBar(
          backgroundColor:
              currentindex == 0 ? Colors.white : const Color(0xFF43324D),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              width: 0.3,
              color: Colors.black38,
            ))),
          ),
          title: Text(
            "О приложение".tr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: currentindex == 0 ? Colors.black : Colors.white,
            ),
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: currentindex == 0 ? Colors.black : Colors.white,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.width / 2,
                  width: size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/banner 5.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width / 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: dropdownValue == 1
                      ? Text('''
Наше приложение — это ваш надежный помощник в поездках и поиске нужных мест в Ташкенте и его окрестностях.

Возможности приложения:

Заказ такси

 - Легко заказывайте такси из Бекабада в Ташкент или обратно всего в несколько кликов.
 - Удобный интерфейс для выбора маршрута.
 - Поддержка безопасных и надежных перевозчиков.
 - Поиск мест в Ташкенте

 - Быстро находите клиники, гостиницы, университеты, рестораны, кафе и другие заведения.
 - Детальная информация о каждом месте: адрес, контактные данные, график работы и отзывы пользователей.
 - Удобный фильтр по категориям и расстоянию.
 - Простота и удобство

Современный и интуитивно понятный интерфейс.
Интеграция с картами для удобной навигации.
Быстрая регистрация и возможность сохранять избранные места.
С нашим приложением вы можете не только организовать поездку между Ташкентом и Бекабадом, но и легко находить любые заведения, которые сделают ваше пребывание в Ташкенте комфортным и насыщенным.

Скачайте наше приложение уже сегодня и откройте для себя удобство и скорость во всем!'''
                          .tr(), style: TextStyle(
                            fontSize: 14,
                            color:
                                currentindex == 0 ? Colors.black : Colors.white,
                          ),)
                      : Text(
                          '''
Bizning ilovamiz Toshkent va uning atrofida sayohat qilish va kerakli joylarni topishda ishonchli yordamchingizdir.

Ilova xususiyatlari:

Taksi buyurtma qilish

 - Bir necha marta bosish orqali Bekoboddan Toshkentga yoki orqaga taksiga osongina buyurtma bering.
 - Marshrutni tanlash uchun qulay interfeys.
 - Xavfsiz va ishonchli tashuvchilarni qo'llab-quvvatlash.
 - Toshkentdagi joylarni qidiring

 - Klinikalar, mehmonxonalar, universitetlar, restoranlar, kafelar va boshqa muassasalarni tezda toping.
 - Har bir joy haqida batafsil ma'lumot: manzil, aloqa ma'lumotlari, ish vaqti va foydalanuvchi sharhlari.
 - Kategoriya va masofa bo'yicha qulay filtr.
 - Oddiylik va qulaylik

Zamonaviy va intuitiv interfeys.
Oson navigatsiya uchun xaritalar bilan integratsiya.
Tez ro'yxatdan o'tish va sevimli joylarni saqlash imkoniyati.
Bizning ilovamiz orqali siz nafaqat Toshkent va Bekobod oʻrtasida sayohat tashkil qilishingiz, balki Toshkentda boʻlishingizni qulay va koʻngilochar qilish imkonini beradigan istalgan muassasalarni osongina topishingiz mumkin.

Bugun bizning ilovamizni yuklab oling va hamma narsada qulaylik va tezlikni toping!'''
                              .tr(),
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                currentindex == 0 ? Colors.black : Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
