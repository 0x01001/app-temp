import 'dart:async';

import 'package:flutter/services.dart';

import '../../shared/index.dart';
import '../index.dart';

class AppConfig extends Config {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  @override
  Future<void> config() async {
    Log.start('App > config > start');

    // await SystemChrome.setPreferredOrientations(
    //   getIt.get<DeviceHelper>().deviceType == DeviceType.mobile ? Constant.mobileOrientation : Constant.tabletOrientation,
    // );
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    getIt.get<AppFirebaseAnalytics>().init();
    await getIt.get<AppLocalPushNotification>().init();
    await getIt.get<AppFirebaseNotification>().init();
    await getIt.get<AppFirebaseRemoteConfig>().init();
    await getIt.get<AppCodePush>().init();

    Log.end('App > config > end');
  }
}
