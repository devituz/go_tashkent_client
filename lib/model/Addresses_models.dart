import 'package:meta/meta.dart';
import 'dart:convert';

class AddressModel {
  final String status;
  final List<Datum> data;

  AddressModel({
    required this.status,
    required this.data,
  });

  AddressModel copyWith({
    String? status,
    List<Datum>? data,
  }) =>
      AddressModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory AddressModel.fromRawJson(String str) => AddressModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
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
  final int categoryId;
  final String name;
  final String? desc;
  final String? address;
  final String? logo;
  final List<String>? obloshka;
  final String? topObloshka;
  final String? site;
  final String? pochta;
  final String? facebook;
  final String? instagram;
  final String? telegram;
  final String? telefon;
  final String? latitude;
  final String? longitude;
  final bool active;
  final String? createdAt;

  Datum({
    required this.id,
    required this.categoryId,
    required this.name,
    this.desc,
    this.address,
    this.logo,
    this.obloshka,
    this.topObloshka,
    this.site,
    this.pochta,
    this.facebook,
    this.instagram,
    this.telegram,
    this.telefon,
    this.latitude,
    this.longitude,
    required this.active,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"] ?? '',
    desc: json["desc"],
    address: json["address"],
    logo: json["logo"],
    obloshka: json["obloshka"] != null
        ? List<String>.from(json["obloshka"].map((x) => x))
        : [],
    topObloshka: json["top_obloshka"],
    site: json["site"],
    pochta: json["pochta"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    telegram: json["telegram"],
    telefon: json["telefon"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    active: json["active"] ?? false,
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "desc": desc,
    "address": address,
    "logo": logo,
    "obloshka": obloshka ?? [],
    "top_obloshka": topObloshka,
    "site": site,
    "pochta": pochta,
    "facebook": facebook,
    "instagram": instagram,
    "telegram": telegram,
    "telefon": telefon,
    "latitude": latitude,
    "longitude": longitude,
    "active": active,
    "created_at": createdAt,
  };
}

