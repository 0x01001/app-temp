import 'dart:convert';

class UserModel {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? dateOfBirth;
  String? registerDate;
  String? phone;
  String? picture;
  Location? location;

  UserModel({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.dateOfBirth,
    this.registerDate,
    this.phone,
    this.picture,
    this.location,
  });

  UserModel copyWith({
    String? id,
    String? title,
    String? firstName,
    String? lastName,
    String? gender,
    String? email,
    String? dateOfBirth,
    String? registerDate,
    String? phone,
    String? picture,
    Location? location,
  }) =>
      UserModel(
        id: id ?? this.id,
        title: title ?? this.title,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        registerDate: registerDate ?? this.registerDate,
        phone: phone ?? this.phone,
        picture: picture ?? this.picture,
        location: location ?? this.location,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        title: json['title'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        email: json['email'],
        dateOfBirth: json['dateOfBirth'],
        registerDate: json['registerDate'],
        phone: json['phone'],
        picture: json['picture'],
        location: json['location'] == null ? null : Location.fromMap(json['location']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'email': email,
        'dateOfBirth': dateOfBirth,
        'registerDate': registerDate,
        'phone': phone,
        'picture': picture,
        'location': location?.toMap(),
      };
}

class Location {
  String? street;
  String? city;
  String? state;
  String? country;
  String? timezone;

  Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.timezone,
  });

  Location copyWith({
    String? street,
    String? city,
    String? state,
    String? country,
    String? timezone,
  }) =>
      Location(
        street: street ?? this.street,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        timezone: timezone ?? this.timezone,
      );

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        street: json['street'],
        city: json['city'],
        state: json['state'],
        country: json['country'],
        timezone: json['timezone'],
      );

  Map<String, dynamic> toMap() => {
        'street': street,
        'city': city,
        'state': state,
        'country': country,
        'timezone': timezone,
      };
}


// {
//   "id": "string",
//   "title": "string",
//   "firstName": "string",
//   "lastName": "string",
//   "gender": "string",
//   "email": "string",
//   "dateOfBirth": "string",
//   "registerDate": "string",
//   "phone": "string",
//   "picture": "string",
//   "location": {
//     "street": "string",
//     "city": "string",
//     "state": "string",
//     "country": "string",
//     "timezone": "string"
//   }
// }
