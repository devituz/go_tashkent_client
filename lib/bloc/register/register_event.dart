part of 'register_bloc.dart';


@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.register({
    required String firstName,
    required String phone,
  }) = _Register;
}