import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../shared/index.dart';

@LazySingleton()
class AppFirebaseNotification {
  String? token;
  late FirebaseMessaging messaging;

  void handleNotifi({RemoteMessage? message, String? notiType, int? contentId, bool isEventChallenge = false, dynamic model}) {
    try {
      final type = (message?.data['notificationType'] ?? notiType) as String?;
      // final context = Functions.getCurrentContext();
      // if (context == null) throw CustomException();
      // switch (type) {
      // case NotificationType.detailPost:
      //   break;
      // case NotificationType.game:
      //   break;
      //   default:
      // }
    } catch (e) {
      Log.d('Error $e'.toUpperCase());
    }
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    Log.d('firebaseMessagingBackgroundHandler: ${message.data}');
    handleNotifi(message: message);
  }

  Future<void> _firebaseMessagingOpenAppHandler(RemoteMessage message) async {
    // when tab on noti IOS is open and background, android in background
    handleNotifi(message: message);
    // final context = Functions.getCurrentContext();
    //   if (context != null) {
    //       ..updateNumberOfNotifiUnseen()
    //       ..updateNumberOfNotifiUnread();
    //   }
    // final type = message.data['notificationType'] as String?;
    // if (type == 'DetailPost') {
    // } else if (type == NotificationType.cscDetail || type == NotificationType.cscList) {
    // }
  }

  Future<void> _firebaseOnMessagingHandler(RemoteMessage message) async {
    // when app IOS and android is open and recived noti
    Log.d('firebaseOnMessagingHandler: ${message.notification}');
    // getIt.get<LocalPushNotification>().notify(notification); //TODO: show notify
  }

  Future<void> init() async {
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic('all');

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_firebaseOnMessagingHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingOpenAppHandler);

    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }
}
