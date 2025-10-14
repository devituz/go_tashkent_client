import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:go_tashkent_client/screens/nav_bar.dart';

import '../../../bloc/login/login_bloc.dart';
import '../../../bloc/otp/otp_bloc.dart';
import '../../../widgets/custom_snackbar.dart';

class OtpInputScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpInputScreen({super.key, required this.phoneNumber});

  @override
  State<OtpInputScreen> createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isButtonEnabled = false;
  int _secondsRemaining = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _otpController.addListener(_validateOtp);
    _startCountdown();
  }

  @override
  void dispose() {
    _otpController.removeListener(_validateOtp);
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _validateOtp() {
    final isValid = _otpController.text.trim().length == 4;
    if (isValid != _isButtonEnabled) {
      setState(() => _isButtonEnabled = isValid);
    }
  }

  void _startCountdown() {
    _secondsRemaining = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _onVerify() {
    final otp = _otpController.text.trim();
    final phone = widget.phoneNumber.replaceAll(RegExp(r'\D'), '');

    context.read<OtpBloc>().add(OtpEvent.verifyOtp(phone: phone, code: otp));
  }

  void _onResend() {
    final phone = widget.phoneNumber.replaceAll(RegExp(r'\D'), '');
    context.read<LoginBloc>().add(LoginEvent.started(phone: phone));
    _startCountdown();
  }

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
              Center(child: SvgPicture.asset('assets/icons/logo.svg')),
              const SizedBox(height: 50),
              Center(child: SvgPicture.asset('assets/icons/onboard 3.svg')),
              const SizedBox(height: 50),
              Center(
                child: Text(
                  'Введите код из СМС'.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  Center(
                    child: Text(
                      'Отправили код на номер: '.tr(),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.phoneNumber,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),

              // === OTP INPUT ===
              Center(
                child: SizedBox(
                  width: 240,
                  child: TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 8),
                    decoration: InputDecoration(
                      hintText: '••••',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // === TIMER yoki RESEND ===
              Center(
                child: _secondsRemaining > 0
                    ? Text(
                  'Отправить код заново: 0:${_secondsRemaining.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                      fontSize: 14, color: Colors.grey),
                )
                    : TextButton(
                  onPressed: _onResend,
                  child: Text(
                    'Отправить код заново'.tr(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFF7625),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // === NEXT BUTTON ===
      bottomNavigationBar: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (_) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavBar(),
                ),
                    (route) => false,
              );
            },
            failure: (e) => CustomSnackBar.showError(context, e.message),
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return GestureDetector(
            onTap: _isButtonEnabled && !isLoading ? _onVerify : null,
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _isButtonEnabled && !isLoading
                    ? const Color(0xFFFF7625)
                    : Colors.grey.shade400,
              ),
              child: Center(
                child: isLoading
                    ? const SizedBox(
                  height: 22,
                  width: 22,
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
