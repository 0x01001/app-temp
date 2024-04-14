import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../domain/index.dart';
import '../../index.dart';

class PostModel extends PostEntity {
  PostModel({
    super.id,
    super.image,
    super.likes,
    super.tags,
    super.text,
    super.publishDate,
    super.owner,
  });

  PostModel copyWith({
    String? id,
    String? image,
    int? likes,
    List<String>? tags,
    String? text,
    DateTime? publishDate,
    UserModel? owner,
  }) {
    return PostModel(
      id: id ?? this.id,
      image: image ?? this.image,
      likes: likes ?? this.likes,
      tags: tags ?? this.tags,
      text: text ?? this.text,
      publishDate: publishDate ?? this.publishDate,
      owner: owner ?? this.owner,
    );
  }

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        id: json['id'],
        image: json['image'],
        likes: json['likes'],
        tags: json['tags'] == null ? [] : List<String>.from(json['tags']!.map((x) => x)),
        text: json['text'],
        publishDate: json['publishDate'] == null ? null : DateTime.parse(json['publishDate']),
        owner: json['owner'] == null ? null : UserModel.fromMap(json['owner']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'image': image,
        'likes': likes,
        'tags': tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        'text': text,
        'publishDate': publishDate?.toIso8601String(),
        'owner': (owner as UserModel?)?.toMap(),
      };

  @override
  String toString() {
    return 'PostModel(localId: $localId, id: $id, image: $image, likes: $likes, tags: $tags, text: $text, publishDate: $publishDate, owner: $owner)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel && other.localId == localId && other.id == id && other.image == image && other.likes == likes && listEquals(other.tags, tags) && other.text == text && other.publishDate == publishDate && other.owner == owner;
  }

  @override
  int get hashCode {
    return localId.hashCode ^ id.hashCode ^ image.hashCode ^ likes.hashCode ^ tags.hashCode ^ text.hashCode ^ publishDate.hashCode ^ owner.hashCode;
  }
}
