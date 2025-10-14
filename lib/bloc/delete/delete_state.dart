part of 'delete_bloc.dart';

@freezed
class DeleteState with _$DeleteState {
  const factory DeleteState.initial() = _Initial;
  const factory DeleteState.loading() = _Loading;
  const factory DeleteState.success() = _Success;
  const factory DeleteState.failure(ApiException error) = _Failure;
}
