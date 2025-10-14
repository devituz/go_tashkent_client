import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_tashkent_client/model/User_models.dart';
import 'package:go_tashkent_client/services/auth_service.dart';
import 'package:go_tashkent_client/services/global_service.dart';


  part 'profile_event.dart';
  part 'profile_state.dart';
  part 'profile_bloc.freezed.dart';

  class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
    final AuthService _authService;

    ProfileBloc({AuthService? authService})
        : _authService = authService ?? AuthService(),
          super(const ProfileState.initial()) {
      on<_Profile>(_onProfile);
    }

    Future<void> _onProfile(_Profile event, Emitter<ProfileState> emit) async {
      emit(const ProfileState.loading());
      try {

        final result = await _authService.clientUser(
          lang: currentLang
        );
        emit(ProfileState.success(result));
        print(result.toJson());
      } catch (e) {
        // print(e);

        if (e is ApiException) {
          print(e);
          emit(ProfileState.failure(e));
        } else {
          print(e);

          emit(ProfileState.failure(ApiException(e.toString())));
        }
      }
    }


  }
