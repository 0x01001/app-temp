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
  // static const keyIsLoggedIn = 'isLoggedIn';

  // keys should not be removed when logout
  static const keyIsDarkMode = 'isDarkMode';
  static const keyLanguageCode = 'languageCode';
  static const keyNickName = 'nickName';

  bool get isDarkMode {
    return _sharedPreference.getBool(keyIsDarkMode) ?? false;
  }

  String get deviceToken {
    return _sharedPreference.getString(keyDeviceToken) ?? '';
  }

  String get languageCode => _sharedPreference.getString(keyLanguageCode) ?? Constant.defaultLocale;

  // bool get isFirstLogin => _sharedPreference.getBool(keyIsFirstLogin) ?? true;

  // bool get isFirstLaunchApp => _sharedPreference.getBool(keyIsFirstLaunchApp) ?? true;

  Future<String> get accessToken async {
    return await _secureStorage.read(key: keyAccessToken) ?? '';
  }

  Future<String> get refreshToken async {
    return await _secureStorage.read(key: keyRefreshToken) ?? '';
  }

  bool get isLoggedIn {
    final token = _sharedPreference.getString(keyAccessToken) ?? '';
    return token.isNotEmpty;
  }

  // AuthModel? get currentUser {
  //   final user = _sharedPreference.getString(keyCurrentUser);
  //   if (user == null) return null;
  //   return AuthModel.fromJson(json.decode(user));
  // }

  Future<bool> saveIsDarkMode(bool isDarkMode) {
    return _sharedPreference.setBool(keyIsDarkMode, isDarkMode);
  }

  Future<bool> saveLanguageCode(String languageCode) {
    return _sharedPreference.setString(keyLanguageCode, languageCode);
  }

  // Future<bool> saveIsFirstLogin(bool isFirstLogin) {
  //   return _sharedPreference.setBool(keyIsFirstLogin, isFirstLogin);
  // }

  // Future<bool> saveIsFirsLaunchApp(bool isFirstLaunchApp) {
  //   return _sharedPreference.setBool(keyIsFirstLaunchApp, isFirstLaunchApp);
  // }

  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: keyAccessToken, value: token);
  }

  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: keyRefreshToken, value: token);
  }

  // Future<bool> saveCurrentUser(AuthModel data) {
  //   return _sharedPreference.setString(keyCurrentUser, json.encode(data));
  // }

  Future<bool> saveDeviceToken(String token) {
    return _sharedPreference.setString(keyDeviceToken, token);
  }

  Future<bool> saveUserId(String userId) {
    return _sharedPreference.setString(keyUserId, userId);
  }

  String get userId {
    return _sharedPreference.getString(keyUserId) ?? '';
  }

  Future<bool> saveEmail(String email) {
    return _sharedPreference.setString(keyEmail, email);
  }

  String get email {
    return _sharedPreference.getString(keyEmail) ?? '';
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
        // _sharedPreference.remove(keyIsLoggedIn),
      ],
    );
  }
}
