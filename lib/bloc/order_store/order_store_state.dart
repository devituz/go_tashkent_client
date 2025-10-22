part of 'order_store_bloc.dart';

@freezed
class OrderStoreState with _$OrderStoreState {
  const factory OrderStoreState.initial() = _Initial;
  const factory OrderStoreState.loading() = _Loading;
  const factory OrderStoreState.success(Map<String, dynamic> data) = _Success;
  const factory OrderStoreState.failure(ApiException error) = _Failure;
}
