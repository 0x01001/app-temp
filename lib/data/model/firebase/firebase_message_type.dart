import 'package:chatview/chatview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'code')
enum FirebaseMessageType {
  @JsonValue(0)
  text(0),
  @JsonValue(1)
  image(1),
  @JsonValue(2)
  video(2),
  @JsonValue(3)
  voice(3),
  @JsonValue(4)
  custom(4);

  const FirebaseMessageType(this.code);
  factory FirebaseMessageType.fromChatViewMessageType(MessageType type) {
    switch (type) {
      case MessageType.text:
        return FirebaseMessageType.text;
      case MessageType.image:
        return FirebaseMessageType.image;
      case MessageType.voice:
        return FirebaseMessageType.voice;
      case MessageType.custom:
        return FirebaseMessageType.custom;
    }
  }
  final int code;

  MessageType toChatViewMessageType() {
    switch (this) {
      case FirebaseMessageType.text:
        return MessageType.text;
      case FirebaseMessageType.image:
        return MessageType.image;
      case FirebaseMessageType.video:
        return MessageType.image;
      case FirebaseMessageType.voice:
        return MessageType.voice;
      case FirebaseMessageType.custom:
        return MessageType.custom;
    }
  }
}
