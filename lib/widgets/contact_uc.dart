import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/settings.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTapfun,
  }) : super(key: key);

  final String icon;
  final String text;
  final void Function()? onTapfun;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTapfun,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Container(
        width: size.width,
        height: size.width / 8,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(
              width: size.width / 30,
            ),
            SizedBox(
              width: size.width / 1.4,
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  color: currentindex == 0 ? Colors.black : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
