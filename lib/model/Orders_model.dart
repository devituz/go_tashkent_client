import 'dart:convert';

class OrdersModel {
  final String? status;
  final List<Datum>? data;

  OrdersModel({
    this.status,
    this.data,
  });

  OrdersModel copyWith({
    String? status,
    List<Datum>? data,
  }) =>
      OrdersModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory OrdersModel.fromRawJson(String str) =>
      OrdersModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    status: json["status"],
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final int? id;
  final String? driverName;
  final String? carName;
  final String? carNumber;
  final int? fromWheresId;
  final String? orderType;
  final String? status;
  final int? whereTosId;
  final int? passengersCount;
  final num? price;
  final num? totalPrice;
  final String? createdAt;

  Datum({
    this.id,
    this.driverName,
    this.carName,
    this.carNumber,
    this.fromWheresId,
    this.orderType,
    this.status,
    this.whereTosId,
    this.passengersCount,
    this.price,
    this.totalPrice,
    this.createdAt,
  });

  Datum copyWith({
    int? id,
    String? driverName,
    String? carName,
    String? carNumber,
    int? fromWheresId,
    String? orderType,
    String? status,
    int? whereTosId,
    int? passengersCount,
    num? price,
    num? totalPrice,
    String? createdAt,
  }) =>
      Datum(
        id: id ?? this.id,
        driverName: driverName ?? this.driverName,
        carName: carName ?? this.carName,
        carNumber: carNumber ?? this.carNumber,
        fromWheresId: fromWheresId ?? this.fromWheresId,
        orderType: orderType ?? this.orderType,
        status: status ?? this.status,
        whereTosId: whereTosId ?? this.whereTosId,
        passengersCount: passengersCount ?? this.passengersCount,
        price: price ?? this.price,
        totalPrice: totalPrice ?? this.totalPrice,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    driverName: json["driver_name"] ?? '',
    carName: json["car_name"] ?? '',
    carNumber: json["car_number"] ?? '',
    fromWheresId: json["from_wheres_id"],
    orderType: json["order_type"],
    status: json["status"] ?? '',
    whereTosId: json["where_tos_id"],
    passengersCount: json["passengers_count"],
    price: json["price"] ?? 0,
    totalPrice: json["total_price"] ?? 0,
    createdAt: json["created_at"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "driver_name": driverName,
    "car_name": carName,
    "car_number": carNumber,
    "from_wheres_id": fromWheresId,
    "order_type": orderType,
    "status": status,
    "where_tos_id": whereTosId,
    "passengers_count": passengersCount,
    "price": price,
    "total_price": totalPrice,
    "created_at": createdAt,
  };
}
