// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';

import '../index.dart';

class SchemeEntity extends BaseEntity {
  final String? androidPackageName;
  final String? iosUrlScheme;
  final String? appStoreLink;
  final dynamic launch;
  final ConfigType? type;
  const SchemeEntity({
    this.launch,
    this.androidPackageName,
    this.iosUrlScheme,
    this.appStoreLink,
    this.type,
  });

  SchemeEntity copyWith({
    String? androidPackageName,
    String? iosUrlScheme,
    String? appStoreLink,
    dynamic launch,
    ConfigType? type,
  }) {
    return SchemeEntity(
      androidPackageName: androidPackageName ?? this.androidPackageName,
      iosUrlScheme: iosUrlScheme ?? this.iosUrlScheme,
      appStoreLink: appStoreLink ?? this.appStoreLink,
      launch: launch ?? this.launch,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'androidPackageName': androidPackageName,
      'iosUrlScheme': iosUrlScheme,
      'appStoreLink': appStoreLink,
      'launch': launch,
      'type': type != null ? EnumToString.convertToString(type) : '',
    };
  }

  factory SchemeEntity.fromMap(Map<String, dynamic> map) {
    return SchemeEntity(
      androidPackageName: map['androidPackageName'] != null ? map['androidPackageName'] as String : null,
      iosUrlScheme: map['iosUrlScheme'] != null ? map['iosUrlScheme'] as String : null,
      appStoreLink: map['appStoreLink'] != null ? map['appStoreLink'] as String : null,
      launch: map['launch'] as dynamic,
      type: map['type'] != null ? EnumToString.fromString(ConfigType.values, map['type']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchemeEntity.fromJson(String source) => SchemeEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SchemeModel(androidPackageName: $androidPackageName, iosUrlScheme: $iosUrlScheme, appStoreLink: $appStoreLink, launch: $launch, type: $type)';
  }

  @override
  bool operator ==(covariant SchemeEntity other) {
    if (identical(this, other)) return true;

    return other.androidPackageName == androidPackageName && other.iosUrlScheme == iosUrlScheme && other.appStoreLink == appStoreLink && other.launch == launch && other.type == type;
  }

  @override
  int get hashCode {
    return androidPackageName.hashCode ^ iosUrlScheme.hashCode ^ appStoreLink.hashCode ^ launch.hashCode ^ type.hashCode;
  }
}
