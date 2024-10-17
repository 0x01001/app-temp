import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../shared/index.dart';
import '../index.dart';

class AppUtils {
  const AppUtils._();

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

  static Flushbar<dynamic>? _flushbar;

  static void showAppSnackBar(BuildContext context, String message, {Duration? duration, Color? backgroundColor, SnackBarAction? action, bool? autoDismiss}) {
    final messengerState = hideAppSnackBar(context);
    messengerState?.showSnackBar(SnackBar(
      content: AppText(message, lineHeight: 3),
      duration: duration ?? Constant.defaultSnackBarDuration,
      backgroundColor: backgroundColor,
      action: action,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(right: 15, left: 15, bottom: 0),
      // margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height - 200 - kBottomNavigationBarHeight, right: 15, left: 15),
      dismissDirection: DismissDirection.up,
    ));

    if (autoDismiss == true && action != null) {
      Future.delayed(Constant.defaultSnackBarDuration, () {
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
    _flushbar = Flushbar(
      positionOffset: kToolbarHeight + AppSize.topSafeAreaPadding,
      margin: const EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration: duration ?? Constant.defaultTopBarDuration,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest,
      messageColor: Theme.of(context).colorScheme.inverseSurface,
      icon: icon,
      shouldIconPulse: false,
      animationDuration: const Duration(milliseconds: 300),
    )..show(context);
    // ScaffoldMessenger.of(context).showMaterialBanner(
    //   MaterialBanner(
    //     content: Row(
    //       mainAxisSize: MainAxisSize.max,
    //       children: [
    //         if (icon != null) icon,
    //         AppText(message, type: TextType.title),
    //       ],
    //     ),
    //     actions: [],
    //     //   [TextButton(
    //     //     onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
    //     //     child: const Text('DISMISS'),
    //     //   ),
    //     // ],
    //   ),
    // );
    // Future.delayed(
    //   duration ?? DurationConstants.defaultTopBarDuration,
    //   () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
    // );
  }

  static void hideTopBarMessage() {
    _flushbar?.dismiss();
    // final context = AppSize.buildContext;
    // ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
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

  static String randomName() {
    final _random = Random();

    const _names = [
      'Dog',
      'Cat',
      'Elephant',
      'Lion',
      'Tiger',
      'Giraffe',
      'Zebra',
      'Bear',
      'Monkey',
      'Horse',
      'Cow',
      'Sheep',
      'Goat',
      'Pig',
      'Rabbit',
      'Deer',
      'Fox',
      'Wolf',
      'Kangaroo',
      'Panda',
      'Dolphin',
      'Whale',
      'Shark',
      'Octopus',
      'Penguin',
      'Seal',
      'Otter',
      'Walrus',
      'Bat',
      'Squirrel',
      'Chipmunk',
      'Raccoon',
      'Beaver',
      'Koala',
      'Platypus',
      'Ostrich',
      'Emu',
      'Parrot',
      'Toucan',
      'Pelican',
      'Hummingbird',
      'Eagle',
      'Hawk',
      'Falcon',
      'Owl',
      'Sparrow',
      'Crow',
      'Swan',
      'Flamingo',
      'Heron',
      'Peacock',
      'Pigeon',
      'Seagull',
      'Albatross',
      'Cockatoo',
      'Macaw',
      'Cockroach',
      'Grasshopper',
      'Ant',
      'Bee',
      'Wasp',
      'Butterfly',
      'Moth',
      'Caterpillar',
      'Dragonfly',
      'Ladybird',
      'Beetle',
      'Scorpion',
      'Spider',
      'Tarantula',
      'Centipede',
      'Millipede',
      'Earthworm',
      'Slug',
      'Snail',
      'Jellyfish',
      'Starfish',
      'Crab',
      'Lobster',
      'Shrimp',
    ];

    return '${_names[_random.nextInt(_names.length)]}${_random.nextInt(100)}';
  }
}
