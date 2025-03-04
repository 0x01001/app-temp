import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../../data/index.dart';

@LazySingleton()
class AppFirebaseRemoteConfig {
  AppFirebaseRemoteConfig(this._appPreferences, this._appInfo);

  final AppPreferences _appPreferences;
  final AppInfo _appInfo;
  ConfigModel? _configModel;
  ConfigModel? get config => _configModel;
  // StreamSubscription<RemoteConfigUpdate>? _streamSubscription;

  Future<void> init() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(fetchTimeout: 10.s, minimumFetchInterval: 60.s));

      // int retryCount = 0;
      // Retry logic if error
      // while (retryCount < 3) {
      try {
        Log.start('AppFirebaseRemoteConfig > fetchAndActivate() > start');
        final result = await remoteConfig.fetchAndActivate();
        Log.end('AppFirebaseRemoteConfig > fetchAndActivate() > done: $result');
        // break; // Exit the loop when successful
      } catch (e) {
        // retryCount++;
        if (e is FirebaseException && e.message == 'cancelled') {
          Log.e('AppFirebaseRemoteConfig > cancel...');
        } else {
          Log.e('AppFirebaseRemoteConfig > failed: $e');
        }
        // await Future.delayed(5.s); // Wait before retrying
      }
      // }

      // await remoteConfig.ensureInitialized();
      // remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate event) async {
      //   Log.d('AppFirebaseRemoteConfig > updatedKeys: ${event.updatedKeys.join(', ')}');
      // });

      // final scheme = remoteConfig.getString('scheme');
      final versionInReview = remoteConfig.getString('version_in_review');
      final isForceUpdateIos = remoteConfig.getBool('is_force_update_ios');
      final isForceUpdateAndroid = remoteConfig.getBool('is_force_update_android');
      final forceUpdateIosVersion = remoteConfig.getString('force_update_ios_version');
      final forceUpdateAndroidVersion = remoteConfig.getString('force_update_android_version');
      final whitelistLoginEmailDomains = remoteConfig.getString('whitelist_login_email_domains');
      final whitelistTesters = remoteConfig.getString('whitelist_testers');
      final whitelistIgnoreForceUpdate = remoteConfig.getString('whitelist_ignore_force_update');
      // final data = remoteConfig.getString('data');
      // final dataIV = remoteConfig.getString('data_iv');
      // final dataKey = remoteConfig.getString('data_key');

      final inReview = _isAppVersionInReview(_appInfo.version, _appInfo.versionCode, versionInReview);
      Log.d('AppFirebaseRemoteConfig > inReview = $inReview');
      final domains = whitelistLoginEmailDomains.isNotNullOrEmpty ? whitelistLoginEmailDomains.replaceAll(' ', '').replaceAll('\n', '').split(',') : null;
      final tester = whitelistTesters.isNotNullOrEmpty ? whitelistTesters.replaceAll(' ', '').replaceAll('\n', '').split(',') : null;
      final ignoreForceUpdate = whitelistIgnoreForceUpdate.isNotNullOrEmpty ? whitelistIgnoreForceUpdate.replaceAll(' ', '').replaceAll('\n', '').split(',') : null;

      // List<ResourceModel> resource = [];
      // final result = DataHelper.decrypt(data, dataKey, dataIV);
      // if (result.isNotEmpty) {
      //   resource = await compute((message) {
      //     return json.decode(message).map<ResourceModel>((x) => ResourceModel.fromMap(x)).toList();
      //   }, result);
      //   if (_appPreferences.resource == null) {
      //     final selected = resource.firstOrNullWhere((x) => x.active == true);
      //     if (selected != null) {
      //       await _appPreferences.saveResource(selected.toEntity());
      //     }
      //   }
      // }

      _configModel = ConfigModel(
        // scheme: SchemeModel.fromMap(
        //   {
        //     ...(scheme == '' ? {} : jsonDecode(scheme)),
        //     'type': 'xxx', // yyy
        //   },
        // ),
        // data: resource,
        inReview: inReview,
        versionInReview: versionInReview,
        isForceUpdateIos: isForceUpdateIos,
        isForceUpdateAndroid: isForceUpdateAndroid,
        forceUpdateIosVersion: forceUpdateIosVersion,
        forceUpdateAndroidVersion: forceUpdateAndroidVersion,
        whitelistLoginEmailDomains: domains,
        whitelistTesters: tester,
        whitelistIgnoreForceUpdate: ignoreForceUpdate,
        // dataIV: dataIV,
        // dataKey: dataKey,
      );
      Log.d('AppFirebaseRemoteConfig > init: ${_configModel.toString()}');
      if (isForceUpdate == true) {
        // TODO(dev): go to login screen
      }
    } catch (e) {
      Log.e('AppFirebaseRemoteConfig > e: $e');
    }
  }

  bool _isAppVersionInReview(String? version, String? versionCode, String? versionInReview) {
    final list = versionInReview?.replaceAll(' ', '').split(',') ?? [];
    Log.d('Version in review: $list');
    if (list.isEmpty) {
      return false;
    }
    final str = "${version?.replaceAll(" ", "")}_${versionCode?.replaceAll(" ", "")}";
    if (list.contains(str)) {
      return true;
    }
    return false;
  }

  bool isEmailInWhitelist(String? email) {
    if (email == null) return false;
    final list = _configModel?.whitelistLoginEmailDomains ?? [];
    for (var domain in list) {
      if (email.endsWith('@$domain') == true) {
        return true;
      }
    }
    return false;
  }

  String? get versionUpdate => Platform.isIOS ? _configModel?.forceUpdateIosVersion : _configModel?.forceUpdateAndroidVersion;
  bool? get isForceUpdate => Platform.isIOS ? _configModel?.isForceUpdateIos : _configModel?.isForceUpdateAndroid;
  bool isNeedUpdate() {
    if (versionUpdate?.isNotEmpty == true) {
      final currentVersion = '${_appInfo.version}_${_appInfo.versionCode}';
      if (currentVersion != versionUpdate) {}
    }
    return false;
  }
}
