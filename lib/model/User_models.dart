import 'package:meta/meta.dart';
import 'dart:convert';

class User {
  final String message;
  final UserClass user;

  User({
    required this.message,
    required this.user,
  });

  User copyWith({
    String? message,
    UserClass? user,
  }) =>
      User(
        message: message ?? this.message,
        user: user ?? this.user,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    message: json["message"],
    user: UserClass.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
  };
}

class UserClass {
  final String fullname;
  final String phone;
  final String createdAt;

  UserClass({
    required this.fullname,
    required this.phone,
    required this.createdAt,
  });

  UserClass copyWith({
    String? fullname,
    String? phone,
    String? createdAt,
  }) =>
      UserClass(
        fullname: fullname ?? this.fullname,
        phone: phone ?? this.phone,
        createdAt: createdAt ?? this.createdAt,
      );

  factory UserClass.fromRawJson(String str) => UserClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    fullname: json["fullname"],
    phone: json["phone"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "phone": phone,
    "created_at": createdAt,
  };
}
