import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../services/auth_service.dart';
import '../../services/global_service.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService _authService;

  RegisterBloc({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(const RegisterState.initial()) {
    on<_Register>(_onRegister);
  }


  Future<void> _onRegister(_Register event, Emitter<RegisterState> emit) async {
    emit(const RegisterState.loading());
    try {
      final result = await _authService.register(
        firstName: event.firstName,
        phone: event.phone,
        lang: "ru",
      );
      emit(RegisterState.success(result));
    } catch (e) {
      if (e is ApiException) {
        emit(RegisterState.failure(e));
      } else {
        emit(RegisterState.failure(ApiException(e.toString())));
      }
    }
  }
}
