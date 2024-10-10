import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../index.dart';

class FirebaseMessageModel {
  String? id;
  String? senderId;
  String? message;
  int? type;
  FirebaseReplyMessageModel? replyMessage;
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
    FirebaseReplyMessageModel? replyMessage,
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
        createdAt: json['created_at'] == null ? null : (json['created_at'] is Timestamp ? (json['created_at'] as Timestamp).toDate() : DateTime.parse(json['created_at'])),
        updatedAt: json['updated_at'] == null ? null : (json['updated_at'] is Timestamp ? (json['updated_at'] as Timestamp).toDate() : DateTime.parse(json['updated_at'])),
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

  LocalMessageData toDataLocal(AppPreferences _appPreferences, String _conversationId) => LocalMessageData(
        userId: _appPreferences.userId,
        conversationId: _conversationId,
        uniqueId: id ?? '',
        senderId: senderId ?? '',
        message: message ?? '',
        type: type != null ? (type as MessageType) : MessageType.text,
        status: MessageStatus.sent,
        createdAt: createdAt?.millisecondsSinceEpoch ?? clock.now().millisecondsSinceEpoch,
        updatedAt: updatedAt?.millisecondsSinceEpoch ?? clock.now().millisecondsSinceEpoch,
        replyMessage: replyMessage != null ? replyMessage?.toDataLocal(_appPreferences) : null,
        // replyMessage: replyMessage != null
        //     ? LocalReplyMessageData(
        //         userId: _appPreferences.userId,
        //         repplyToMessageId: replyMessage?.replyToMessageId ?? '',
        //         type: replyMessage?.type != null ? (replyMessage?.type as MessageType) : MessageType.text,
        //         repplyToMessage: replyMessage?.replyToMessage ?? '',
        //         replyByUserId: replyMessage?.replyByUserId ?? '',
        //         replyToUserId: replyMessage?.replyToUserId ?? '',
        //       )
        //     : null,
      );
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
