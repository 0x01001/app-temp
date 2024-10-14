import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/index.dart';

final appPreferencesProvider = Provider((ref) => getIt.get<AppPreferences>());

@LazySingleton()
class AppPreferences {
  AppPreferences(this._sharedPreference)
      : _secureStorage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        );

  final SharedPreferences _sharedPreference;
  final FlutterSecureStorage _secureStorage;

  // keys should be removed when logout
  static const keyAccessToken = 'accessToken';
  static const keyRefreshToken = 'refreshToken';
  static const keyUserId = 'userId';
  static const keyEmail = 'email';
  static const keyPassword = 'password';
  static const keyDeviceToken = 'deviceToken';
  static const keyIsLoggedIn = 'isLoggedIn';

  // keys should not be removed when logout
  static const keyThemeMode = 'themeMode';
  static const keyLanguageCode = 'languageCode';
  static const keyNickName = 'nickName';
  static const keyIsFirstLaunchApp = 'isFirstLaunchApp';

  int get themeMode => _sharedPreference.getInt(keyThemeMode) ?? 0;
  String get deviceToken => _sharedPreference.getString(keyDeviceToken) ?? '';
  String get languageCode => _sharedPreference.getString(keyLanguageCode) ?? Constant.defaultLocale;
  bool get isFirstLaunchApp => _sharedPreference.getBool(keyIsFirstLaunchApp) ?? false;
  Future<String?> get accessToken async => _secureStorage.read(key: keyAccessToken);
  Future<String?> get refreshToken async => _secureStorage.read(key: keyRefreshToken);
  bool get isLoggedIn => _sharedPreference.getBool(keyIsLoggedIn) ?? false;

  Future<bool> saveThemeMode(int themeMode) {
    return _sharedPreference.setInt(keyThemeMode, themeMode);
  }

  Future<bool> saveLanguageCode(String languageCode) {
    return _sharedPreference.setString(keyLanguageCode, languageCode);
  }

  Future<bool> saveIsFirsLaunchApp(bool isFirstLaunchApp) {
    return _sharedPreference.setBool(keyIsFirstLaunchApp, isFirstLaunchApp);
  }

  Future<void> saveIsLoggedIn(bool isLoggedIn) async {
    await _sharedPreference.setBool(keyIsLoggedIn, isLoggedIn);
  }

  Future<void> saveAccessToken(String token) async {
    return _secureStorage.write(key: keyAccessToken, value: token);
  }

  Future<void> saveRefreshToken(String token) async {
    return _secureStorage.write(key: keyRefreshToken, value: token);
  }

  Future<bool> saveDeviceToken(String token) {
    return _sharedPreference.setString(keyDeviceToken, token);
  }

  String get userId => _sharedPreference.getString(keyUserId) ?? '';
  String get email => _sharedPreference.getString(keyEmail) ?? '';
  Future<String?> get password async => _secureStorage.read(key: keyPassword);

  Future<bool> saveUserId(String userId) {
    return _sharedPreference.setString(keyUserId, userId);
  }

  Future<bool> saveEmail(String email) {
    return _sharedPreference.setString(keyEmail, email);
  }

  Future<void> savePassword(String password) {
    return _secureStorage.write(key: keyPassword, value: password);
  }

  Future<bool> saveUserNickname({String? conversationId, String? memberId, String? nickname}) {
    final key = '$keyNickName/$userId/$conversationId/$memberId';
    return _sharedPreference.setString(key, nickname?.trim() ?? '');
  }

  String? getUserNickname({String? conversationId, String? memberId}) {
    final key = '$keyNickName/$userId/$conversationId/$memberId';
    return _sharedPreference.getString(key);
  }

  Future<void> clearCurrentUserData() async {
    await Future.wait(
      [
        _sharedPreference.remove(keyAccessToken),
        _sharedPreference.remove(keyRefreshToken),
        _sharedPreference.remove(keyDeviceToken),
        _sharedPreference.remove(keyUserId),
        _sharedPreference.remove(keyEmail),
        _sharedPreference.remove(keyPassword),
        _sharedPreference.remove(keyIsLoggedIn),
      ],
    );
  }
}
