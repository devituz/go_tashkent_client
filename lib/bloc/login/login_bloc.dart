
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_tashkent_client/services/auth_service.dart';

import '../../services/global_service.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthService _authService;


  LoginBloc({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(const LoginState.initial()) {


    on<_Started>(_onStarted);

  }

  Future<void> _onStarted(_Started event, Emitter<LoginState> emit) async {
    emit(const LoginState.loading());
    try {
      final result = await _authService.login(
        phone: event.phone,
        lang: "ru",
      );
      emit(LoginState.success(result));
    } catch (e) {
      if (e is ApiException) {
        print(e);
        emit(LoginState.failure(e));
      } else {
        emit(LoginState.failure(ApiException(e.toString())));
        print(e);
      }
    }
  }

}
