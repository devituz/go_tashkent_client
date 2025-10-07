import 'package:flutter/material.dart';

import '../screens/settings.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: TextField(
        style: const TextStyle(
          fontFamily: "PFDinDisplay",
          fontSize: 16,
          color: Color.fromARGB(221, 39, 39, 39),
        ),
        decoration: InputDecoration(
          hintText: text,
          fillColor: currentindex == 0
              ? Colors.white
              : const Color.fromARGB(197, 255, 255, 255),
          filled: true,
          prefixIcon: Icon(icon),
          contentPadding: const EdgeInsets.fromLTRB(12.0, 0.0, 10.0, 12.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
