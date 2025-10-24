import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_tashkent_client/bloc/login/login_bloc.dart';
import 'package:go_tashkent_client/onboards/onboard_thrid.dart';
import 'package:go_tashkent_client/screens/nav_bar.dart';
import 'package:go_tashkent_client/screens/otp/page/otp.dart';
import 'package:go_tashkent_client/screens/register/page/Register.dart';
import 'package:go_tashkent_client/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () async  {
              final prefs = await   SharedPreferences.getInstance();

              await prefs.setBool('auth', false);
              Navigator.pushNamed(context, '/');
            },
            child: Text(
              'Next'.tr(),
              style: const TextStyle(
                color: Color(0xFFFF7625),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),

      // 🔥 BlocConsumer bilan o‘ralgan UI
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            success: (data) {
              final cleanedNumber = phoneController.text
                  .replaceAll('-', '');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      OtpInputScreen(phoneNumber: cleanedNumber),
                ),
              );
            },
            failure: (error) {
              if (error.status == 'notfound_user') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NameInputScreen(
                      phoneNumber: phoneController.text
                          .replaceAll('-', ''),
                    ),
                  ),
                );
              } else {
                CustomSnackBar.showError(context, error.message);
              }
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SvgPicture.asset('assets/icons/logo.svg'),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SvgPicture.asset('assets/icons/onboard 2.svg'),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Входить'.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Номер телефона'.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixText: '+998 ',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Продолжая, вы принимаете условия пользовательского соглашения и политики конфиденциальности'
                        .tr(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // 🔥 Blocga ulangan pastki button
      bottomNavigationBar: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return GestureDetector(
            onTap: isLoading
                ? null
                : () async {
              final phone = phoneController.text.replaceAll('-', '');
              if (phone.isEmpty || phone.length < 9) {
                CustomSnackBar.showError(context, 'Введите номер телефона'.tr());
                return;
              }
              final prefs = await   SharedPreferences.getInstance();

              // 🔹 auth qiymatini false qilib saqlash
              await prefs.setBool('auth', true);
              context.read<LoginBloc>().add(LoginEvent.started(phone: phone));
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFF7625),
              ),
              child: Center(
                child: isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
                    : Text(
                  'Далее'.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
