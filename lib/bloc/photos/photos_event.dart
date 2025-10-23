part of 'photos_bloc.dart';

@freezed
class PhotosEvent with _$PhotosEvent {
  const factory PhotosEvent.photo({
    required String photoType,
  }) = _Photos;}
