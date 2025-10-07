import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home_page.dart';
import 'news.dart';
import 'orders.dart';
import 'place.dart';
import 'settings.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Orders(),
    Place(),
    News(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor:
          currentindex == 0 ? const Color(0xFFF2F4F5) : const Color(0xFF33263C),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.3, color: Colors.black38),
          ),
        ),
        child: BottomNavigationBar(
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              currentindex == 0 ? Colors.white : const Color(0xFF43324D),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? SvgPicture.asset(
                      'assets/icons/home.svg',
                      color: currentindex == 0
                          ? const Color(0xFFFF7625)
                          : Colors.white,
                    )
                  : SvgPicture.asset(
                      'assets/icons/home.svg',
                      color: const Color(0xFF949494),
                    ),
              label: 'Главная'.tr(),
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? SvgPicture.asset(
                      'assets/icons/orders.svg',
                      color: currentindex == 0
                          ? const Color(0xFFFF7625)
                          : Colors.white,
                    )
                  : SvgPicture.asset(
                      'assets/icons/orders.svg',
                      color: const Color(0xFF949494),
                    ),
              label: 'Заказы'.tr(),
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? SvgPicture.asset(
                      'assets/icons/location.svg',
                      color: currentindex == 0
                          ? const Color(0xFFFF7625)
                          : Colors.white,
                    )
                  : SvgPicture.asset(
                      'assets/icons/location.svg',
                      color: const Color(0xFF949494),
                    ),
              label: "Адреса".tr(),
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? SvgPicture.asset(
                      'assets/icons/news.svg',
                      color: currentindex == 0
                          ? const Color(0xFFFF7625)
                          : Colors.white,
                    )
                  : SvgPicture.asset(
                      'assets/icons/news.svg',
                      color: const Color(0xFF949494),
                    ),
              label: 'Новости'.tr(),
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 4
                  ? SvgPicture.asset(
                      'assets/icons/account.svg',
                      color: currentindex == 0
                          ? const Color(0xFFFF7625)
                          : Colors.white,
                    )
                  : SvgPicture.asset(
                      'assets/icons/account.svg',
                      color: const Color(0xFF949494),
                    ),
              label: 'Профиль'.tr(),
            ),
          ],
          selectedItemColor:
              currentindex == 0 ? const Color(0xFFFF7625) : Colors.white,
          unselectedItemColor: const Color(0xFF949494),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
