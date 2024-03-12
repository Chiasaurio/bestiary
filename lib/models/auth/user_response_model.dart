// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

UserResponseModel userFromJson(String str) =>
    UserResponseModel.fromJson(json.decode(str));

String userToJson(UserResponseModel data) => json.encode(data.toJson());

class UserResponseModel extends UserModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserResponseModel(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required super.email,
      required super.password});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };
}
