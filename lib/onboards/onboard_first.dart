import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardFirst extends StatefulWidget {
  const OnboardFirst({
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardFirst> createState() => _OnboardFirstState();
}

class _OnboardFirstState extends State<OnboardFirst> {
  String _selectedLanguage = 'O‘zbekcha';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SvgPicture.asset('assets/icons/logo.svg'),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: SvgPicture.asset('assets/icons/onboard 1.svg'),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Tilni tanlang / Выберите язык',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 0.3),
                  ),
                  child: RadioListTile(
                    value: 'O‘zbekcha',
                    groupValue: _selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value.toString();
                      });
                    },
                    title: const Text("🇺🇿  O'zbekcha",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 0.3),
                  ),
                  child: RadioListTile(
                    value: 'Русский',
                    groupValue: _selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value.toString();
                      });
                    },
                    title: const Text("🇷🇺  Русский",
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFFF7625),
        ),
        child: Center(
          child: Text(
            'Далее'.tr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
