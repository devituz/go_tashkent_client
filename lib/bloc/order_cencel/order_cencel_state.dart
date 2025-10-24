part of 'order_cencel_bloc.dart';

@freezed
class OrderCencelState with _$OrderCencelState {
  const factory OrderCencelState.initial() = _Initial;
  const factory OrderCencelState.loading() = _Loading;
  const factory OrderCencelState.success() = _Success;
  const factory OrderCencelState.failure(ApiException error) = _Failure;
}
