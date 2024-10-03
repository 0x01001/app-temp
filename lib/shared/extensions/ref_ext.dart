import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/index.dart';
import '../../data/index.dart';
import '../index.dart';

extension WidgetRefExt on WidgetRef {
  AppNavigator get nav => read(appNavigatorProvider);
  ExceptionHandler get exception => read(exceptionHandlerProvider);
  AppFirebaseAnalytics get analytics => read(appFirebaseAnalyticsProvider);
  AppFirebaseCrashlytics get crashlytics => read(appFirebaseCrashlyticsProvider);
  AppConnectivity get connectivity => read(appConnectivityProvider);

  T update<T>(StateProvider<T> provider, T Function(T) cb) {
    return read(provider.notifier).update(cb);
  }
}

extension RefExt on Ref {
  // ui
  AppNavigator get nav => read(appNavigatorProvider);
  ExceptionHandler get exception => read(exceptionHandlerProvider);

  // local
  AppPreferences get preferences => read(appPreferencesProvider);
  AppDatabase get database => read(appDatabaseProvider);

  // api
  AppApiService get api => read(appApiServiceProvider);

  // firebase
  FirebaseFirestoreService get firebaseFirestore => read(firebaseFirestoreServiceProvider);
  FirebaseAuthService get firebaseAuth => read(firebaseAuthServiceProvider);
  AppFirebaseNotification get firebaseNotification => read(appFirebaseNotificationProvider);

  // helper
  AppFirebaseAnalytics get analytics => read(appFirebaseAnalyticsProvider);
  AppFirebaseCrashlytics get crashlytics => read(appFirebaseCrashlyticsProvider);
  DeepLinkHelper get deepLink => read(deepLinkHelperProvider);
  DeviceHelper get device => read(deviceHelperProvider);
  AppLocalPushNotification get localPush => read(appLocalPushNotificationProvider);
  AppConnectivity get connectivity => read(appConnectivityProvider);

  // provider
  ShareProvider get share => read(shareProvider);

  T update<T>(StateProvider<T> provider, T Function(T) cb) {
    return read(provider.notifier).update(cb);
  }
}
