import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
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
  // StreamSubscription<RemoteConfigUpdate>? _streamSubscription;

  Future<void> init() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: Duration.zero,
      ));

      try {
        await remoteConfig.activate();
        // Only fetch after a delay to prevent an internal bug from occurring
        // See https://github.com/FirebaseExtended/flutterfire/issues/6196
        await Future<void>.delayed(const Duration(seconds: 1));
        Log.d('AppFirebaseRemoteConfig > fetchAndActivate() > start');
        final result = await remoteConfig.fetchAndActivate();
        Log.d('AppFirebaseRemoteConfig > fetchAndActivate() > done: $result');
      } catch (error) {
        if (error is FirebaseException && error.message == 'cancelled') {
          // do nothing; this happens when fetchAndActivate() is called
          // multiple times at once (before the other calls are finished)
          Log.e('AppFirebaseRemoteConfig > cancel...');
        } else {
          Log.e('AppFirebaseRemoteConfig > e: $error');
        }
      }
      // await remoteConfig.ensureInitialized();
      // remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate event) async {
      //   Log.d('AppFirebaseRemoteConfig > updatedKeys: ${event.updatedKeys.join(', ')}');
      // });

      // final scheme = remoteConfig.getString('scheme');
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
      );
      Log.d('AppFirebaseRemoteConfig > init: ${_configModel.toString()}');
      if (isForceUpdate == true) {
        //TODO: not implement
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
