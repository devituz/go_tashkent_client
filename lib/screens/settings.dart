import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/button_settings.dart';
import 'splash_screen.dart';

int currentindex = 0;
int dropdownValue = 1;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static const indexKey = "ChangeIndexKey";
  static const indexKey2 = "ChangeIndexKey2";

  @override
  void initState() {
    initIndex();
    super.initState();
  }

  void initIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentindex = (prefs.getInt(indexKey) ?? 0);
      dropdownValue = (prefs.getInt(indexKey2) ?? 1);
    });
  }

  void changeIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    if (currentindex != index) {
      setState(() {
        currentindex = index;
        prefs.setInt(indexKey, currentindex);
      });

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const SplashScreen()));
    }
  }

  void changeIndex2(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      dropdownValue = index;
      prefs.setInt(indexKey2, dropdownValue);
    });
  }

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
          "Профиль".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: currentindex == 0 ? Colors.black : Colors.white,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: size.width / 40,
            // ),
            // ButtonSettings(
            //   icon: Icons.info,
            //   text: 'О приложении'.tr(),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/about_app');
            //   },
            // ),
            SizedBox(height: size.width / 40),
            ButtonSettings(
              icon: 'assets/icons/personalcard.svg',
              text: "Личные данные",
              onTap: () {
                Navigator.pushNamed(context, '/user_data');
              },
            ),
            ButtonSettings(
              icon: 'assets/icons/document-like.svg',
              text: "О приложение",
              onTap: () {
                Navigator.pushNamed(context, '/about_app');
              },
            ),
            ButtonSettings(
              icon: 'assets/icons/lock.svg',
              text: "Политика конфиденциальности",
              onTap: () {},
            ),
            ButtonSettings(
              icon: 'assets/icons/direct-send.svg',
              text: "Поделиться",
              onTap: () {},
            ),
            ButtonSettings(
              icon: 'assets/icons/document-like.svg',
              text: "Onboard 1",
              onTap: () {
                Navigator.pushNamed(context, '/onboard_first');
              },
            ),
            ButtonSettings(
              icon: 'assets/icons/document-like.svg',
              text: "Onboard 2",
              onTap: () {
                Navigator.pushNamed(context, '/onboard_second');
              },
            ),
            ButtonSettings(
              icon: 'assets/icons/document-like.svg',
              text: "Onboard 3",
              onTap: () {
                Navigator.pushNamed(context, '/onboard_thrid');
              },
            ),
            ButtonSettings(
              icon: 'assets/icons/document-like.svg',
              text: "Ваш заказ принять",
              onTap: () {
                Navigator.pushNamed(context, '/order_accept');
              },
            ),

            ButtonSettings(
              icon: 'assets/icons/phone.svg',
              text: 'Свяжитесь с нами'.tr(),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Контакты".tr()),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.phone,
                                  color: const Color(0xFFFF7625),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text('+99833 200 0363'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.mail,
                                  color: const Color(0xFFFF7625),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text('info@gotashkent.uz'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 30,
                              child: Center(child: Text("Закрыть".tr())),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Настройки".tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: currentindex == 0
                      ? const Color.fromARGB(255, 20, 20, 20)
                      : Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: currentindex == 0
                    ? Colors.white
                    : const Color(0xFF43324D),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/global.svg',
                        color: currentindex == 0
                            ? const Color(0xFFFF7625)
                            : Colors.white,
                      ),
                      SizedBox(width: size.width / 30),
                      Text(
                        'Изменить язык'.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          color: currentindex == 0
                              ? const Color.fromARGB(255, 20, 20, 20)
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: currentindex == 0
                          ? Colors.white
                          : const Color(0xFF43324D),
                      value: dropdownValue,
                      borderRadius: BorderRadius.circular(12),
                      items: [
                        DropdownMenuItem(
                          value: 1,
                          onTap: () {
                            changeIndex2(1);
                            setState(() {
                              context.setLocale(const Locale('ru'));
                              dropdownValue = 1;
                            });
                          },
                          child: Container(
                            height: size.width / 15,
                            padding: const EdgeInsets.only(top: 5, right: 5),
                            child: Text(
                              "🇷🇺  Русский",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: currentindex == 0
                                    ? const Color.fromARGB(255, 20, 20, 20)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          onTap: () {
                            changeIndex2(2);
                            setState(() {
                              context.setLocale(const Locale('uz'));
                              dropdownValue = 2;
                            });
                          },
                          child: Container(
                            height: size.width / 15,
                            padding: const EdgeInsets.only(top: 5, right: 5),
                            child: Text(
                              "🇺🇿  O'zbekcha",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: currentindex == 0
                                    ? const Color.fromARGB(255, 20, 20, 20)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                      onChanged: (dynamic t) {
                        setState(() {
                          dropdownValue = t;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: currentindex == 0
                    ? Colors.white
                    : const Color(0xFF43324D),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/sun.svg',
                        color: currentindex == 0
                            ? const Color(0xFFFF7625)
                            : Colors.white,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Тема приложения'.tr(),
                        style: TextStyle(
                          fontFamily: 'PFDinDisplay',
                          fontSize: 16,
                          color: currentindex == 0
                              ? const Color.fromARGB(255, 20, 20, 20)
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: currentindex == 0
                          ? Colors.white
                          : const Color(0xFF43324D),
                      value: currentindex,
                      borderRadius: BorderRadius.circular(12),
                      items: [
                        DropdownMenuItem(
                          value: 0,
                          onTap: () {
                            changeIndex(0);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.light_mode,
                                color: currentindex == 0
                                    ? const Color.fromARGB(255, 20, 20, 20)
                                    : Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Светлая".tr(),
                                style: TextStyle(
                                  color: currentindex == 0
                                      ? const Color.fromARGB(255, 20, 20, 20)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          onTap: () {
                            changeIndex(1);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.dark_mode,
                                color: currentindex == 0
                                    ? const Color.fromARGB(255, 20, 20, 20)
                                    : Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Темная".tr(),
                                style: TextStyle(
                                  color: currentindex == 0
                                      ? const Color.fromARGB(255, 20, 20, 20)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (dynamic t) {
                        setState(() {
                          currentindex = t;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
