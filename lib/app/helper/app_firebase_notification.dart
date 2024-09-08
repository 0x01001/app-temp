import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

// import 'package:injectable/injectable.dart';

import '../../shared/index.dart';
import '../index.dart';

/// Null check operator used on a null value
/// 1. It must not be an anonymous function.
/// 2. It must be a top-level function (e.g. not a class method which requires initialization).
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  Log.d('[AppFirebaseNotification] onBackgroundMessage: title: ${message.notification?.title}\nbody: ${message.notification?.body}\ndata: ${message.data}');
  getIt.get<AppFirebaseNotification>().handleNotifi(message: message);
}

@LazySingleton()
class AppFirebaseNotification {
  String? token;
  // late FirebaseMessaging messaging;

  void handleNotifi({RemoteMessage? message, String? notiType, int? contentId, bool isEventChallenge = false, dynamic model}) {
    // try {
    //   final type = (message?.data['notificationType'] ?? notiType) as String?;
    //   // final context = Functions.getCurrentContext();
    // } catch (e) {
    //   Log.d('handleNotifi > error: $e');
    // }
  }

  Future<void> _firebaseMessagingOpenAppHandler(RemoteMessage message) async {
    // when tab on noti IOS is open and background, android in background
    getIt.get<AppLocalPushNotification>().cancelAll();
    // DeepLinkHelper.getInstance().run(message.data['deeplink']);
  }

  Future<void> _firebaseOnMessagingHandler(RemoteMessage message) async {
    // when app IOS and android is open and recived noti
    Log.d('firebaseOnMessagingHandler: ${message.notification}');
    getIt.get<AppLocalPushNotification>().notify(message);
  }

  Future<void> init() async {
    // messaging = FirebaseMessaging.instance;  // don't using that
    // messaging.subscribeToTopic('all');

    FirebaseMessaging.onMessage.listen(_firebaseOnMessagingHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingOpenAppHandler);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      // announcement: true,
      badge: true,
      // carPlay: false,
      // criticalAlert: true,
      // provisional: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
