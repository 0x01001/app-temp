import '../../shared/index.dart';

class DataConfig extends Config {
  DataConfig._();

  factory DataConfig.getInstance() {
    return _instance;
  }

  static final DataConfig _instance = DataConfig._();

  @override
  Future<void> config() async {
    Log.d('Data > config > start');
    Log.d('Data > config > end');
  }
}
