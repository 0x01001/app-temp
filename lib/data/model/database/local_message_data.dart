import 'package:chatview/chatview.dart';
import 'package:isar/isar.dart';

import '../../index.dart';

part 'local_message_data.g.dart';

@collection
class LocalMessageData {
  LocalMessageData({
    this.uniqueId = '',
    this.userId = '',
    this.conversationId = '',
    this.senderId = '',
    this.type = FirebaseMessageType.text,
    this.status = FirebaseMessageStatus.sending,
    this.message = '',
    this.createdAt = 0,
    this.updatedAt = 0,
    this.replyMessage,
  }) : assert(createdAt > 0);

  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String uniqueId;
  String userId;
  String conversationId;
  String senderId;
  @Enumerated(EnumType.value, 'code')
  FirebaseMessageType type;
  @Enumerated(EnumType.value, 'code')
  FirebaseMessageStatus status;
  String message;
  int createdAt;
  int updatedAt;
  LocalReplyMessageData? replyMessage;

  @override
  String toString() {
    return 'LocalMessageData{id: $id, uniqueId: $uniqueId, userId: $userId, conversationId: $conversationId, senderId: $senderId, type: $type, status: $status, message: $message, createdAt: $createdAt, updatedAt: $updatedAt, replyMessage: $replyMessage}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalMessageData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uniqueId == other.uniqueId &&
          userId == other.userId &&
          conversationId == other.conversationId &&
          senderId == other.senderId &&
          type == other.type &&
          status == other.status &&
          message == other.message &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          replyMessage == other.replyMessage;

  @override
  int get hashCode => id.hashCode ^ uniqueId.hashCode ^ userId.hashCode ^ conversationId.hashCode ^ senderId.hashCode ^ type.hashCode ^ status.hashCode ^ message.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode ^ replyMessage.hashCode;

  Message toMessage() {
    return Message(
      id: uniqueId,
      message: message,
      sentBy: senderId,
      replyMessage: replyMessage?.toReplyMessage() ?? const ReplyMessage(),
      messageType: type.toChatViewMessageType(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      status: status.toChatViewMessageStatus(),
    );
  }

  FirebaseMessageModel toDataRemote() => FirebaseMessageModel(
        id: uniqueId,
        senderId: senderId,
        message: message,
        type: type.index,
        replyMessage: replyMessage == null ? null : replyMessage?.toDataRemote(),
      );
}
