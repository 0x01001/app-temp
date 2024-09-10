// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../index.dart';

class RefreshTokenModel extends BaseModel {
  final String? accessToken;

  const RefreshTokenModel({
    this.accessToken,
    super.id,
    super.status,
    super.createdBy,
    super.updatedBy,
    super.createdTime,
    super.lastModifiedTime,
  });
  // @JsonKey(name: 'access_token') String? accessToken,

  RefreshTokenModel copyWith({
    String? accessToken,
    int? id,
    String? status,
    String? createdBy,
    String? updatedBy,
    String? createdTime,
    String? lastModifiedTime,
  }) {
    return RefreshTokenModel(
      accessToken: accessToken ?? this.accessToken,
      id: id ?? this.id,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdTime: createdTime ?? this.createdTime,
      lastModifiedTime: lastModifiedTime ?? this.lastModifiedTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'id': id,
      'status': status,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdTime': createdTime,
      'lastModifiedTime': lastModifiedTime,
    };
  }

  factory RefreshTokenModel.fromMap(Map<String, dynamic> map) {
    return RefreshTokenModel(
      accessToken: map['access_token'] != null ? map['access_token'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
      createdTime: map['createdTime'] != null ? map['createdTime'] as String : null,
      lastModifiedTime: map['lastModifiedTime'] != null ? map['lastModifiedTime'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RefreshTokenModel.fromJson(String source) => RefreshTokenModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RefreshTokenModel(accessToken: $accessToken, id: $id, status: $status, createdBy: $createdBy, updatedBy: $updatedBy, createdTime: $createdTime, lastModifiedTime: $lastModifiedTime)';
  }

  @override
  bool operator ==(covariant RefreshTokenModel other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken && other.id == id && other.status == status && other.createdBy == createdBy && other.updatedBy == updatedBy && other.createdTime == createdTime && other.lastModifiedTime == lastModifiedTime;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^ id.hashCode ^ status.hashCode ^ createdBy.hashCode ^ updatedBy.hashCode ^ createdTime.hashCode ^ lastModifiedTime.hashCode;
  }
}
