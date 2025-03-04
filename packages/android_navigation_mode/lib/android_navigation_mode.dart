
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class AndroidNavigationMode {
  static const MethodChannel _channel =
      const MethodChannel('android_navigation_mode');

  static Future<DeviceNavigationMode> get getNavigationMode async {
    if(Platform.isIOS) {
      return DeviceNavigationMode.none;
    }
    final int mode = await _channel.invokeMethod('get_navigation_mode');
    switch(mode) {
      case 0:
        return DeviceNavigationMode.threeButton;
      case 1:
        return DeviceNavigationMode.twoButton;
      case 2:
        return DeviceNavigationMode.fullScreenGesture;
      default:
        return DeviceNavigationMode.none;
    }
  }
}

enum DeviceNavigationMode {
  twoButton,
  threeButton,
  fullScreenGesture,
  none
}
