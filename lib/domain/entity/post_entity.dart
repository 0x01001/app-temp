import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../index.dart';

part 'post_entity.g.dart';

@collection
class PostEntity {
  Id? localId = Isar.autoIncrement;

  String? id;
  String? image;
  int? likes;
  List<String>? tags;
  String? text;
  DateTime? publishDate;
  UserEntity? owner;
  PostEntity({
    this.localId,
    this.id,
    this.image,
    this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.owner,
  });

  @override
  String toString() {
    return 'PostEntity(localId: $localId, id: $id, image: $image, likes: $likes, tags: $tags, text: $text, publishDate: $publishDate, owner: $owner)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostEntity && other.localId == localId && other.id == id && other.image == image && other.likes == likes && listEquals(other.tags, tags) && other.text == text && other.publishDate == publishDate && other.owner == owner;
  }

  @override
  int get hashCode {
    return localId.hashCode ^ id.hashCode ^ image.hashCode ^ likes.hashCode ^ tags.hashCode ^ text.hashCode ^ publishDate.hashCode ^ owner.hashCode;
  }
}
