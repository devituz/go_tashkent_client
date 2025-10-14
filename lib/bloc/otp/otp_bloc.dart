import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../services/auth_service.dart';
import '../../services/global_service.dart';
import '../../services/token_storage.dart';

part 'otp_event.dart';
part 'otp_state.dart';
part 'otp_bloc.freezed.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final AuthService _authService;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  OtpBloc({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(const OtpState.initial()) {
    on<_VerifyOtp>(_onVerifyOtp);
  }

  Future<void> _onVerifyOtp(_VerifyOtp event, Emitter<OtpState> emit) async {
    emit(const OtpState.loading());
    try {
      final result = await _authService.verifyOtp(
        phone: event.phone,
        code: event.code,
        lang: "ru",
      );



      emit(OtpState.success(result));

      if (result is Map && result['token'] != null) {
        await TokenStorage.saveToken(result['token']);
      }

    } catch (e) {
      if (e is ApiException) {
        emit(OtpState.failure(e));
      } else {
        emit(OtpState.failure(ApiException(e.toString())));
      }
    }
  }
}
