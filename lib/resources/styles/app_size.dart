// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:android_navigation_mode/android_navigation_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../shared/index.dart';

class AppSize {
  AppSize._();

  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late double screenPaddingTop;
  static late Orientation orientation;
  static late double sizeRatio;
  static late double topSafeAreaPadding;
  static late double bottomSafeAreaPadding;
  static late double devicePixelRatio;
  static double deviceNavigationHeight = 0;
  static late DeviceNavigationMode navigationMode;

  static Future<void> of(BuildContext context) async {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    sizeRatio = screenWidth / screenHeight;
    orientation = MediaQuery.orientationOf(context);
    devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    topSafeAreaPadding = MediaQuery.paddingOf(context).top;
    bottomSafeAreaPadding = (Platform.isIOS && screenHeight >= 812.0 && MediaQuery.paddingOf(context).bottom == 0) ? 34.0 : MediaQuery.paddingOf(context).bottom;
    if (Platform.isIOS) {
      screenPaddingTop = topSafeAreaPadding;
      navigationMode = DeviceNavigationMode.none;
      deviceNavigationHeight = bottomSafeAreaPadding;
    } else {
      screenPaddingTop = topSafeAreaPadding + 6;
      try {
        navigationMode = await AndroidNavigationMode.getNavigationMode;
      } on PlatformException {
        navigationMode = DeviceNavigationMode.none;
      }
      deviceNavigationHeight = navigationMode == DeviceNavigationMode.threeButton || navigationMode == DeviceNavigationMode.twoButton
          ? kMinInteractiveDimension
          : navigationMode == DeviceNavigationMode.fullScreenGesture
              ? 16.0
              : 0.0;
    }

    Log.d('AppSize > of: $navigationMode - $screenWidth - $screenHeight - $orientation - $devicePixelRatio - $screenPaddingTop - $bottomSafeAreaPadding - $deviceNavigationHeight');
  }

  bool isIphoneX() {
    if (Platform.isIOS && screenHeight >= 812.0) {
      return true;
    }
    return false;
  }

  static const XS = Gap(5);
  static const S = Gap(8);
  static const M = Gap(16);
  static const L = Gap(32);
  static const XL = Gap(64);
}
