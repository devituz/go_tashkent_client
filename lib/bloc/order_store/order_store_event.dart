part of 'order_store_bloc.dart';

@freezed
class OrderStoreEvent with _$OrderStoreEvent {
  const factory OrderStoreEvent.order({
    required int fromWheresId,
    required int whereTosId,
    required double latitude,
    required double longitude,
    required String where,
    String? time,
    String? day,
    int? passengersCount,
    int? frontSeat,
    int? bagaj,
    String? toDriverComment,
    String? orderType,
    String? receiverName,
    String? receiverAddress,
    String? receiverPhone,
    String? priceType,
    int? price,
    String? lang,
  }) = _Order;
}

