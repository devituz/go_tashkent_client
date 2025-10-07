import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class TopCard extends StatelessWidget {
  const TopCard({
    Key? key,
    required this.name,
    required this.about,
    required this.adres,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String about;
  final String adres;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.width / 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/banner.png',
                    fit: BoxFit.fill,
                  )
                  // ? Image.asset(
                  //     'assets/images/placeholder_logo.png',
                  //     fit: BoxFit.fill,
                  //   )
                  // : CachedNetworkImage(
                  //     imageUrl:
                  //         '',
                  //     placeholder: (context, url) => Image.asset(
                  //       'assets/images/placeholder_logo.png',
                  //       fit: BoxFit.cover,
                  //     ),
                  //     errorWidget: (context, url, error) => Image.asset(
                  //       'assets/images/placeholder_logo.png',
                  //       fit: BoxFit.cover,
                  //     ),
                  //     fit: BoxFit.cover,
                  //   ),
                  ),
            ),
            SizedBox(
              height: size.width / 70,
            ),
            Container(
              height: size.width / 4.5,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: size.width / 5,
                    width: size.width / 5,
                    margin: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/Medion_logo.png',
                          fit: BoxFit.fill,
                        )
                        // ? Image.asset('assets/images/placeholder_logo2.png')
                        // : CachedNetworkImage(
                        //     imageUrl:
                        //         '${Constants.imageUrl}${place.placeLogo}',
                        //     placeholder: (context, url) => Image.asset(
                        //       'assets/images/placeholder_logo2.png',
                        //       fit: BoxFit.cover,
                        //     ),
                        //     errorWidget: (context, url, error) => Image.asset(
                        //       'assets/images/placeholder_logo2.png',
                        //       fit: BoxFit.cover,
                        //     ),
                        //     fit: BoxFit.cover,
                        //   ),
                        ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 0),
                        width: size.width / 1.9,
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: "PFDinDisplay",
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 2,
                        child: Text(
                          about,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "PFDinDisplay",
                              fontSize: 12,
                              color: Colors.grey[600]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: SizedBox(
                          height: size.width / 30,
                          width: size.width / 1.9,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_sharp,
                                color: Colors.red,
                                size: 15,
                              ),
                              SizedBox(
                                height: size.width / 25,
                                width: size.width / 2.3,
                                child: Marquee(
                                  // ! check
                                  text: adres.isEmpty ? "no address" : adres,
                                  style: const TextStyle(
                                    fontSize: 12,
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.width / 4,
                    width: size.width / 8,
                    child: Center(
                      child: Text(
                        "175 km",
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
