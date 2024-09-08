import 'dart:convert';

class FirebaseUserModel {
  String? id;
  String? email;
  bool? isVip;
  List<String>? deviceIds;
  List<String>? deviceTokens;
  DateTime? createdAt;
  DateTime? updatedAt;

  static const keyId = 'id';
  static const keyEmail = 'email';
  static const keyIsVip = 'is_vip';
  static const keyDeviceIds = 'device_ids';
  static const keyDeviceTokens = 'device_tokens';
  static const keyCreatedAt = 'created_at';
  static const keyUpdatedAt = 'updated_at';

  FirebaseUserModel({
    this.id,
    this.email,
    this.isVip,
    this.deviceIds,
    this.deviceTokens,
    this.createdAt,
    this.updatedAt,
  });

  FirebaseUserModel copyWith({
    String? id,
    String? email,
    bool? isVip,
    List<String>? deviceIds,
    List<String>? deviceTokens,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      FirebaseUserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        isVip: isVip ?? this.isVip,
        deviceIds: deviceIds ?? this.deviceIds,
        deviceTokens: deviceTokens ?? this.deviceTokens,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory FirebaseUserModel.fromJson(String str) => FirebaseUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FirebaseUserModel.fromMap(Map<String, dynamic> json) => FirebaseUserModel(
        id: json['id'],
        email: json['email'],
        isVip: json['is_vip'],
        deviceIds: json['device_ids'] == null ? [] : List<String>.from(json['device_ids']!.map((x) => x)),
        deviceTokens: json['device_tokens'] == null ? [] : List<String>.from(json['device_tokens']!.map((x) => x)),
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'is_vip': isVip,
        'device_ids': deviceIds == null ? [] : List<dynamic>.from(deviceIds!.map((x) => x)),
        'device_tokens': deviceTokens == null ? [] : List<dynamic>.from(deviceTokens!.map((x) => x)),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

// const json ='''
// {
//   "id": "123",
//   "email": "test@test.com",
//   "is_vip": true,
//   "device_ids": ["123", "456"],
//   "device_tokens": ["123", "456"],
//   "created_at": "2021-01-01",
//   "updated_at": "2021-01-01"
// }
// ''';
