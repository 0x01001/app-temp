import 'dart:convert';

import '../../../domain/index.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.title,
    super.firstName,
    super.lastName,
    super.picture,
    super.gender,
    super.email,
    super.dateOfBirth,
    super.phone,
    super.registerDate,
    super.updatedDate,
  });

  @override
  UserModel copyWith({
    String? id,
    String? title,
    String? firstName,
    String? lastName,
    String? picture,
    String? gender,
    String? email,
    DateTime? dateOfBirth,
    String? phone,
    DateTime? registerDate,
    DateTime? updatedDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      picture: picture ?? this.picture,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
      registerDate: registerDate ?? this.registerDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        title: json['title'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        picture: json['picture'],
        gender: json['gender'],
        email: json['email'],
        dateOfBirth: json['dateOfBirth'] == null ? null : DateTime.parse(json['dateOfBirth']),
        phone: json['phone'],
        registerDate: json['registerDate'] == null ? null : DateTime.parse(json['registerDate']),
        updatedDate: json['updatedDate'] == null ? null : DateTime.parse(json['updatedDate']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'firstName': firstName,
        'lastName': lastName,
        'picture': picture,
        'gender': gender,
        'email': email,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'phone': phone,
        'registerDate': registerDate?.toIso8601String(),
        'updatedDate': updatedDate?.toIso8601String(),
      };

  @override
  String toString() {
    return 'UserModel(id: $id, title: $title, firstName: $firstName, lastName: $lastName, picture: $picture, gender: $gender, email: $email, dateOfBirth: $dateOfBirth, phone: $phone, registerDate: $registerDate, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.title == title &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.picture == picture &&
        other.gender == gender &&
        other.email == email &&
        other.dateOfBirth == dateOfBirth &&
        other.phone == phone &&
        other.registerDate == registerDate &&
        other.updatedDate == updatedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ firstName.hashCode ^ lastName.hashCode ^ picture.hashCode ^ gender.hashCode ^ email.hashCode ^ dateOfBirth.hashCode ^ phone.hashCode ^ registerDate.hashCode ^ updatedDate.hashCode;
  }
}
