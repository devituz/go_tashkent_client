import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../settings.dart';

class CurrentPochta extends StatelessWidget {
  const CurrentPochta({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: currentindex == 0
          ? const Color(0xFFF2F4F5)
          : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor: currentindex == 0
            ? Colors.white
            : const Color(0xFF43324D),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.3, color: Colors.black38),
            ),
          ),
        ),
        title: Text(
          "Выберите тип почты".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/zakaz_pochta_melkiy');
              },
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              child: Container(
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: currentindex == 0
                      ? Colors.white
                      : const Color(0xFF43324D),
                  border: Border.all(
                    width: 0.3,
                    color: currentindex == 0
                        ? Colors.black54
                        : Colors.transparent,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Мелкогабаритные почты".tr(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: currentindex == 0
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      dropdownValue == 1
                          ? Text(
                              '''· Телефон, наушники, часы, ключи
· Косметика, мелкая одежда (футболка, платок, носки)
· Книга, тетрадь, ручка
· Ювелирные изделия, брелок, очки'''
                                  .tr(),
                              style: TextStyle(
                                fontSize: 12,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            )
                          : Text(
                              '''· Telefon, naushniklar, soatlar, kalitlar
Kosmetika, kichik kiyim (futbolka, sharf, paypoq)
Kitob, daftar, qalam
Zargarlik buyumlari, kalit zanjirlar, ko'zoynaklar'''
                                  .tr(),
                              style: TextStyle(
                                fontSize: 12,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                      const SizedBox(height: 15),
                      dropdownValue == 1
                          ? Text(
                              '''В целом: предметы, помещающиеся в сумку или маленькую коробку'''
                                  .tr(),
                              style: TextStyle(
                                fontSize: 12,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            )
                          : Text(
                              '''Umuman olganda: sumka yoki kichik qutiga mos keladigan narsalar'''
                                  .tr(),
                              style: TextStyle(
                                fontSize: 12,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                      const SizedBox(height: 15),
                      dropdownValue == 1
                          ? Text(
                              '''Цена: 50 000 сум'''.tr(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            )
                          : Text(
                              '''Narxi: 50 000 so'm'''.tr(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                      const SizedBox(height: 15),
                      Container(
                        height: 30,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7625),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Выбрать'.tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/zakaz_pochta_krupniy');
              },
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              child: Container(
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: currentindex == 0
                      ? Colors.white
                      : const Color(0xFF43324D),
                  border: Border.all(
                    width: 0.3,
                    color: currentindex == 0
                        ? Colors.black54
                        : Colors.transparent,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Крупногабаритные почты".tr(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: currentindex == 0
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      dropdownValue == 1
                          ? Text(
                              '''· Большой чемодан, много одежды, одеяло-подушка
· Бытовая техника (телевизор, микроволновая печь и т.д.)
· Мебель, ковёр, велосипед
· Большие коробки или тяжёлые вещи''',
                              style: TextStyle(
                                fontSize: 12,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            )
                          : Text(
                              '''· Katta chamadon, ko'p kiyim, adyol / yostiq
· Maishiy texnika (televizor, mikroto'lqinli pech va boshqalar)
· Mebel, gilam, velosiped
· Katta qutilar yoki og'ir narsalar''',
                              style: TextStyle(
                                fontSize: 12,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                      const SizedBox(height: 15),
                      dropdownValue == 1
                          ? Text(
                              '''В целом: предметы, которые не помещаются в сумку или слишком тяжёлые''',
                              style: TextStyle(
                                fontSize: 12,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            )
                          : Text(
                              '''Umuman olganda: sumkaga sig'maydigan yoki juda og'ir narsalar''',
                              style: TextStyle(
                                fontSize: 12,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                      const SizedBox(height: 15),
                      dropdownValue == 1
                          ? Text(
                              '''Цена: Договорная''',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            )
                          : Text(
                              '''Narxi: Kelishiladi''',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                      const SizedBox(height: 15),
                      Container(
                        height: 30,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7625),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Выбрать'.tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
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
