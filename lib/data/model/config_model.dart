// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';

import '../index.dart';

class ConfigModel extends BaseModel {
  final SchemeModel? scheme;
  final bool? inReview;
  final String? versionInReview; // 1.0.0_1, 1.0.0_2 ...
  final bool? isForceUpdateIos;
  final bool? isForceUpdateAndroid;
  final String? forceUpdateIosVersion; //1.0.0_1
  final String? forceUpdateAndroidVersion; //1.0.0_1
  // final List<ResourceEntity>? data;
  final List<String>? whitelistLoginEmailDomains; // example: only user xxx@domain.com can login app
  final List<String>? whitelistTesters;
  final List<String>? whitelistIgnoreForceUpdate;

  const ConfigModel({
    this.scheme,
    this.inReview,
    // this.data,
    this.versionInReview,
    this.whitelistLoginEmailDomains,
    this.isForceUpdateIos,
    this.isForceUpdateAndroid,
    this.forceUpdateIosVersion,
    this.forceUpdateAndroidVersion,
    this.whitelistTesters,
    this.whitelistIgnoreForceUpdate,
  });

  ConfigModel copyWith({
    SchemeModel? scheme,
    SchemeModel? schemeSME,
    bool? inReview,
    // List<ResourceEntity>? data,
    String? versionInReview,
    List<String>? whitelistLoginEmailDomains,
    bool? isForceUpdateIos,
    bool? isForceUpdateAndroid,
    String? forceUpdateIosVersion,
    String? forceUpdateAndroidVersion,
    List<String>? whitelistTesters,
    List<String>? whitelistIgnoreForceUpdate,
  }) {
    return ConfigModel(
      scheme: scheme ?? this.scheme,
      inReview: inReview ?? this.inReview,
      // data: data ?? this.data,
      versionInReview: versionInReview ?? this.versionInReview,
      whitelistLoginEmailDomains: whitelistLoginEmailDomains ?? this.whitelistLoginEmailDomains,
      isForceUpdateIos: isForceUpdateIos ?? this.isForceUpdateIos,
      isForceUpdateAndroid: isForceUpdateAndroid ?? this.isForceUpdateAndroid,
      forceUpdateIosVersion: forceUpdateIosVersion ?? this.forceUpdateIosVersion,
      forceUpdateAndroidVersion: forceUpdateAndroidVersion ?? this.forceUpdateAndroidVersion,
      whitelistTesters: whitelistTesters ?? this.whitelistTesters,
      whitelistIgnoreForceUpdate: whitelistIgnoreForceUpdate ?? this.whitelistIgnoreForceUpdate,
    );
  }

  @override
  String toString() {
    return 'ConfigModel(scheme: $scheme,   inReview: $inReview,  versionInReview: $versionInReview, whitelistLoginEmailDomains: $whitelistLoginEmailDomains, isForceUpdateIos: $isForceUpdateIos, isForceUpdateAndroid: $isForceUpdateAndroid, forceUpdateIosVersion: $forceUpdateIosVersion, forceUpdateAndroidVersion: $forceUpdateAndroidVersion, whitelistTesters: $whitelistTesters, whitelistIgnoreForceUpdate: $whitelistIgnoreForceUpdate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfigModel &&
        other.scheme == scheme &&
        other.inReview == inReview &&
        // listEquals(other.data, data) &&
        other.versionInReview == versionInReview &&
        listEquals(other.whitelistLoginEmailDomains, whitelistLoginEmailDomains) &&
        other.isForceUpdateIos == isForceUpdateIos &&
        other.isForceUpdateAndroid == isForceUpdateAndroid &&
        other.forceUpdateIosVersion == forceUpdateIosVersion &&
        other.forceUpdateAndroidVersion == forceUpdateAndroidVersion &&
        listEquals(other.whitelistTesters, whitelistTesters) &&
        listEquals(other.whitelistIgnoreForceUpdate, whitelistIgnoreForceUpdate);
  }

  @override
  int get hashCode {
    return scheme.hashCode ^
        inReview.hashCode ^
        // data.hashCode ^
        versionInReview.hashCode ^
        whitelistLoginEmailDomains.hashCode ^
        isForceUpdateIos.hashCode ^
        isForceUpdateAndroid.hashCode ^
        forceUpdateIosVersion.hashCode ^
        forceUpdateAndroidVersion.hashCode ^
        whitelistTesters.hashCode ^
        whitelistIgnoreForceUpdate.hashCode;
  }
}

enum ConfigType {
  khcn,
  sme,
}

class SchemeModel extends BaseModel {
  final String? androidPackageName;
  final String? iosUrlScheme;
  final String? appStoreLink;
  final dynamic launch;
  final ConfigType? type;
  const SchemeModel({
    this.launch,
    this.androidPackageName,
    this.iosUrlScheme,
    this.appStoreLink,
    this.type,
  });

  SchemeModel copyWith({
    String? androidPackageName,
    String? iosUrlScheme,
    String? appStoreLink,
    dynamic launch,
    ConfigType? type,
  }) {
    return SchemeModel(
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

  factory SchemeModel.fromMap(Map<String, dynamic> map) {
    return SchemeModel(
      androidPackageName: map['androidPackageName'] != null ? map['androidPackageName'] as String : null,
      iosUrlScheme: map['iosUrlScheme'] != null ? map['iosUrlScheme'] as String : null,
      appStoreLink: map['appStoreLink'] != null ? map['appStoreLink'] as String : null,
      launch: map['launch'] as dynamic,
      type: map['type'] != null ? EnumToString.fromString(ConfigType.values, map['type']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchemeModel.fromJson(String source) => SchemeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SchemeModel(androidPackageName: $androidPackageName, iosUrlScheme: $iosUrlScheme, appStoreLink: $appStoreLink, launch: $launch, type: $type)';
  }

  @override
  bool operator ==(covariant SchemeModel other) {
    if (identical(this, other)) return true;

    return other.androidPackageName == androidPackageName && other.iosUrlScheme == iosUrlScheme && other.appStoreLink == appStoreLink && other.launch == launch && other.type == type;
  }

  @override
  int get hashCode {
    return androidPackageName.hashCode ^ iosUrlScheme.hashCode ^ appStoreLink.hashCode ^ launch.hashCode ^ type.hashCode;
  }
}
