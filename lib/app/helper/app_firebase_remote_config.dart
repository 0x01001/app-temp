import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';
import '../../domain/index.dart';

@LazySingleton()
class AppFirebaseRemoteConfig {
  AppFirebaseRemoteConfig(this._appInfo);

  final AppInfo _appInfo;
  ConfigEntity? _configModel;
  ConfigEntity? get config => _configModel;

  Future<void> init() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 60),
          minimumFetchInterval: const Duration(seconds: 0),
        ),
      );
      // await Future.delayed(const Duration(seconds: 1));
      await remoteConfig.fetchAndActivate();
      // final schemeKHCN = remoteConfig.getString('schemeKHCN');
      final versionInReview = remoteConfig.getString('versionInReview');
      final isForceUpdateIos = remoteConfig.getBool('isForceUpdateIos');
      final isForceUpdateAndroid = remoteConfig.getBool('isForceUpdateAndroid');
      final forceUpdateIosVersion = remoteConfig.getString('forceUpdateIosVersion');
      final forceUpdateAndroidVersion = remoteConfig.getString('forceUpdateAndroidVersion');
      final whitelistLoginEmailDomains = remoteConfig.getString('whitelistLoginEmailDomains');
      final whitelistTesters = remoteConfig.getString('whitelistTesters');
      final whitelistIgnoreForceUpdate = remoteConfig.getString('whitelistIgnoreForceUpdate');
      // final data = remoteConfig.getString('data');

      final inReview = _isAppVersionInReview(_appInfo.version, _appInfo.versionCode, versionInReview);
      Log.d('AppFirebaseRemoteConfig > inReview = $inReview');
      final domains = whitelistLoginEmailDomains.replaceAll(' ', '').split(',');
      final tester = whitelistTesters.isNotEmpty ? whitelistTesters.replaceAll(' ', '').replaceAll('\n', '').split(',') : null;
      final ignoreForceUpdate = whitelistIgnoreForceUpdate.isNotEmpty ? whitelistIgnoreForceUpdate.replaceAll(' ', '').replaceAll('\n', '').split(',') : null;

      // List<ResourceModel> resource = [];
      // final result = DataHelper.decrypt(data);
      // if (result.isNotEmpty) {
      //   resource = await compute((message) {
      //     return json.decode(message).map<ResourceModel>((x) => ResourceModel.fromMap(x)).toList();
      //   }, result);
      // }

      _configModel = ConfigEntity(
        // schemeKHCN: SchemeModel.fromMap(
        //   {
        //     ...(schemeKHCN == '' ? {} : jsonDecode(schemeKHCN)),
        //     'type': 'khcn',
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
      );
      Log.d('AppFirebaseRemoteConfig > init: ${_configModel.toString()}');
    } catch (e) {
      Log.e(e.toString());
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
