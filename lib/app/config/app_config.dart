import 'dart:async';

import 'package:firebase_core/firebase_core.dart';

import '../../shared/index.dart';
import '../di/di.dart' as di;
import '../index.dart';

class AppConfig extends Config {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  @override
  Future<void> config() async {
    Log.d('App > config > start');

    di.getIt.registerSingleton<AppRouter>(AppRouter());
    await di.configureInjection();
    await Firebase.initializeApp();
    di.getIt.get<AppFirebaseAnalytic>().init();
    await di.getIt.get<AppFirebaseRemoteConfig>().init();
    await di.getIt.get<LocalPushNotification>().init();
    await di.getIt.get<AppCodePush>().init();

    Log.d('App > config > end');
  }
}
