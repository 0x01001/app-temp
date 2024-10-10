import 'dart:convert';

import '../../index.dart';

class FirebaseReplyMessageModel {
  String? replyToMessageId;
  int? type;
  String? replyToMessage;
  String? replyByUserId;
  String? replyToUserId;

  static const keyReplyToMessageId = 'reply_to_message_id';
  static const keyType = 'type';
  static const keyReplyToMessage = 'reply_to_message';
  static const keyReplyByUserId = 'reply_by_user_id';
  static const keyReplyToUserId = 'reply_to_user_id';

  FirebaseReplyMessageModel({
    this.replyToMessageId,
    this.type,
    this.replyToMessage,
    this.replyByUserId,
    this.replyToUserId,
  });

  FirebaseReplyMessageModel copyWith({
    String? replyToMessageId,
    int? type,
    String? replyToMessage,
    String? replyByUserId,
    String? replyToUserId,
  }) =>
      FirebaseReplyMessageModel(
        replyToMessageId: replyToMessageId ?? this.replyToMessageId,
        type: type ?? this.type,
        replyToMessage: replyToMessage ?? this.replyToMessage,
        replyByUserId: replyByUserId ?? this.replyByUserId,
        replyToUserId: replyToUserId ?? this.replyToUserId,
      );

  factory FirebaseReplyMessageModel.fromJson(String str) => FirebaseReplyMessageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FirebaseReplyMessageModel.fromMap(Map<String, dynamic> json) => FirebaseReplyMessageModel(
        replyToMessageId: json['reply_to_message_id'],
        type: json['type'],
        replyToMessage: json['reply_to_message'],
        replyByUserId: json['reply_by_user_id'],
        replyToUserId: json['reply_to_user_id'],
      );

  Map<String, dynamic> toMap() => {
        'reply_to_message_id': replyToMessageId,
        'type': type,
        'reply_to_message': replyToMessage,
        'reply_by_user_id': replyByUserId,
        'reply_to_user_id': replyToUserId,
      };

  LocalReplyMessageData toDataLocal(AppPreferences _appPreferences) => LocalReplyMessageData(
        userId: _appPreferences.userId,
        repplyToMessageId: replyToMessageId ?? '',
        type: type != null ? (type as MessageType) : MessageType.text,
        repplyToMessage: replyToMessage ?? '',
        replyByUserId: replyByUserId ?? '',
        replyToUserId: replyToUserId ?? '',
      );
}

// const json = '''
// {
//   "reply_to_message_id": "1",
//   "type": "text",
//   "reply_to_message": "Hello",
//   "reply_by_user_id": "2",
//   "reply_to_user_id": "1"
// }
// '''
