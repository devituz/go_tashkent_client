import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_tashkent_client/widgets/news_form.dart';

import 'settings.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          currentindex == 0 ? const Color(0xFFF2F4F5) : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor:
            currentindex == 0 ? Colors.white : const Color(0xFF43324D),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: 0.3,
            color: Colors.black38,
          ))),
        ),
        title: Text(
          "Новости".tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
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
            NewsForm(
                text:
                    "⚡️Rasman: Qishki ta’tili 25-dekabrdan 7-yanvargacha davom etadi!\n\nO‘zbekistonda OTM talabalari, texnikum, kollej va akademik lisey o‘quvchilari uchun qishki ta’til 25-dekabrdan boshlanadi va 2025-yilning 7-yanvarigacha davom etadi",
                subtext: "https://t.me/eduuz/28701",
                widget: Image.asset('assets/images/news 1.jpg'),
                createdTime: "26.01.2025"),
            NewsForm(
                text:
                    "⚡️Rasman: Qishki ta’tili 25-dekabrdan 7-yanvargacha davom etadi!\n\nO‘zbekistonda OTM talabalari, texnikum, kollej va akademik lisey o‘quvchilari uchun qishki ta’til 25-dekabrdan boshlanadi va 2025-yilning 7-yanvarigacha davom etadi",
                subtext: "https://t.me/eduuz/28701",
                widget: Image.asset('assets/images/news 1.jpg'),
                createdTime: "26.01.2025"),
            NewsForm(
                text:
                    "⚡️Rasman: Qishki ta’tili 25-dekabrdan 7-yanvargacha davom etadi!\n\nO‘zbekistonda OTM talabalari, texnikum, kollej va akademik lisey o‘quvchilari uchun qishki ta’til 25-dekabrdan boshlanadi va 2025-yilning 7-yanvarigacha davom etadi",
                subtext: "https://t.me/eduuz/28701",
                widget: Image.asset('assets/images/news 1.jpg'),
                createdTime: "26.01.2025"),
          ],
        ),
      ),
    );
  }
}
