// import 'dart:async';

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

import '../../domain/index.dart';
import '../index.dart';

@LazySingleton(as: AppRepository)
class AppRepositoryImpl implements AppRepository {
  AppRepositoryImpl(this._appApiService, this._appPreferences, this._appDatabase, this._appFirebaseAuth);

  final AppApiService _appApiService;
  final AppPreferences _appPreferences;
  final AppDatabase _appDatabase;
  final AppFirebaseAuth _appFirebaseAuth;
  bool? _isConnected;

  @override
  bool get isFirstLogin => _appPreferences.isFirstLogin;

  @override
  bool get isFirstLaunchApp => _appPreferences.isFirstLaunchApp;

  @override
  bool? get isConnected => _isConnected;

  @override
  Stream<bool> get onConnectivityChanged => Connectivity().onConnectivityChanged.map((event) {
        _isConnected = event != ConnectivityResult.none;
        // Log.d('onConnectivityChanged: $_isConnected');
        return _isConnected ?? false;
      });

  // @override
  // bool? get isDarkMode => _appPreferences.isDarkMode;

  @override
  String get languageCode => _appPreferences.languageCode;

  @override
  StreamSubscription<dynamic> subscriptionConnectivity() {
    return Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Log.d('subscriptionConnectivity: $result');
      _isConnected = result != ConnectivityResult.none;
    });
  }

  @override
  Future<bool> saveIsFirstLogin(bool isFirstLogin) {
    return _appPreferences.saveIsFirstLogin(isFirstLogin);
  }

  @override
  Future<bool> saveIsFirstLaunchApp(bool isFirstLaunchApp) {
    return _appPreferences.saveIsFirsLaunchApp(isFirstLaunchApp);
  }

  @override
  Future<bool> saveDeviceToken(String deviceToken) => _appPreferences.saveDeviceToken(deviceToken);

  @override
  Future<bool> saveLanguageCode(String languageCode) {
    return _appPreferences.saveLanguageCode(languageCode);
  }

  // @override
  // Future<bool> saveIsDarkMode(bool isDarkMode) => _appPreferences.saveIsDarkMode(isDarkMode);
}
