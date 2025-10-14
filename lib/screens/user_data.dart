import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_tashkent_client/services/global_service.dart';

import 'settings.dart';

class UserData extends StatefulWidget {
  const UserData({
    Key? key,
  }) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
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
            "Личные данные".tr(),
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
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Имя".tr(),
                    style: TextStyle(
                      color: currentindex == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: currentindex == 0
                        ? Colors.black12
                        : const Color(0xFF43324D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Бобир",
                    style: TextStyle(
                      color: currentindex == 0 ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Номер телефона".tr(),
                    style: TextStyle(
                      color: currentindex == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: currentindex == 0
                        ? Colors.black12
                        : const Color(0xFF43324D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "+998332000363",
                    style: TextStyle(
                      color: currentindex == 0 ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Дата регистрации".tr(),
                    style: TextStyle(
                      color: currentindex == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: currentindex == 0
                        ? Colors.black12
                        : const Color(0xFF43324D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "29.01.2025",
                    style: TextStyle(
                      color: currentindex == 0 ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width / 2.2,
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        color: currentindex == 0
                            ? Colors.black12
                            : const Color(0xFF43324D),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.no_accounts_sharp,
                              color: currentindex == 0
                                  ? Colors.orange
                                  : Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: (){
                                print("object");
                                globalLogout();
                              },


                              child: Text(
                                "Выйти с аккаунта".tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: currentindex == 0
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: size.width / 2.2,
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        color: currentindex == 0
                            ? Colors.black12
                            : const Color(0xFF43324D),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_forever,
                              color: currentindex == 0
                                  ? Colors.orange
                                  : Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Удалить аккаунт".tr(),
                              style: TextStyle(
                                fontSize: 12,
                                color: currentindex == 0
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
