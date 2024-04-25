import 'dart:async';

abstract class AppRepository {
  // Future<void> init();

  bool get isFirstLaunchApp;

  bool get isFirstLogin;

  // bool? get isDarkMode;

  String get languageCode;

  bool? get isConnected;

  Stream<bool> get onConnectivityChanged;

  StreamSubscription<dynamic> subscriptionConnectivity();

  Future<bool> saveDeviceToken(String deviceToken);

  Future<bool> saveIsFirstLogin(bool isFirstLogin);

  Future<bool> saveIsFirstLaunchApp(bool isFirstLaunchApp);

  // Future<bool> saveIsDarkMode(bool isDarkMode);

  Future<bool> saveLanguageCode(String languageCode);
}
