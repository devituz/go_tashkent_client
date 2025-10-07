import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../screens/settings.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 18,
        fontFamily: 'PFDinDisplay',
        color: Color.fromARGB(255, 75, 75, 75),
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          size: 25,
          color: Color.fromARGB(69, 0, 0, 0),
        ),
        hintText: "Поиск".tr(),
        fillColor: currentindex == 0
            ? const Color.fromARGB(255, 255, 255, 255)
            : const Color.fromARGB(193, 234, 244, 250),
        filled: true,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }
}
