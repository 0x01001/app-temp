// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../index.dart';

abstract class NotificationEntity extends BaseEntity {
  final String? notificationId;
  final NotificationType? notificationType;
  final String? image;
  final String? title;
  final String? message;

  const NotificationEntity({
    this.notificationId,
    this.notificationType,
    this.image,
    this.title,
    this.message,
  });

  @override
  String toString() {
    return 'NotificationEntity(notificationId: $notificationId, notificationType: $notificationType, image: $image, title: $title, message: $message)';
  }

  @override
  bool operator ==(covariant NotificationEntity other) {
    if (identical(this, other)) return true;

    return other.notificationId == notificationId && other.notificationType == notificationType && other.image == image && other.title == title && other.message == message;
  }

  @override
  int get hashCode {
    return notificationId.hashCode ^ notificationType.hashCode ^ image.hashCode ^ title.hashCode ^ message.hashCode;
  }
}
