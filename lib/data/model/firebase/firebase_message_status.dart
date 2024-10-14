import 'package:chatview/chatview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'code')
enum FirebaseMessageStatus {
  read(0),
  sending(1),
  sent(2),
  failed(3);

  const FirebaseMessageStatus(this.code);
  final int code;

  MessageStatus toChatViewMessageStatus() {
    switch (this) {
      case FirebaseMessageStatus.sending:
        return MessageStatus.pending;
      case FirebaseMessageStatus.sent:
        return MessageStatus.delivered;
      case FirebaseMessageStatus.failed:
        return MessageStatus.undelivered;
      case FirebaseMessageStatus.read:
        return MessageStatus.read;
    }
  }
}
