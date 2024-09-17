import 'app/index.dart';
import 'data/index.dart';
import 'shared/di/di.dart' as di;
import 'shared/index.dart';

class AppInitializer {
  static Future<void> init() async {
    Env.init();
    await di.configureInjection();
    await SharedConfig.getInstance().init();
    await DataConfig.getInstance().init();
    await AppConfig.getInstance().init();
  }
}
