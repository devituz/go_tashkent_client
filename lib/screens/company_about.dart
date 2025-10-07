import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_tashkent_client/screens/settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/contact_uc.dart';

class AboutCompany extends StatefulWidget {
  const AboutCompany({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutCompany> createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  get isFavorite => false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:
          currentindex == 0 ? const Color(0xFFF2F4F5) : const Color(0xFF33263C),
      appBar: AppBar(
        backgroundColor:
            currentindex == 0 ? Colors.white : const Color(0xFF43324D),
        elevation: 0,
        title: Text(
          "Darmonmed",
          style: TextStyle(
              color: currentindex == 0 ? Colors.black : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
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
          IconButton(
            onPressed: () {},
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite
                  ? Colors.red
                  : (currentindex == 0 ? Colors.black : Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: currentindex == 0 ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 6,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              height: size.width / 2.1,
              width: size.width,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/banner.png', fit: BoxFit.cover,)),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color:
                    currentindex == 0 ? Colors.white : const Color(0xFF43324D),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_city,
                    color: Color(0xFF2081F9),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: size.width / 1.3,
                    child: Text(
                      "Darmon med",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color:
                              currentindex == 0 ? Colors.black : Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color:
                    currentindex == 0 ? Colors.white : const Color(0xFF43324D),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_sharp,
                        color: Colors.red,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        width: size.width / 1.7,
                        child: Text(
                          "Ташкент",
                          style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color:
                                currentindex == 0 ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '155 km',
                    maxLines: 1,
                    style: const TextStyle(
                      overflow: TextOverflow.fade,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF2081F9),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              width: size.width,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color:
                    currentindex == 0 ? Colors.white : const Color(0xFF43324D),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Совремменная клиника с новим оборудованием",
                    style: TextStyle(
                        fontSize: 16,
                        color: currentindex == 0 ? Colors.black : Colors.white),
                  ),
                ],
              ),
            ),
            ContactUs(
              onTapfun: () {},
              icon: 'assets/icons/mail.svg',
              text: 'darmonmed@gmail.com',
            ),
            ContactUs(
              onTapfun: () async {},
              icon: 'assets/icons/web.svg',
              text: "www.darmonmed.com",
            ),
            ContactUs(
              onTapfun: () async {},
              icon: 'assets/icons/facebook.svg',
              text: 'facebook.com/darmonmed',
            ),
            ContactUs(
              onTapfun: () async {},
              icon: 'assets/icons/instagram.svg',
              text: 'instagram.com/darmonmed',
            ),
            ContactUs(
              onTapfun: () async {},
              icon: 'assets/icons/telegram.svg',
              text: "t.me/darmonmed",
            ),
            const SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(13),
        // height: size.width / 4.5,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                String phone = "+998901317377"
                    .replaceAll('-', '')
                    .replaceAll(' ', '')
                    .replaceAll('(', '')
                    .replaceAll(')', '')
                    .replaceAll(';', '');

                final Uri url = Uri(
                  scheme: 'tel',
                  path: phone,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.only(bottom: 10),
                height: size.width / 8,
                width: size.width / 2.2,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7625),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: size.width / 60,
                    ),
                    Text(
                      'Позвонить'.tr(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              // onTap: () async {
              //   final query =
              //       '${widget.place.placeLat},${widget.place.placeAlt},${widget.place.placeTitle})';
              //   final uri = Uri(
              //       scheme: 'geo', host: '0,0', queryParameters: {'q': query});
              //   await launchUrlString(uri.toString(),
              //       mode: LaunchMode.externalApplication);
              // },

              onTap: () async {
                final query = '';
                final fallbackUrl = Uri(
                  scheme: 'https',
                  host: 'www.google.com',
                  path: '/maps/search/',
                  queryParameters: {'api': '1', 'query': query},
                ).toString();
                // ignore: deprecated_member_use
                await launch(fallbackUrl);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.only(bottom: 10),
                height: size.width / 8,
                width: size.width / 2.2,
                decoration: BoxDecoration(
                  color: const Color(0xFFC63434),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_sharp,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: size.width / 60,
                    ),
                    Expanded(
                      child: Text(
                        'Показать на карте'.tr(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
