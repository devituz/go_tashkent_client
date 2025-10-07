import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../screens/settings.dart';

class CardCompany extends StatelessWidget {
  const CardCompany(
      {Key? key,
      required this.name,
      required this.about,
      required this.adres,
      // required this.logo,

      required this.onTap})
      : super(key: key);

  final String name;
  final String about;
  final String adres;
  // final Image logo;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        width: size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width / 5.4,
              height: size.width / 5.4,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/Medion_logo.png',
                    fit: BoxFit.cover,
                  )
                  // ? Image.asset(
                  //     'assets/images/banner.png',
                  //     fit: BoxFit.cover,
                  //   )
                  // : CachedNetworkImage(
                  //     imageUrl: '',
                  //     placeholder: (context, url) => Image.asset(
                  //       'assets/images/placeholder_logo2.png',
                  //       fit: BoxFit.cover,
                  //     ),
                  //     errorWidget: (context, url, error) => Image.asset(
                  //       'assets/images/banner.png',
                  //       fit: BoxFit.cover,
                  //     ),
                  //     fit: BoxFit.cover,
                  //   ),
                  ),
            ),
            SizedBox(
              width: size.width / 40,
            ),
            SizedBox(
              width: size.width / 1.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width / 2,
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: currentindex == 0 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: size.width / 1.9,
                    // height: size.width / 14,
                    child: Text(
                      about,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: currentindex == 0
                            ? const Color.fromARGB(117, 0, 0, 0)
                            : const Color.fromARGB(150, 255, 255, 255),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: size.width / 30,
                    width: size.width / 2,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_sharp,
                          size: 12,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: size.width / 2.3,
                          // height: size.width / 30,
                          child: Marquee(
                            // ! check
                            text: adres.isEmpty ? "no address" : adres,
                            style: TextStyle(
                              fontSize: 12,
                              color: currentindex == 0
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            fadingEdgeStartFraction: 0,
                            fadingEdgeEndFraction: 0.2,
                            blankSpace: 10,
                            velocity: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width / 10,
              child: Center(
                child: Text(
                  "155 km",
                  style: const TextStyle(
                    color: Color(0xFF2081F9),
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
