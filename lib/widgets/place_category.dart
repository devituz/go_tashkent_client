import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../screens/settings.dart';

class PlaceCategory extends StatelessWidget {
  const PlaceCategory({
    super.key,
    required this.category,
    required this.text,
    required this.image,
    this.onTap,
  });
  final String category;
  final String text;
  final String image;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16),
        color: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.tr(),
                    style: TextStyle(
                      height: 1.1,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: currentindex == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    text.tr(),
                    style: TextStyle(
                      fontSize: 10,
                      color: currentindex == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.width / 4.8,
                width: size.width / 3.5,
                child: Image.asset(
                  image,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
