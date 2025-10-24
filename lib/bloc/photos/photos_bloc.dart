import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_tashkent_client/model/Photos_model.dart';
import 'package:go_tashkent_client/services/global_service.dart';
import 'package:go_tashkent_client/services/photos_service.dart';

part 'photos_event.dart';
part 'photos_state.dart';
part 'photos_bloc.freezed.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotosService _photosService;

  PhotosBloc({PhotosService? photoService})
      : _photosService = photoService ?? PhotosService(),
        super(const PhotosState.initial()) {
    on<_Photos>(_onPhoto);
  }

  Future<void> _onPhoto(_Photos event, Emitter<PhotosState> emit) async {
    emit(const PhotosState.loading());
    try {

      final result = await _photosService.Photos(
        photoType: event.photoType,
          lang: currentLang
      );
      emit(PhotosState.success(result));
      // print(result.toJson());
    } catch (e) {
      if (e is ApiException) {
        // print(e);
        emit(PhotosState.failure(e));
      } else {
        // print(e);

        emit(PhotosState.failure(ApiException(e.toString())));
      }
    }
  }

}
