import 'dart:io';

import 'package:flutter/widgets.dart';

class AppSize {
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late double screenPaddingTop;
  static late Orientation orientation;
  static late double sizeRatio;

  static late double topSafeAreaPadding;
  static late double bottomSafeAreaPadding;
  static late double devicePixelRatio;

  // static late BuildContext buildContext;

  static void init(BuildContext context) {
    // buildContext = context;
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    sizeRatio = screenWidth / screenHeight;
    orientation = MediaQuery.orientationOf(context);
    devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    topSafeAreaPadding = MediaQuery.paddingOf(context).top;
    bottomSafeAreaPadding = (Platform.isIOS && screenHeight >= 812.0 && MediaQuery.paddingOf(context).bottom == 0) ? 34.0 : MediaQuery.paddingOf(context).bottom;

    if (Platform.isIOS) {
      screenPaddingTop = topSafeAreaPadding;
    } else {
      screenPaddingTop = topSafeAreaPadding + 6;
    }
  }

  static bool isIphoneX() {
    if (Platform.isIOS && screenHeight >= 812.0) {
      return true;
    }
    return false;
  }
}
