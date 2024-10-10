import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../index.dart';

class FirebaseConversationModel {
  String? id;
  String? name;
  String? lastMessage;
  int? lastMessageType;
  List<FirebaseConversationUserModel>? members;
  List<String>? memberIds;
  DateTime? createdAt;
  DateTime? updatedAt;

  static const keyId = 'id';
  static const keyName = 'name';
  static const keyLastMessage = 'last_message';
  static const keyLastMessageType = 'last_message_type';
  static const keyMembers = 'members';
  static const keyMemberIds = 'member_ids';
  static const keyCreatedAt = 'created_at';
  static const keyUpdatedAt = 'updated_at';

  FirebaseConversationModel({
    this.id,
    this.name,
    this.lastMessage,
    this.lastMessageType,
    this.members,
    this.memberIds,
    this.createdAt,
    this.updatedAt,
  });

  FirebaseConversationModel copyWith({
    String? id,
    String? name,
    String? lastMessage,
    int? lastMessageType,
    List<FirebaseConversationUserModel>? members,
    List<String>? memberIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      FirebaseConversationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        lastMessage: lastMessage ?? this.lastMessage,
        lastMessageType: lastMessageType ?? this.lastMessageType,
        members: members ?? this.members,
        memberIds: memberIds ?? this.memberIds,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory FirebaseConversationModel.fromJson(String str) => FirebaseConversationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FirebaseConversationModel.fromMap(Map<String, dynamic> json) => FirebaseConversationModel(
        id: json['id'],
        name: json['name'],
        lastMessage: json['last_message'],
        lastMessageType: json['last_message_type'],
        members: json['members'] == null ? [] : List<FirebaseConversationUserModel>.from(json['members']!.map((x) => FirebaseConversationUserModel.fromMap(x))),
        memberIds: json['member_ids'] == null ? [] : List<String>.from(json['member_ids']!.map((x) => x)),
        createdAt: json['created_at'] == null ? null : (json['created_at'] is Timestamp ? (json['created_at'] as Timestamp).toDate() : DateTime.parse(json['created_at'])),
        updatedAt: json['updated_at'] == null ? null : (json['updated_at'] is Timestamp ? (json['updated_at'] as Timestamp).toDate() : DateTime.parse(json['updated_at'])),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'last_message': lastMessage,
        'last_message_type': lastMessageType,
        'members': members == null ? [] : List<dynamic>.from(members!.map((x) => x.toMap())),
        'member_ids': memberIds == null ? [] : List<dynamic>.from(memberIds!.map((x) => x)),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

// const json = '''
// {
//   "id": "123",
//   "name": "John Doe",
//   "last_message": "Hello, how are you?",
//   "last_message_type": 1,
//   "members": [
//     {
//       "user_id": "123",
//       "email": "test@test.com",
//       "last_seen": "2021-01-01",
//       "is_conversation_admin": true
//     }
//   ],
//   "member_ids": ["123", "456"],
//   "created_at": "2021-01-01",
//   "updated_at": "2021-01-01"
// }
// ''';
