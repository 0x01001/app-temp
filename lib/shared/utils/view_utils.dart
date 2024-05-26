import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/index.dart';
import '../index.dart';

class ViewUtils {
  const ViewUtils._();
  static Flushbar<dynamic>? _flushbar;

  static void showAppSnackBar(BuildContext context, String message, {Duration? duration, Color? backgroundColor, SnackBarAction? action, bool? autoDismiss}) {
    final messengerState = hideAppSnackBar(context);
    messengerState?.showSnackBar(SnackBar(
      content: AppText(message, lineHeight: 3),
      duration: duration ?? DurationConstants.defaultSnackBarDuration,
      backgroundColor: backgroundColor,
      action: action,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(right: 15, left: 15, bottom: 0),
      // margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height - 200 - kBottomNavigationBarHeight, right: 15, left: 15),
      dismissDirection: DismissDirection.up,
    ));

    if (autoDismiss == true && action != null) {
      Future.delayed(DurationConstants.defaultSnackBarDuration, () {
        hideAppSnackBar(context);
      });
    }
  }

  static ScaffoldMessengerState? hideAppSnackBar(BuildContext context) {
    final messengerState = ScaffoldMessenger.maybeOf(context);
    if (messengerState == null) {
      return null;
    }
    messengerState.hideCurrentSnackBar();
    return messengerState;
  }

  static void showTopBarMessage(BuildContext context, String message, {Duration? duration, Color? backgroundColor, Widget? icon}) {
    // _flushbar = Flushbar(
    //   positionOffset: kToolbarHeight + AppSize.topSafeAreaPadding,
    //   margin: const EdgeInsets.all(15),
    //   borderRadius: BorderRadius.circular(8),
    //   flushbarPosition: FlushbarPosition.TOP,
    //   message: message,
    //   duration: duration ?? DurationConstants.defaultTopBarDuration,
    //   backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surfaceVariant,
    //   messageColor: Theme.of(context).colorScheme.inverseSurface,
    //   icon: icon,
    //   shouldIconPulse: false,
    //   animationDuration: const Duration(milliseconds: 300),
    // )..show(context);
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon != null) icon,
            AppText(message, type: TextType.title),
          ],
        ),
        actions: [],
        //   [TextButton(
        //     onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
        //     child: const Text('DISMISS'),
        //   ),
        // ],
      ),
    );
    Future.delayed(
      duration ?? DurationConstants.defaultTopBarDuration,
      () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
    );
  }

  static void hideTopBarMessage() {
    // _flushbar?.dismiss();
    final context = AppSize.buildContext;
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }

  static void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  //https://stackoverflow.com/questions/49418332/flutter-how-to-prevent-device-orientation-changes-and-force-portrait
  static Future<void> setPreferredOrientations(List<DeviceOrientation> orientations) {
    return SystemChrome.setPreferredOrientations(orientations);
  }

  /// set status bar color & navigation bar color
  static void setSystemUIOverlayStyle(SystemUiOverlayStyle systemUiOverlayStyle) {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  static Offset? getWidgetPosition(GlobalKey globalKey) {
    return (globalKey.currentContext?.findRenderObject() as RenderBox?)?.let((it) => it.localToGlobal(Offset.zero));
  }

  static double? getWidgetWidth(GlobalKey globalKey) {
    return (globalKey.currentContext?.findRenderObject() as RenderBox?)?.let((it) => it.size.width);
  }

  static double? getWidgetHeight(GlobalKey globalKey) {
    return (globalKey.currentContext?.findRenderObject() as RenderBox?)?.let((it) => it.size.height);
  }
}
