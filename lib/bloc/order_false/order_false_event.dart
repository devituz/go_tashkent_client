part of 'order_false_bloc.dart';

@freezed
class OrderFalseEvent with _$OrderFalseEvent {
  const factory OrderFalseEvent.orders({
    @Default(false) bool active,
  }) = _Orders;}
