// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import '../index.dart';

class ConfigEntity extends BaseEntity {
  final SchemeEntity? scheme;
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

  const ConfigEntity({
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

  ConfigEntity copyWith({
    SchemeEntity? scheme,
    SchemeEntity? schemeSME,
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
    return ConfigEntity(
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
    return 'ConfigEntity(scheme: $scheme,   inReview: $inReview,  versionInReview: $versionInReview, whitelistLoginEmailDomains: $whitelistLoginEmailDomains, isForceUpdateIos: $isForceUpdateIos, isForceUpdateAndroid: $isForceUpdateAndroid, forceUpdateIosVersion: $forceUpdateIosVersion, forceUpdateAndroidVersion: $forceUpdateAndroidVersion, whitelistTesters: $whitelistTesters, whitelistIgnoreForceUpdate: $whitelistIgnoreForceUpdate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConfigEntity &&
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
