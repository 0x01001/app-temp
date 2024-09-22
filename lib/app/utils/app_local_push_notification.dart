import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../shared/index.dart';

final appLocalPushNotificationProvider = Provider<AppLocalPushNotification>(
  (ref) => getIt.get<AppLocalPushNotification>(),
);

@LazySingleton()
class AppLocalPushNotification {
  static const _channelId = 'com.flutter.app';
  static const _channelName = 'channel_name';
  static const _channelDescription = 'Incoming call notifications';
  static const _androidDefaultIcon = 'ic_app_notification';
  static const _bitCount = 31;

  int get _randomNotificationId => Random().nextInt(pow(2, _bitCount).toInt() - 1);

  Future<void> init() async {
    /// Change icon at android\app\src\main\res\drawable\app_icon.png
    const androidInit = AndroidInitializationSettings(_androidDefaultIcon);
    const iOSInit = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);
    const init = InitializationSettings(android: androidInit, iOS: iOSInit);

    /// init local notification
    await Future.wait([
      FlutterLocalNotificationsPlugin().initialize(init, onDidReceiveNotificationResponse: _onSelectNotification),
    ]);

    /// Create an Android Notification Channel.
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
          const AndroidNotificationChannel(
            _channelId,
            _channelName,
            description: _channelDescription,
            importance: Importance.high,
          ),
        );
  }

  Future<dynamic> _onSelectNotification(NotificationResponse res) async {
    Log.d('_onSelectNotification: ${res.payload}');
    switch (res.notificationResponseType) {
      case NotificationResponseType.selectedNotification:
        if (res.payload != null) {
          try {
            // final data = jsonDecode(res.payload!);
            // DeepLinkHelper.getInstance().run(data['deeplink']);
          } catch (error) {
            Log.d('Notification payload error $error');
          }
        }
        break;
      default:
    }
  }

  Future<void> notify(RemoteMessage message) async {
    File? imageFile;
    final img = message.data['image'];
    if (img?.isNotEmpty == true) {
      imageFile = await FileUtils.getImageFileFromUrl(img!);
      Log.d('Downloaded Image File: $imageFile');
    }

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      autoCancel: true,
      enableVibration: true,
      playSound: true,
      styleInformation: imageFile != null ? BigPictureStyleInformation(FilePathAndroidBitmap(imageFile.path), hideExpandedLargeIcon: true) : null,
      icon: message.notification?.android?.smallIcon,
      // sound: const UriAndroidNotificationSound('assets/sound/pop.mp3'),
    );
    final iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      attachments: [DarwinNotificationAttachment(imageFile?.path ?? '')],
      threadIdentifier: 'temp_app',
    );
    final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await FlutterLocalNotificationsPlugin()
        .show(
          _randomNotificationId,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics,
          payload: jsonEncode(message.data), // importance for payload of onDidReceiveNotificationResponse
        )
        .onError((error, stackTrace) => Log.e('Can not show notification cause $error'));
  }

  Future<void> cancelAll() async => await FlutterLocalNotificationsPlugin().cancelAll();
}
