part of 'order_cencel_bloc.dart';

@freezed
class OrderCencelEvent with _$OrderCencelEvent {
  const factory OrderCencelEvent.cancel({
    required int orderId,
  }) = _Cancel;}
