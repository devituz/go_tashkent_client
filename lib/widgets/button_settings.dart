import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/settings.dart';

class ButtonSettings extends StatelessWidget {
  const ButtonSettings({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String icon;
  final String text;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Container(
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: currentindex == 0 ? Colors.white : const Color(0xFF43324D),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  color: currentindex == 0
                      ? const Color(0xFFFF7625)
                      : Colors.white,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  text.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    color: currentindex == 0 ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              'assets/icons/arrow-right.svg',
              color: currentindex == 0 ? const Color(0xFFFF7625) : Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
