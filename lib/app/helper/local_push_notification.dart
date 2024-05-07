import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

import '../../shared/index.dart';

@LazySingleton()
class LocalPushNotification {
  static const _channelId = 'com.flutter.app';
  static const _channelName = 'NFT';
  static const _channelDescription = 'NFT';
  static const _androidDefaultIcon = 'ic_stat_ic_notification';
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
    await FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(const AndroidNotificationChannel(
          _channelId,
          _channelName,
          description: _channelDescription,
          importance: Importance.high,
        ));
  }

  Future<dynamic> _onSelectNotification(NotificationResponse res) async {
    /*Do whatever you want to do on notification click. In this case, I'll show an alert dialog*/
    // showDialog(
    //   context: context,
    //   builder: (_) => AlertDialog(
    //     title: Text(payload),
    //     content: Text("Payload: ${res.payload}"),
    //   ),
    // );
  }

  Future<void> notify(RemoteNotification? notification) async {
    File? imageFile;
    final img = Platform.isAndroid ? notification?.android?.imageUrl : notification?.apple?.imageUrl;
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
      icon: notification?.android?.smallIcon,
      // sound: const UriAndroidNotificationSound('assets/sound/pop.mp3'),
    );
    // const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await FlutterLocalNotificationsPlugin()
        .show(
          _randomNotificationId,
          notification?.title,
          notification?.body,
          platformChannelSpecifics,
          // TODO: handle later payload: jsonEncode(data),
        )
        .onError((error, stackTrace) => Log.e('Can not show notification cause $error'));
  }
}
