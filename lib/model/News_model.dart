import 'package:meta/meta.dart';
import 'dart:convert';

// GENERATED CODE - DO NOT MODIFY BY HAND

class NewsModel {
  final String status;
  final List<Data> data;

  NewsModel({required this.status, required this.data, });

  NewsModel copyWith({
    String? status,
    List<Data>? data,
  }) => NewsModel(
    status: status ?? this.status,
    data: data ?? this.data,
  );

  factory NewsModel.fromRawJson(String str) => NewsModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    status: json['status'],
    data: json['data'] == null ? [] : List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.map((x) => x is Map ? x : (x as dynamic).toJson()).toList(),
  };
}


class Data {
  final int id;
  final String image;
  final String desc;
  final String link;
  final String createdTime;

  Data({required this.id, required this.image, required this.desc, required this.link, required this.createdTime, });

  Data copyWith({
    int? id,
    String? image,
    String? desc,
    String? link,
    String? createdTime,
  }) => Data(
    id: id ?? this.id,
    image: image ?? this.image,
    desc: desc ?? this.desc,
    link: link ?? this.link,
    createdTime: createdTime ?? this.createdTime,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'],
    image: json['image'],
    desc: json['desc'],
    link: json['link'],
    createdTime: json['createdTime'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'desc': desc,
    'link': link,
    'createdTime': createdTime,
  };
}


