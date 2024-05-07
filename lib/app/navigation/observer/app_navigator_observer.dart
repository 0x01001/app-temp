import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class AppNavigatorObserver extends NavigatorObserver {
  AppNavigatorObserver();
  // static const _enableLog = LogConfig.enableNavigatorObserverLog;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    // if (_enableLog) {
    //   Log.w('didPush: from ${previousRoute?.settings.name} to ${route.settings.name}');
    // }
    final msg = previousRoute?.settings.name != null ? 'push from ${previousRoute?.settings.name} to ${route.settings.name}' : 'push to ${route.settings.name}';
    getIt.get<AppFirebaseAnalytic>().logScreen(msg);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    // if (_enableLog) {
    //   Log.w('didPop: ${route.settings.name} back to ${previousRoute?.settings.name}');
    // }
    final msg = route.settings.name != null ? 'pop ${route.settings.name} back to ${previousRoute?.settings.name}' : 'back to ${previousRoute?.settings.name}';
    getIt.get<AppFirebaseAnalytic>().logScreen(msg);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    // if (_enableLog) {
    //   Log.w('didRemove: ${route.settings.name} back to ${previousRoute?.settings.name}');
    // }
    getIt.get<AppFirebaseAnalytic>().logScreen('remove ${route.settings.name} back to ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    // if (_enableLog) {
    //   Log.w('didReplace: ${oldRoute?.settings.name} by ${newRoute?.settings.name}');
    // }
    getIt.get<AppFirebaseAnalytic>().logScreen('replace ${oldRoute?.settings.name} by ${newRoute?.settings.name}');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
  }
}
