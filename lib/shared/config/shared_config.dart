import 'package:get_it/get_it.dart';

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
    await GetIt.instance.get<AppInfo>().init();
    Log.d('Shared > config > end');
  }
}
