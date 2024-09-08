import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/index.dart';
import '../../data/index.dart';

extension WidgetRefExt on WidgetRef {
  AppNavigator get nav => read(appNavigatorProvider);
  ExceptionHandler get exception => read(exceptionHandlerProvider);
  // AnalyticsHelper get analyticsHelper => read(analyticsHelperProvider);
  AppFirebaseCrashlytics get crashlytics => read(appFirebaseCrashlyticsProvider);
  // ConnectivityHelper get connectivityHelper => read(connectivityHelperProvider);

  T update<T>(StateProvider<T> provider, T Function(T) cb) {
    return read(provider.notifier).update(cb);
  }
}

extension RefExt on Ref {
  // ui
  AppNavigator get nav => read(appNavigatorProvider);
  ExceptionHandler get exception => read(exceptionHandlerProvider);

  // local
  AppPreferences get appPreferences => read(appPreferencesProvider);
  // AppDatabase get appDatabase => read(appDatabaseProvider);

  // api
  AppApiService get api => read(appApiServiceProvider);
  // LoadMoreUsersExecutor get loadMoreUsersExecutor => read(loadMoreUsersExecutorProvider);

  // firebase
  FirebaseFirestoreService get firebaseFirestoreService => read(firebaseFirestoreServiceProvider);
  FirebaseAuthService get firebaseAuthService => read(firebaseAuthServiceProvider);
  FirebaseMessagingService get firebaseMessagingService => read(firebaseMessagingServiceProvider);

  // // mapper
  // MessageDataMapper messageDataMapper(String conversationId) => read(messageDataMapperProvider(conversationId));
  // RemoteMessageAppNotificationMapper get remoteMessageAppNotificationMapper => read(remoteMessageAppNotificationMapperProvider);

  // helper
  // AnalyticsHelper get analyticsHelper => read(analyticsHelperProvider);
  // ConnectivityHelper get connectivityHelper => read(connectivityHelperProvider);
  AppFirebaseCrashlytics get crashlytics => read(appFirebaseCrashlyticsProvider);
  // DeepLinkHelper get deepLinkHelper => read(deepLinkHelperProvider);
  // DeviceHelper get deviceHelper => read(deviceHelperProvider);
  AppLocalPushNotification get localPushNotification => read(appLocalPushNotificationProvider);
  // PackageHelper get packageHelper => read(packageHelperProvider);
  // SharedViewModel get sharedViewModel => read(sharedViewModelProvider);

  T update<T>(StateProvider<T> provider, T Function(T) cb) {
    return read(provider.notifier).update(cb);
  }
}
