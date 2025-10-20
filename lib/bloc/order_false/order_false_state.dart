part of 'order_false_bloc.dart';

@freezed
class OrderFalseState with _$OrderFalseState {
  const factory OrderFalseState.initial() = _Initial;
  const factory OrderFalseState.loading() = _Loading;
  const factory OrderFalseState.success(OrdersModel profile) = _Success;
  const factory OrderFalseState.failure(ApiException error) = _Failure;
}
