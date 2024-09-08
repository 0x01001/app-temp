import 'dart:convert';

class FirebaseConversationUserModel {
  String? userId;
  String? email;
  DateTime? lastSeen;
  bool? isConversationAdmin;

  static const keyUserId = 'user_id';
  static const keyEmail = 'email';
  static const keyLastSeen = 'last_seen';
  static const keyIsConversationAdmin = 'is_conversation_admin';

  FirebaseConversationUserModel({
    this.userId,
    this.email,
    this.lastSeen,
    this.isConversationAdmin,
  });

  FirebaseConversationUserModel copyWith({
    String? userId,
    String? email,
    DateTime? lastSeen,
    bool? isConversationAdmin,
  }) =>
      FirebaseConversationUserModel(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        lastSeen: lastSeen ?? this.lastSeen,
        isConversationAdmin: isConversationAdmin ?? this.isConversationAdmin,
      );

  factory FirebaseConversationUserModel.fromJson(String str) => FirebaseConversationUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FirebaseConversationUserModel.fromMap(Map<String, dynamic> json) => FirebaseConversationUserModel(
        userId: json['user_id'],
        email: json['email'],
        lastSeen: json['last_seen'] == null ? null : DateTime.parse(json['last_seen']),
        isConversationAdmin: json['is_conversation_admin'],
      );

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'email': email,
        'last_seen': lastSeen?.toIso8601String(),
        'is_conversation_admin': isConversationAdmin,
      };
}


// const json = '''
// {
//   "user_id": "123",
//   "email": "test@test.com",
//   "last_seen": "2021-01-01",
//   "is_conversation_admin": true
// }
// ''';
