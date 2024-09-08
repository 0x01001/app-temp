import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';

@LazySingleton()
class AppFirebaseAnalytics {
  FirebaseAnalytics? _analytics;

  Future<void> init() async {
    _analytics = FirebaseAnalytics.instance;
    _logAppOpen();
    Log.w('FirebaseAnalytics is supported: ${await _analytics?.isSupported()}');
  }

  Future<void> _logAppOpen({AnalyticsCallOptions? options, Map<String, dynamic>? parameters}) async {
    Log.w('[App-Analytics] App opennnnnnnnnnnnn');
    await _analytics?.logAppOpen(callOptions: options, parameters: parameters);
  }

  Future<void> logScreen(String screenName, {String? className}) async {
    Log.w('[App-Analytics] $screenName');
    await _analytics?.logScreenView(screenName: screenName, screenClass: className ?? 'App');
  }

  Future<void> logEvent(String eventName, {Map<String, dynamic>? parameters}) async {
    Log.w('[App-Analytics] $eventName');
    await _analytics?.logEvent(name: eventName, parameters: parameters);
  }

  Future<void> logLogin({String? loginMethod, Map<String, Object?>? parameters, AnalyticsCallOptions? callOptions}) async {
    Log.w('[App-Analytics] $loginMethod');
    await _analytics?.logLogin(loginMethod: loginMethod, parameters: parameters, callOptions: callOptions);
  }

  Future<void> logSignUp(String signUpMethod, {Map<String, dynamic>? parameters}) async {
    Log.w('[App-Analytics] $signUpMethod');
    await _analytics?.logSignUp(signUpMethod: signUpMethod, parameters: parameters);
  }
}
