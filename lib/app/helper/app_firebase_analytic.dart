import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/index.dart';

final appFirebaseAnalyticsProvider = Provider<AppFirebaseAnalytics>(
  (ref) => getIt.get<AppFirebaseAnalytics>(),
);

@LazySingleton()
class AppFirebaseAnalytics {
  Future<void> init() async {
    _logAppOpen();
    Log.w('FirebaseAnalytics is supported: ${await FirebaseAnalytics.instance.isSupported()}');
  }

  Future<void> _logAppOpen({AnalyticsCallOptions? options, Map<String, dynamic>? parameters}) async {
    Log.w('[App-Analytics] App opennnnnnnnnnnnn');
    await FirebaseAnalytics.instance.logAppOpen(callOptions: options, parameters: parameters);
  }

  Future<void> logScreen(String screenName, {String? className}) async {
    Log.w('[App-Analytics] $screenName');
    await FirebaseAnalytics.instance.logScreenView(screenName: screenName, screenClass: className ?? 'App');
  }

  Future<void> logEvent(String eventName, {Map<String, dynamic>? parameters}) async {
    Log.w('[App-Analytics] $eventName');
    await FirebaseAnalytics.instance.logEvent(name: eventName, parameters: parameters);
  }

  Future<void> logLogin({String? loginMethod, Map<String, Object?>? parameters, AnalyticsCallOptions? callOptions}) async {
    Log.w('[App-Analytics] $loginMethod');
    await FirebaseAnalytics.instance.logLogin(loginMethod: loginMethod, parameters: parameters, callOptions: callOptions);
  }

  Future<void> logSignUp(String signUpMethod, {Map<String, dynamic>? parameters}) async {
    Log.w('[App-Analytics] $signUpMethod');
    await FirebaseAnalytics.instance.logSignUp(signUpMethod: signUpMethod, parameters: parameters);
  }
}
