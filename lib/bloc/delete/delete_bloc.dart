  import 'package:bloc/bloc.dart';
  import 'package:freezed_annotation/freezed_annotation.dart';
  import 'package:go_tashkent_client/services/auth_service.dart';
  import 'package:go_tashkent_client/services/global_service.dart';

  part 'delete_event.dart';
  part 'delete_state.dart';
  part 'delete_bloc.freezed.dart';

  class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
    final AuthService _authService;

    DeleteBloc({AuthService? authService})
        : _authService = authService ?? AuthService(),
          super(const DeleteState.initial()) {
      on<_DeleteUser>(_onDeleteUser);
    }

    Future<void> _onDeleteUser(
        _DeleteUser event, Emitter<DeleteState> emit) async {
      emit(const DeleteState.loading());
      try {
        await _authService.deleteClientUser(lang: currentLang);

        emit(const DeleteState.success());
        globalLogout();
      } catch (e) {
        if (e is ApiException) {
          emit(DeleteState.failure(e));
        } else {
          emit(DeleteState.failure(ApiException(e.toString())));
        }
      }
    }
  }
