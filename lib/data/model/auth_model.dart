// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import '../../domain/index.dart';

class AuthModel extends BaseEntity {
  final String? uid;
  final String? idToken;
  final String? phoneNumber;
  final String? refreshToken;
  final String? expiresIn;
  final String? email;
  final String? displayName;
  final String? accessToken;
  final bool? registered;
  const AuthModel({
    super.id,
    super.status,
    super.createdBy,
    super.updatedBy,
    super.createdTime,
    super.lastModifiedTime,
    this.uid,
    this.idToken,
    this.phoneNumber,
    this.refreshToken,
    this.expiresIn,
    this.email,
    this.displayName,
    this.accessToken,
    this.registered,
  });
  AuthModel copyWith({
    int? id,
    String? status,
    String? createdBy,
    String? updatedBy,
    String? createdTime,
    String? lastModifiedTime,
    String? uid,
    String? idToken,
    String? phoneNumber,
    String? refreshToken,
    String? expiresIn,
    String? email,
    String? displayName,
    String? accessToken,
    bool? registered,
  }) {
    return AuthModel(
      id: id ?? this.id,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdTime: createdTime ?? this.createdTime,
      lastModifiedTime: lastModifiedTime ?? this.lastModifiedTime,
      uid: uid ?? this.uid,
      idToken: idToken ?? this.idToken,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      accessToken: accessToken ?? this.accessToken,
      registered: registered ?? this.registered,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdTime': createdTime,
      'lastModifiedTime': lastModifiedTime,
      'uid': uid,
      'idToken': idToken,
      'phoneNumber': phoneNumber,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'email': email,
      'displayName': displayName,
      'access_token': accessToken,
      'registered': registered,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      id: map['id'] != null ? map['id'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
      createdTime: map['createdTime'] != null ? map['createdTime'] as String : null,
      lastModifiedTime: map['lastModifiedTime'] != null ? map['lastModifiedTime'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      idToken: map['idToken'] != null ? map['idToken'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      refreshToken: map['refreshToken'] != null ? map['refreshToken'] as String : null,
      expiresIn: map['expiresIn'] != null ? map['expiresIn'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      displayName: map['displayName'] != null ? map['displayName'] as String : null,
      accessToken: map['access_token'] != null ? map['access_token'] as String : null,
      registered: map['registered'] != null ? map['registered'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) => AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthResponseData(id: $id, status: $status, createdBy: $createdBy, updatedBy: $updatedBy, createdTime: $createdTime, lastModifiedTime: $lastModifiedTime, uid: $uid, idToken: $idToken, phoneNumber: $phoneNumber, refreshToken: $refreshToken, expiresIn: $expiresIn, email: $email, displayName: $displayName, accessToken: $accessToken, registered: $registered)';
  }

  @override
  bool operator ==(covariant AuthModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.status == status &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy &&
        other.createdTime == createdTime &&
        other.lastModifiedTime == lastModifiedTime &&
        other.uid == uid &&
        other.idToken == idToken &&
        other.phoneNumber == phoneNumber &&
        other.refreshToken == refreshToken &&
        other.expiresIn == expiresIn &&
        other.email == email &&
        other.displayName == displayName &&
        other.accessToken == accessToken &&
        other.registered == registered;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        createdBy.hashCode ^
        updatedBy.hashCode ^
        createdTime.hashCode ^
        lastModifiedTime.hashCode ^
        uid.hashCode ^
        idToken.hashCode ^
        phoneNumber.hashCode ^
        refreshToken.hashCode ^
        expiresIn.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        accessToken.hashCode ^
        registered.hashCode;
  }
}
