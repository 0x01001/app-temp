import 'dart:async';

import 'package:flutter/services.dart';

import '../../shared/index.dart';

class AppConfig extends Config {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  @override
  Future<void> config() async {
    Log.d('App > config > start');

    // await SystemChrome.setPreferredOrientations(
    //   getIt.get<DeviceHelper>().deviceType == DeviceType.mobile ? Constant.mobileOrientation : Constant.tabletOrientation,
    // );
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setSystemUIOverlayStyle(Constant.systemUiOverlay);

    Log.d('App > config > end');
  }
}
