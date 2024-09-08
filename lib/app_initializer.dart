import 'package:flutter/services.dart';

import 'app/index.dart';
import 'data/index.dart';
import 'domain/index.dart';
import 'shared/di/di.dart' as di;
import 'shared/index.dart';

class AppInitializer {
  static Future<void> init() async {
    Env.init();
    // di.getIt.registerSingleton<AppRouter>(AppRouter());
    await di.configureInjection();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    await SharedConfig.getInstance().init();
    await DataConfig.getInstance().init();
    await DomainConfig.getInstance().init();
    await AppConfig.getInstance().init();
  }
}
