import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  final int? id;
  final String? status;
  final String? createdBy;
  final String? updatedBy;
  final String? createdTime;
  final String? lastModifiedTime;
  const BaseModel({
    this.id,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdTime,
    this.lastModifiedTime,
  });

  @override
  String toString() {
    return 'BaseModel(id: $id, status: $status, createdBy: $createdBy, updatedBy: $updatedBy, createdTime: $createdTime, lastModifiedTime: $lastModifiedTime)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      status,
      createdBy,
      updatedBy,
      createdTime,
      lastModifiedTime,
    ];
  }
}
