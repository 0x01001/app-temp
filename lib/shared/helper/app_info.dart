import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../index.dart';

@LazySingleton()
class AppInfo {
  PackageInfo? _packageInfo;

  String get appName => _packageInfo?.appName ?? '';
  String get applicationId => _packageInfo?.packageName ?? '';
  String get versionCode => _packageInfo?.buildNumber ?? ''; //1.0.0_x
  String get version => _packageInfo?.version ?? ''; //x.x.x_1

  Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();
    Log.d('APP INFO: ${_packageInfo?.packageName} | ${_packageInfo?.appName} | ${_packageInfo?.version}-${_packageInfo?.buildNumber}');
  }
}
