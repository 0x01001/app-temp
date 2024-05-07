import '../index.dart';

class SharedConfig extends Config {
  SharedConfig._();

  factory SharedConfig.getInstance() {
    return _instance;
  }

  static final SharedConfig _instance = SharedConfig._();

  @override
  Future<void> config() async {
    Log.d('Shared > config > start');
    await getIt.get<AppInfo>().init();
    Log.d('Shared > config > end');
  }
}
