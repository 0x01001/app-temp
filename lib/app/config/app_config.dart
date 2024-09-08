import 'dart:async';

import 'package:firebase_core/firebase_core.dart';

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
    Log.d('App > config > start');

    await Firebase.initializeApp();
    getIt.get<AppFirebaseAnalytics>().init();
    // await getIt.get<AppLocalPushNotification>().init();
    // await getIt.get<AppFirebaseNotification>().init();
    await getIt.get<AppFirebaseRemoteConfig>().init();
    await getIt.get<AppCodePush>().init();

    Log.d('App > config > end');
  }
}
