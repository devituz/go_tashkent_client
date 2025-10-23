import 'dart:convert';

class PhotosModel {
  final String status;
  final List<Datum> data;

  PhotosModel({
    required this.status,
    required this.data,
  });

  PhotosModel copyWith({
    String? status,
    List<Datum>? data,
  }) =>
      PhotosModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory PhotosModel.fromRawJson(String str) => PhotosModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotosModel.fromJson(Map<String, dynamic> json) => PhotosModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String image;

  Datum({
    required this.id,
    required this.image,
  });

  Datum copyWith({
    int? id,
    String? image,
  }) =>
      Datum(
        id: id ?? this.id,
        image: image ?? this.image,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}
