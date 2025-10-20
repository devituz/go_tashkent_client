part of 'orders_bloc.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState.initial() = _Initial;
  const factory OrdersState.loading() = _Loading;
  const factory OrdersState.success(OrdersModel profile) = _Success;
  const factory OrdersState.failure(ApiException error) = _Failure;
}
