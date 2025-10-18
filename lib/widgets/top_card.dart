import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_tashkent_client/utils/distance_helper.dart';
import 'package:marquee/marquee.dart';

class TopCard extends StatelessWidget {
  const TopCard({
    Key? key,
    required this.name,
    required this.about,
    required this.adres,
    required this.onTap,
    required this.top_obloshka,
    required this.logo,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  final String name;
  final String about;
  final String adres;
  final String top_obloshka;
  final String latitude;
  final String longitude;
  final String logo;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final bool hasTopImage = top_obloshka.isNotEmpty &&
        (top_obloshka.startsWith('http://') ||
            top_obloshka.startsWith('https://'));

    return InkWell(
      onTap: onTap,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: hasTopImage ? Colors.yellow[100] : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            if (hasTopImage)
              SizedBox(
                width: size.width,
                height: size.width / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: top_obloshka,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),
            if (hasTopImage) SizedBox(height: size.width / 70),
            Container(
              height: size.width / 4.5,
              width: size.width,
              decoration: BoxDecoration(
                color: hasTopImage ? Colors.yellow[100] : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔹 Logo
                  Container(
                    height: size.width / 5,
                    width: size.width / 5,
                    margin: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: logo,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ),

                  // 🔹 Matnlar
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width / 1.9,
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: "PFDinDisplay",
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
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
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      SizedBox(
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
                                text: adres.isEmpty ? "no address" : adres,
                                style: const TextStyle(fontSize: 12),
                                blankSpace: 10,
                                velocity: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: size.width / 4,
                    width: size.width / 8,
                    child: Center(
                      child: FutureBuilder<double>(
                        future: getDistanceOnce( // 👈 stream o‘rniga future ishlatyapti
                          latitude: latitude,
                          longitude: longitude,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text("...");
                          }
                          final distance = snapshot.data ?? 0.0;
                          return Text(
                            "${distance.toStringAsFixed(1)} km",
                            style: const TextStyle(color: Colors.blue),
                          );
                        },
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
