import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_tashkent_client/screens/home_page.dart';
import 'package:go_tashkent_client/screens/login/page/login.dart';
import 'package:go_tashkent_client/services/token_storage.dart';

import 'nav_bar.dart';
import 'settings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();

    // Asinxron ishni boshqa methodga ajratamiz
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));

    bool isLoggedIn = await TokenStorage.hasToken();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => isLoggedIn
            ? const NavBar()
            : const LoginPage(),
      ),
          (Route<dynamic> route) => false,
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors
            .transparent, // добавьте это свойство, чтобы сделать StatusBar прозрачным
        statusBarBrightness:
            currentindex == 0 ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            currentindex == 0 ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness
            .light, // добавьте это свойство, чтобы установить иконки StatusBar на темном фоне
      ),
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: SizedBox(
                    width: size.width / 1.8,
                    height: 60,
                    child: SvgPicture.asset(
                      'assets/icons/logo.svg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// class SplashScreen extends StatelessWidget {
//   const SplashScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     Future.delayed(const Duration(seconds: 3)).then((value) =>
//         Navigator.pushAndRemoveUntil(context,
//             MaterialPageRoute(builder: (_) => const Home()), (route) => false));
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SizedBox(
//           width: size.width,
//           height: size.height,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: size.width / 1.8,
//                 child:
//                     Image.asset('assets/images/Educationbox_logo_splash2.png'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
