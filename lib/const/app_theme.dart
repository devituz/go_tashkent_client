import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  // Asosiy ranglar
  static const Color primaryColor = Color(0xFFFF7625);
  static const Color gradinet1 = Color(0xFFFF7625);
  static const Color gradinet2 = Color(0xFFFF7625);
  static const Color gradinet3 = Color(0xFFFFFFFF);

  // static const Color primaryColor = Color(0xFF2F3291); // Jettaxi sariq rangi
  // static const Color gradinet1 = Color(0xFF4A54E1);
  // static const Color gradinet2 = Color(0xFF2F3291);


  // Fon ranglari
  static const Color backgroundColor = Color(0xFFF5F5F5); // Fon rangi
  static const Color containerBackgroundColor = Color(0xFFF9FFF0); // Yengil yashil fon variant
  static const Color container2BackgroundColor = Color(0xFFF0FFF4); // Fresh variant

  // Matn ranglari
  static const Color textColor = Color(0xFF1A1A1A); // Qora matn
  static const Color secondaryTextColor = Color(0xFF4D4D4D); // Ikkinchi darajali qora

  // Ikonlar va aksent
  static const Color accentColor = Color(0xFF76FF03); // Yashil aksent
  static const Color shadowColor = Color(0x22000000); // Yumshoq qora soya

  // Tugmalar
  static const Color disabledButtonColor = Color(0xFFB0B0B0); // Faol bo‘lmagan tugma

  static const double defaultPadding = 20.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultFontSize = 15.0;
  static const double defaultIconFontSize = 25.0;
  static const double titleFontSize = 24.0;

  static ButtonStyle elevatedButtonStyle({required bool isEnabled}) {
    return ElevatedButton.styleFrom(
      backgroundColor: isEnabled ? primaryColor : disabledButtonColor,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      textStyle: const TextStyle(
        fontSize: defaultFontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  static InputDecoration inputDecoration({String? hintText}) {
    return InputDecoration(
      prefixIcon: hintText == "95-279-88-99"
          ?  Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "+998",
              style: GoogleFonts.inter(
                fontSize: defaultFontSize,
                fontWeight: FontWeight.w600,
                color: secondaryTextColor,
              ),
            ),
            SizedBox(width: 8),
            Text(
              "|",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: defaultFontSize,
                color: secondaryTextColor,
              ),
            ),
          ],
        ),
      )
          : null,
      hintText: hintText ?? "",
      hintStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: AppTheme.secondaryTextColor.withOpacity(0.5),
      ),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
    );
  }

  static BoxDecoration inputContainerDecoration = BoxDecoration(
    color: Colors.white,

    borderRadius: BorderRadius.circular(defaultBorderRadius),
    boxShadow: [
      BoxShadow(
        color: shadowColor.withOpacity(0.1),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  );
}