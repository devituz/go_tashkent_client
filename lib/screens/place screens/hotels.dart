import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/card_company.dart';
import '../../widgets/top_card.dart';
import '../settings.dart';

class Hotels extends StatefulWidget {
  const Hotels({
    Key? key,
  }) : super(key: key);

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
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
          ))),
        ),
        title: Text(
          "Гостиницы и хостелы".tr(),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.search,
                  color: currentindex == 0 ? Colors.black : Colors.white,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CardCompany(
              name: 'Дармон Мед',
              about: "Совремменная клиника с новим оборудованием",
              adres: "Ташкент",
              onTap: () {
                Navigator.pushNamed(context, '/about_company');
              },
            ),
            TopCard(
              name: 'Дармон Мед',
              about: "Совремменная клиника с новим оборудованием",
              adres: "Ташкент",
              onTap: () {
                Navigator.pushNamed(context, '/about_company');
              },
            ),
            CardCompany(
              name: 'Дармон Мед',
              about: "Совремменная клиника с новим оборудованием",
              adres: "Ташкент",
              onTap: () {
                Navigator.pushNamed(context, '/about_company');
              },
            ),
            CardCompany(
              name: 'Дармон Мед',
              about: "Совремменная клиника с новим оборудованием",
              adres: "Ташкент",
              onTap: () {
                Navigator.pushNamed(context, '/about_company');
              },
            ),
            CardCompany(
              name: 'Дармон Мед',
              about: "Совремменная клиника с новим оборудованием",
              adres: "Ташкент",
              onTap: () {
                Navigator.pushNamed(context, '/about_company');
              },
            ),
            TopCard(
              name: 'Дармон Мед',
              about: "Совремменная клиника с новим оборудованием",
              adres: "Ташкент",
              onTap: () {
                Navigator.pushNamed(context, '/about_company');
              },
            ),
            CardCompany(
              name: 'Дармон Мед',
              about: "Совремменная клиника с новим оборудованием",
              adres: "Ташкент",
              onTap: () {
                Navigator.pushNamed(context, '/about_company');
              },
            ),
            TopCard(
              name: 'Дармон Мед',
              about: "Совремменная клиника с новим оборудованием",
              adres: "Ташкент",
              onTap: () {
                Navigator.pushNamed(context, '/about_company');
              },
            ),
          ],
        ),
      ),
    );
  }
}
