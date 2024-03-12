// To parse this JSON data, do
//
//     final CollectableCardModel = CollectableCardModelFromJson(jsonString);

// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// CollectableCardModel collectableCardModelFromJson(String str) =>
//     CollectableCardModel.fromJson(json.decode(str));

// String collectableCardModelToJson(CollectableCardModel data) =>
//     json.encode(data.toJson());

class CollectableCardModel {
  final String? commonName;
  final String scientificName;
  final String? breed;
  final String? habitat;
  final String? weight;
  final String? sex;
  final String? curiousInformation;

  CollectableCardModel({
    this.commonName,
    this.breed,
    required this.scientificName,
    this.habitat,
    this.weight,
    this.sex,
    this.curiousInformation,
  });

  factory CollectableCardModel.fromJson(Map<String, dynamic> json) =>
      CollectableCardModel(
        breed: json["breed"],
        commonName: json["name"],
        scientificName: json["scientific_name"],
        habitat: json["habitat"],
        weight: json["regular_weight"],
        sex: json["possible_sex"],
        curiousInformation: json["curious_information"],
      );

  Map<String, dynamic> toJson() => {
        "breed": breed,
        "name": commonName,
        "scientific_name": scientificName,
        "habitat": habitat,
        "regular_weight": weight,
        "possible_sex": sex,
        "curious_information": curiousInformation,
      };

  CollectableCardModel copyWith({
    String? breed,
    String? commonName,
    String? scientificName,
    String? habitat,
    String? weight,
    String? sex,
    String? curiousInformation,
  }) {
    return CollectableCardModel(
      commonName: commonName ?? this.commonName,
      scientificName: scientificName ?? this.scientificName,
      breed: breed ?? this.breed,
      habitat: habitat ?? this.habitat,
      weight: weight ?? this.weight,
      sex: sex ?? this.sex,
      curiousInformation: curiousInformation ?? this.curiousInformation,
    );
  }
}

class CollectableCardFirebaseModel extends CollectableCardModel {
  final String? id;
  final String userId;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CollectableCardFirebaseModel({
    this.id,
    required this.userId,
    super.commonName,
    super.breed,
    required super.scientificName,
    super.habitat,
    super.weight,
    super.sex,
    super.curiousInformation,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory CollectableCardFirebaseModel.fromJson(
          Map<String, dynamic> json, String id) =>
      CollectableCardFirebaseModel(
        id: id,
        userId: json["user_id"],
        commonName: json["name"],
        scientificName: json["scientific_name"],
        habitat: json["habitat"],
        weight: json["regular_weight"],
        sex: json["possible_sex"],
        imageUrl: json["image_url"],
        curiousInformation: json["curious_information"],
        createdAt: (json['created_at'] as Timestamp).toDate(),
        updatedAt: (json['updated_at'] as Timestamp).toDate(),
      );
  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": commonName,
        "user_id": userId,
        "scientific_name": scientificName,
        "habitat": habitat,
        "regular_weight": weight,
        "possible_sex": sex,
        "curious_information": curiousInformation,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  Map<String, dynamic> toFirebaseJson() => {
        "name": commonName,
        "user_id": userId,
        "scientific_name": scientificName,
        "habitat": habitat,
        "regular_weight": weight,
        "possible_sex": sex,
        "curious_information": curiousInformation,
        "created_at": FieldValue.serverTimestamp(),
        "updated_at": FieldValue.serverTimestamp(),
      };

  @override
  CollectableCardFirebaseModel copyWith({
    String? id,
    String? userId,
    String? breed,
    String? commonName,
    String? scientificName,
    String? habitat,
    String? weight,
    String? sex,
    String? curiousInformation,
    String? imageUrl,
    // FieldValue? createdAt,
    // FieldValue? updatedAt,
  }) {
    return CollectableCardFirebaseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      commonName: commonName ?? this.commonName,
      scientificName: scientificName ?? this.scientificName,
      breed: breed ?? this.breed,
      habitat: habitat ?? this.habitat,
      weight: weight ?? this.weight,
      sex: sex ?? this.sex,
      curiousInformation: curiousInformation ?? this.curiousInformation,
      imageUrl: imageUrl ?? this.imageUrl,
      // createdAt: createdAt ?? this.createdAt,
      // updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
