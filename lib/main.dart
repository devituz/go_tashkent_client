import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_tashkent_client/bloc/delete/delete_bloc.dart';
import 'package:go_tashkent_client/bloc/login/login_bloc.dart';
import 'package:go_tashkent_client/bloc/news/news_bloc.dart';
import 'package:go_tashkent_client/bloc/order_false/order_false_bloc.dart';
import 'package:go_tashkent_client/bloc/order_store/order_store_bloc.dart';
import 'package:go_tashkent_client/bloc/orders/orders_bloc.dart';
import 'package:go_tashkent_client/bloc/otp/otp_bloc.dart';
import 'package:go_tashkent_client/bloc/profile/profile_bloc.dart';
import 'package:go_tashkent_client/bloc/register/register_bloc.dart';
import 'package:go_tashkent_client/onboards/onboard.second.dart';
import 'package:go_tashkent_client/onboards/onboard_first.dart';
import 'package:go_tashkent_client/onboards/onboard_thrid.dart';
import 'package:go_tashkent_client/onboards/order_accept.dart';
import 'package:go_tashkent_client/screens/about_app.dart';
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
import 'bloc/addresses/addresses_bloc.dart';
import 'generated/codegen_loader.g.dart';
import 'screens/settings.dart';
import 'screens/splash_screen.dart';
import 'screens/zakaz/zakaz_pustoy.dart';

const indexKey = "ChangeIndexKey";
const indexKey2 = "ChangeIndexKey2";
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late final String appVersion;

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
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LoginBloc()),
            BlocProvider(create: (_) => OtpBloc()),
            BlocProvider(create: (_) => RegisterBloc()),
            BlocProvider(create: (_) => ProfileBloc()),
            BlocProvider(create: (_) => DeleteBloc()),
            BlocProvider(create: (_) => NewsBloc()),
            BlocProvider(create: (_) => AddressesBloc()),
            BlocProvider(create: (_) => OrdersBloc()),
            BlocProvider(create: (_) => OrderFalseBloc()),
            BlocProvider(create: (_) => OrderStoreBloc()),
          ],
          child: const MyApp(),
        )
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
      // '/about_company': (context) => const AboutCompany(),
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
      navigatorKey: navigatorKey,
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
