import 'package:isar/isar.dart';

part 'user_entity.g.dart';

@embedded
class UserEntity {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;
  String? gender;
  String? email;
  DateTime? dateOfBirth;
  String? phone;
  DateTime? registerDate;
  DateTime? updatedDate;
  UserEntity({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
    this.gender,
    this.email,
    this.dateOfBirth,
    this.phone,
    this.registerDate,
    this.updatedDate,
  });

  UserEntity copyWith({
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
    return UserEntity(
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

  @override
  String toString() {
    return 'UserEntity(id: $id, title: $title, firstName: $firstName, lastName: $lastName, picture: $picture, gender: $gender, email: $email, dateOfBirth: $dateOfBirth, phone: $phone, registerDate: $registerDate, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
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
