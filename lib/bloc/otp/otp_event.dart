part of 'otp_bloc.dart';

@freezed
class OtpEvent with _$OtpEvent {
  const factory OtpEvent.verifyOtp({
    required String phone,
    required String code,
  }) = _VerifyOtp;
}
