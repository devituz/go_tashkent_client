part of 'photos_bloc.dart';

@freezed
class PhotosState with _$PhotosState {
  const factory PhotosState.initial() = _Initial;
  const factory PhotosState.loading() = _Loading;
  const factory PhotosState.success(PhotosModel profile) = _Success;
  const factory PhotosState.failure(ApiException error) = _Failure;
}
