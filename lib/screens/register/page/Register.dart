import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_tashkent_client/screens/otp/page/otp.dart';

import '../../../bloc/register/register_bloc.dart';
import '../../../widgets/custom_snackbar.dart';

class NameInputScreen extends StatefulWidget {
  final String phoneNumber;

  const NameInputScreen({super.key, required this.phoneNumber});

  @override
  _NameInputScreenState createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
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
                  'Зарегистрироваться'.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  'Чтобы продолжить введите имя и\nномер вашего телефона'.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Ваше имя'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
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
      ),
      bottomNavigationBar: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            success: (_) {
              // ✅ Ro‘yxatdan o‘tish muvaffaqiyatli → OTP sahifasiga o‘tish
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OtpInputScreen(
                    phoneNumber: widget.phoneNumber,
                  ),
                ),
              );
            },
            failure: (error) {
              CustomSnackBar.showError(context, error.message);
            },
          );
        },
        builder: (context, state) {
          final isLoading =
          state.maybeWhen(loading: () => true, orElse: () => false);

          return GestureDetector(
            onTap: isLoading
                ? null
                : () {
              final name = nameController.text.trim();
              if (name.isEmpty) {
                CustomSnackBar.showError(
                    context, "Ismingizni kiriting".tr());
                return;
              }

              // 🔥 BLoC event yuborish
              context.read<RegisterBloc>().add(
                RegisterEvent.register(
                  firstName: name,
                  phone: widget.phoneNumber,
                ),
              );
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
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
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
