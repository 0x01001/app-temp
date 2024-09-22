import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class AppNavigatorObserver extends NavigatorObserver {
  AppNavigatorObserver();
  // static const _enableLog = Constant.enableNavigatorObserverLog;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final msg = previousRoute?.settings.name != null ? 'push from ${previousRoute?.settings.name} to ${route.settings.name}' : 'push to ${route.settings.name}';
    // if (_enableLog) Log.w(msg);
    getIt.get<AppFirebaseAnalytics>().logScreen(msg);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final msg = route.settings.name != null ? 'pop ${route.settings.name} back to ${previousRoute?.settings.name}' : 'back to ${previousRoute?.settings.name}';
    // if (_enableLog) Log.w(msg);
    getIt.get<AppFirebaseAnalytics>().logScreen(msg);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    final msg = 'remove ${route.settings.name} back to ${previousRoute?.settings.name}';
    // if (_enableLog) Log.w(msg);
    getIt.get<AppFirebaseAnalytics>().logScreen(msg);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final msg = 'replace ${oldRoute?.settings.name} by ${newRoute?.settings.name}';
    // if (_enableLog) Log.w(msg);
    getIt.get<AppFirebaseAnalytics>().logScreen(msg);
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
