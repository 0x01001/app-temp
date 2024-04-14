import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../shared/index.dart';

class AppUtils {
  const AppUtils._();
  // static bool isLoading = false;

  // Example:
  // static String mapGenderToText(Gender gender) {
  //   switch (gender) {
  //     case Gender.unknown:
  //       return '';
  //     case Gender.male:
  //       return S.current.re1_male;
  //     case Gender.female:
  //       return S.current.re1_female;
  //     case Gender.other:
  //       return S.current.re1_other;
  //   }
  // }

  static void showLoading({bool? enableTimeout = true}) {
    // isLoading = true;
    EasyLoading.show();
    if (enableTimeout == true) Future.delayed(const Duration(milliseconds: UiConstants.loadingTimeout), hideLoading);
  }

  static void hideLoading() {
    // isLoading = false;
    EasyLoading.dismiss();
  }

  static void configLoading() {
    //https://github.com/nslogx/flutter_easyloading/issues/135
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 3000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35
      ..textColor = Colors.black
      // ..radius = 20
      ..backgroundColor = Colors.transparent
      ..maskColor = Colors.black54
      ..maskType = EasyLoadingMaskType.black
      ..indicatorColor = Colors.white
      // ..userInteractions = false
      // ..dismissOnTap = false
      ..boxShadow = <BoxShadow>[] // important
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..lineWidth = 3.0;
  }
}
