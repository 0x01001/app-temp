// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../domain/index.dart';

class NotificationModel extends BaseEntity {
  final String? notificationId;
  final String? image;
  final String? title;
  final String? message;
  final String? notificationType;
  const NotificationModel({
    super.id,
    super.status,
    super.createdBy,
    super.updatedBy,
    super.createdTime,
    super.lastModifiedTime,
    this.notificationId,
    this.image,
    this.title,
    this.message,
    this.notificationType,
  });

  NotificationModel copyWith({
    int? id,
    String? status,
    String? createdBy,
    String? updatedBy,
    String? createdTime,
    String? lastModifiedTime,
    String? notificationId,
    String? image,
    String? title,
    String? message,
    String? notificationType,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdTime: createdTime ?? this.createdTime,
      lastModifiedTime: lastModifiedTime ?? this.lastModifiedTime,
      notificationId: notificationId ?? this.notificationId,
      image: image ?? this.image,
      title: title ?? this.title,
      message: message ?? this.message,
      notificationType: notificationType ?? this.notificationType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdTime': createdTime,
      'lastModifiedTime': lastModifiedTime,
      'notification_id': notificationId,
      'image': image,
      'title': title,
      'message': message,
      'notification_type': notificationType,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] != null ? map['id'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
      createdTime: map['createdTime'] != null ? map['createdTime'] as String : null,
      lastModifiedTime: map['lastModifiedTime'] != null ? map['lastModifiedTime'] as String : null,
      notificationId: map['notification_id'] != null ? map['notification_id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      notificationType: map['notification_type'] != null ? map['notification_type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationData(id: $id, status: $status, createdBy: $createdBy, updatedBy: $updatedBy, createdTime: $createdTime, lastModifiedTime: $lastModifiedTime, notificationId: $notificationId, image: $image, title: $title, message: $message, notificationType: $notificationType)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.status == status &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy &&
        other.createdTime == createdTime &&
        other.lastModifiedTime == lastModifiedTime &&
        other.notificationId == notificationId &&
        other.image == image &&
        other.title == title &&
        other.message == message &&
        other.notificationType == notificationType;
  }

  @override
  int get hashCode {
    return id.hashCode ^ status.hashCode ^ createdBy.hashCode ^ updatedBy.hashCode ^ createdTime.hashCode ^ lastModifiedTime.hashCode ^ notificationId.hashCode ^ image.hashCode ^ title.hashCode ^ message.hashCode ^ notificationType.hashCode;
  }
}
