import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width,
        height: size.width / 2.1,
        child: ImageSlideshow(
          initialPage: Random().nextInt(100),
          indicatorColor: Colors.transparent,
          indicatorBackgroundColor: Colors.transparent,
          onPageChanged: (value) {},
          autoPlayInterval: 6000,
          isLoop: true,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/banner 5.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/banner 5.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
