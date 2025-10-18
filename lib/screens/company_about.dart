import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_tashkent_client/model/Addresses_models.dart';
import 'package:go_tashkent_client/screens/settings.dart';
import 'package:go_tashkent_client/utils/distance_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/contact_uc.dart';

class AboutCompany extends StatelessWidget {
  final Datum item;

  const AboutCompany({super.key, required this.item});


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
          item.name,
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
              margin:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              height: size.width / 2.1,
              width: size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: size.width / 2.1,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: (item.obloshka ?? []).map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                    ),
                  );
                }).toList(),
              ),
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
                      item.name,
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
                          item.address.toString(),
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
                  FutureBuilder<double>(
                    future: getDistanceOnce(
                      latitude: item.latitude.toString(),
                      longitude: item.longitude.toString(),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("...");
                      }

                      final distance = snapshot.data ?? 0.0;
                      return Text(
                        "${distance.toStringAsFixed(1)} km",
                        style: const TextStyle(
                          overflow: TextOverflow.fade,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF2081F9),
                        ),
                      );
                    },
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
                    item.desc.toString(),
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
              text: item.pochta.toString(),
            ),
            ContactUs(
              onTapfun: () async {},
              icon: 'assets/icons/web.svg',
              text:item.site.toString(),
            ),
            ContactUs(
              onTapfun: () async {},
              icon: 'assets/icons/facebook.svg',
              text: item.facebook.toString(),
            ),
            ContactUs(
              onTapfun: () async {},
              icon: 'assets/icons/instagram.svg',
              text: item.instagram.toString(),
            ),
            ContactUs(
              onTapfun: () async {},
              icon: 'assets/icons/telegram.svg',
              text: item.telegram.toString(),
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
                String phone = item.telefon.toString()
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
              onTap: () async {
                final double? lat = double.tryParse(item.latitude.toString());
                final double? lng = double.tryParse(item.longitude.toString());
                final String name = item.name ?? '';

                if (lat == null || lng == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Manzil koordinatalari mavjud emas')),
                  );
                  return;
                }

                // 🗺 Google Maps uchun URL yaratamiz
                final Uri googleMapsUri = Uri.parse(
                  'https://www.google.com/maps/search/?api=1&query=$lat,$lng($name)',
                );

                // 🔹 Google Maps ilovasini ochishga urinish
                final Uri nativeUri = Uri(
                  scheme: 'geo',
                  host: '0,0',
                  queryParameters: {'q': '$lat,$lng($name)'},
                );

                try {
                  if (await canLaunchUrl(nativeUri)) {
                    await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
                  } else {
                    await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Google Map ni ochib bo‘lmadi: $e')),
                  );
                }
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
                    const Icon(Icons.location_on_sharp, color: Colors.white),
                    SizedBox(width: size.width / 60),
                    Expanded(
                      child: Text(
                        'Показать на карте'.tr(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
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
