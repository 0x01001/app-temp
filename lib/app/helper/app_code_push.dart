import 'package:injectable/injectable.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../../../shared/index.dart';
import '../index.dart';

@LazySingleton()
class AppCodePush {
  AppCodePush(this._remoteConfig);

  final AppFirebaseRemoteConfig _remoteConfig;
  final _shorebirdCodePush = ShorebirdCodePush();
  int? currentPatchVersion;

  Future<void> init() async {
    final _isShorebirdAvailable = _shorebirdCodePush.isShorebirdAvailable();
    Log.w('AppCodePush is supported: $_isShorebirdAvailable');
    if (!_isShorebirdAvailable) return;
    final version = await _shorebirdCodePush.currentPatchNumber();
    Log.d('AppCodePush > version: $version');
    final isUpdateAvailable = await _shorebirdCodePush.isNewPatchAvailableForDownload();
    Log.d('AppCodePush > isUpdateAvailable: $isUpdateAvailable');
    if (_remoteConfig.isForceUpdate == true) {
      //TODO: not implement
    }
  }
}
