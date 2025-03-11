import 'dart:convert';

import 'package:isar/isar.dart';

import '../index.dart';

part 'user_entity.g.dart';

@collection
class UserEntity {
  late int id;
  final String? userId;
  final String? email;
  final String? name;
  UserEntity({
    this.userId,
    this.email,
    this.name,
  });

  UserEntity copyWith({
    String? userId,
    String? email,
    String? name,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': userId,
      'email': email,
      'name': name,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      userId: map['id'],
      email: map['email'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) => UserEntity.fromMap(json.decode(source));

  @override
  String toString() => 'UserEntity(id: $userId, email: $email, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity && other.userId == userId && other.email == email && other.name == name;
  }

  @override
  int get hashCode => userId.hashCode ^ email.hashCode ^ name.hashCode;
}

extension FirebaseUserModelExt on FirebaseUserModel {
  UserEntity toEntity() {
    return UserEntity(userId: this.id, email: email, name: name);
  }
}
