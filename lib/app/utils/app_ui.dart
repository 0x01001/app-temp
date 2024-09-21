import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:injectable/injectable.dart';

import '../../shared/index.dart';

@LazySingleton()
class AppUI {
  bool useIsFocused(FocusNode node) {
    final isFocused = useState(node.hasFocus);

    useEffect(
      () {
        void listener() {
          isFocused.value = node.hasFocus;
        }

        node.addListener(listener);
        return () => node.removeListener(listener);
      },
      [node],
    );

    return isFocused.value;
  }

  void showLoading({bool? enableTimeout = true}) {
    EasyLoading.show();
    if (enableTimeout == true) Future.delayed(const Duration(milliseconds: Constant.loadingTimeout), hideLoading);
  }

  void hideLoading() {
    EasyLoading.dismiss();
  }

  void configLoading() {
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
