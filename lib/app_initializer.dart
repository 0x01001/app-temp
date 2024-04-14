import 'app/index.dart';
import 'data/index.dart';
import 'domain/index.dart';
import 'shared/index.dart';

class AppInitializer {
  static Future<void> init() async {
    EnvConstants.init();
    await SharedConfig.getInstance().init();
    await DataConfig.getInstance().init();
    await DomainConfig.getInstance().init();
    await AppConfig.getInstance().init();
  }
}
