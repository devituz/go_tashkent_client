import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_tashkent_client/onboards/onboard.second.dart';
import 'package:go_tashkent_client/onboards/onboard_first.dart';
import 'package:go_tashkent_client/onboards/onboard_thrid.dart';
import 'package:go_tashkent_client/onboards/order_accept.dart';
import 'package:go_tashkent_client/screens/about_app.dart';
import 'package:go_tashkent_client/screens/company_about.dart';
import 'package:go_tashkent_client/screens/nav_bar.dart';
import 'package:go_tashkent_client/screens/place%20screens/clinics.dart';
import 'package:go_tashkent_client/screens/place%20screens/edu.dart';
import 'package:go_tashkent_client/screens/place%20screens/hotels.dart';
import 'package:go_tashkent_client/screens/place%20screens/restaurants.dart';
import 'package:go_tashkent_client/screens/user_data.dart';
import 'package:go_tashkent_client/screens/zakaz/zakaz_gruzoperevozki.dart';
import 'package:go_tashkent_client/screens/zakaz/current_pochta.dart';
import 'package:go_tashkent_client/screens/zakaz/zakaz_pochta_krupniy.dart';
import 'package:go_tashkent_client/screens/zakaz/zakaz_pochta_melkiy.dart';
import 'package:go_tashkent_client/screens/zakaz/zakaz_taksi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/codegen_loader.g.dart';
import 'screens/home_page.dart';
import 'screens/settings.dart';
import 'screens/splash_screen.dart';
import 'screens/zakaz/zakaz_pustoy.dart';

const indexKey = "ChangeIndexKey";
const indexKey2 = "ChangeIndexKey2";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  currentindex = (prefs.getInt(indexKey) ?? 0);
  dropdownValue = (prefs.getInt(indexKey2) ?? 1);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ru'), Locale('uz'), Locale('en')],
      saveLocale: true,
      path: 'assets/translations/',
      fallbackLocale: const Locale('ru'),
      startLocale: const Locale('ru'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (context) => const NavBar(),
      '/splash_screen': (context) => const SplashScreen(),
      '/clinics': (context) => const Clinics(),
      '/restaurant': (context) => const RestaurantPage(),
      '/hotels': (context) => const Hotels(),
      '/edu': (context) => const EduPage(),
      '/about_app': (context) => const AboutApp(),
      '/about_company': (context) => const AboutCompany(),
      '/user_data': (context) => const UserData(),
      '/zakaz_taxi': (context) => const ZakazTaxi(),
      '/zakaz_pochta_melkiy': (context) => const ZakazPochtaMelkiy(),
      '/zakaz_pochta_krupniy': (context) => const ZakazPochtaKrupniy(),
      '/zakaz_gruz': (context) => const ZakazGruzoperevozki(),
      '/zakaz_pustoy': (context) => const ZakazPustoy(),
      '/onboard_first': (context) => const OnboardFirst(),
      '/onboard_second': (context) => const OnboardSecond(),
      '/onboard_thrid': (context) => const OnboardThrid(),
      '/order_accept': (context) => const OrderAccept(),
      '/current_pochta': (context) => const CurrentPochta(),

      // '/about_app': (context) => const AboutApp(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: '/splash_screen',
      routes: routes,
      theme: ThemeData(fontFamily: 'MTSSANS'),
    );
  }
}
