import 'dart:convert';

class FirebaseMessageModel {
  String? id;
  String? senderId;
  String? message;
  int? type;
  String? replyMessage;
  DateTime? createdAt;
  DateTime? updatedAt;

  static const keyId = 'id';
  static const keySenderId = 'sender_id';
  static const keyMessage = 'message';
  static const keyType = 'type';
  static const keyReplyMessage = 'reply_message';
  static const keyCreatedAt = 'created_at';
  static const keyUpdatedAt = 'updated_at';

  FirebaseMessageModel({
    this.id,
    this.senderId,
    this.message,
    this.type,
    this.replyMessage,
    this.createdAt,
    this.updatedAt,
  });

  FirebaseMessageModel copyWith({
    String? id,
    String? senderId,
    String? message,
    int? type,
    String? replyMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      FirebaseMessageModel(
        id: id ?? this.id,
        senderId: senderId ?? this.senderId,
        message: message ?? this.message,
        type: type ?? this.type,
        replyMessage: replyMessage ?? this.replyMessage,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory FirebaseMessageModel.fromJson(String str) => FirebaseMessageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FirebaseMessageModel.fromMap(Map<String, dynamic> json) => FirebaseMessageModel(
        id: json['id'],
        senderId: json['sender_id'],
        message: json['message'],
        type: json['type'],
        replyMessage: json['reply_message'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'sender_id': senderId,
        'message': message,
        'type': type,
        'reply_message': replyMessage,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

// const json  = ''' 
// {
//   "id": "1",
//   "sender_id": "2",
//   "message": "Hello",
//   "type": "text",
//   "reply_message": "Hello",
//   "created_at": "2021-01-01",
//   "updated_at": "2021-01-01"
// }
// ''';
