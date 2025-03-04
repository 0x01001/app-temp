import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class AppPopup {
  const AppPopup._({required this.builder, required this.id});

  final String id;
  final Widget Function(BuildContext, AppNavigator) builder;

  @override
  String toString() => id;

  static AppPopup contentDialog(Widget content, {EdgeInsets? contentPadding, String? title, VoidCallback? onPressed}) {
    return AppPopup._(
      id: 'contentDialog',
      builder: (context, navigator) => CommonDialog(
        title: title,
        content: content,
        contentPadding: contentPadding,
        actions: onPressed != null
            ? [
                PopupButton(
                    text: S.current.ok,
                    onPressed: () {
                      navigator.pop(result: true, useRootNavigator: true);
                      onPressed.call();
                    }),
              ]
            : [],
      ),
    );
  }

  static AppPopup errorDialog(String message, {VoidCallback? onPressed}) {
    return AppPopup._(
      id: 'errorDialog_$message',
      builder: (context, navigator) => CommonDialog(
        message: message,
        actions: [
          PopupButton(
              text: S.current.ok,
              onPressed: () {
                navigator.pop(result: true, useRootNavigator: true);
                onPressed?.call();
              }),
        ],
      ),
    );
  }

  static AppPopup goToSettingDialog(String message, {VoidCallback? onPressed}) {
    return AppPopup._(
      id: 'errorDialog_$message',
      builder: (context, navigator) => CommonDialog(
        message: message,
        actions: [
          PopupButton(
              text: 'Go to setting',
              onPressed: () {
                navigator.pop(result: true, useRootNavigator: true);
                onPressed?.call();
              }),
        ],
      ),
    );
  }

  // ignore: prefer_named_parameters
  static AppPopup confirmDialog(String title, {String? message, VoidCallback? onConfirm, VoidCallback? onCancel}) {
    return AppPopup._(
      id: 'confirmDialog_$title',
      builder: (context, navigator) => CommonDialog(
        title: title,
        message: message,
        actions: [
          PopupButton(
            text: S.current.cancel,
            onPressed: onCancel ?? () => navigator.pop(result: false, useRootNavigator: true),
          ),
          PopupButton(
              text: S.current.ok,
              onPressed: () {
                navigator.pop(result: true, useRootNavigator: true);
                onConfirm?.call();
              }),
        ],
      ),
    );
  }

  static AppPopup errorWithRetryDialog({required String message, required VoidCallback? onRetryPressed}) {
    return AppPopup._(
      id: 'errorDialog_$message',
      builder: (context, navigator) => CommonDialog(
        message: message,
        actions: [
          PopupButton(
            text: S.current.cancel,
            onPressed: () => navigator.pop(result: false, useRootNavigator: true),
          ),
          PopupButton(
              text: S.current.retry,
              onPressed: () {
                navigator.pop(result: true, useRootNavigator: true);
                onRetryPressed?.call();
              }),
        ],
      ),
    );
  }

  static AppPopup requiredLoginDialog() {
    return AppPopup._(
      id: 'requiredLoginDialog',
      builder: (context, navigator) => CommonDialog(
        message: 'Requires recent login',
        actions: [
          PopupButton(
            text: S.current.cancel,
            onPressed: () => navigator.pop(result: false, useRootNavigator: true),
          ),
          PopupButton(
              text: S.current.retry,
              onPressed: () {
                navigator.replaceAll([const LoginRoute()]);
              }),
        ],
      ),
    );
  }

  static AppPopup forceLogout(String message) {
    return AppPopup._(
      id: 'forceLogout$message',
      builder: (context, navigator) => CommonDialog(
        message: message,
        actions: [
          PopupButton(
              text: S.current.ok,
              onPressed: () {
                navigator.pop(result: true, useRootNavigator: true);
              }),
        ],
      ),
    );
  }

  static AppPopup changeOptionsBottomSheet() {
    return AppPopup._(
      id: 'changeOptionsBottomSheet',
      builder: (context, navigator) => CupertinoAlertDialog(
        actions: [
          CupertinoDialogAction(
            onPressed: () => navigator.pop(result: true),
            child: AppText(S.current.ok),
          ),
          CupertinoDialogAction(
            onPressed: () => navigator.pop(result: false),
            child: AppText(S.current.cancel),
          ),
        ],
      ),
    );
  }

  static AppPopup successSnackBar(String message, {SnackBarAction? action}) {
    return AppPopup._(
      id: 'successSnackBar_$message',
      builder: (context, navigator) => SnackBar(
        content: AppText(message),
        duration: Constant.snackBarDuration,
        backgroundColor: context.colors.surface,
        action: action,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(Constant.defaultPadding),
        elevation: 10,
      ),
    );
  }

  static AppPopup errorSnackBar(String message, {SnackBarAction? action}) {
    return AppPopup._(
      id: 'errorSnackBar_$message',
      builder: (context, navigator) => SnackBar(
        content: AppText(message),
        duration: Constant.snackBarDuration,
        backgroundColor: context.colors.surface,
        action: action,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(Constant.defaultPadding),
        elevation: 10,
      ),
    );
  }

  static AppPopup maintenanceModeDialog({required String message, String? time, VoidCallback? onPressed}) {
    return AppPopup._(
      id: 'maintenanceModeDialog_$message',
      builder: (context, navigator) => CommonDialog(
        title: S.current.messageMaintenance,
        message: 'We will be back shortly, don\'t panic.',
        actions: [
          PopupButton(
              text: S.current.ok,
              onPressed: () {
                navigator.pop(result: true, useRootNavigator: true);
                onPressed?.call();
              }),
        ],
      ),
    );
    // return AppPopup._(
    //   id: 'maintenanceModeDialog_$message'.hardcoded,
    //   builder: (context, navigator) => Scaffold(
    //     body: Container(
    //       color: context.colors.surface,
    //       padding: const EdgeInsets.all(24),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: [
    //           // Align(alignment: Alignment.topCenter, child: appImage.appLogo.svg(width: 128, height: 128)),
    //           const SizedBox(height: 32),
    //           AppText(S.current.messageMaintenance),
    //           const SizedBox(height: 8),
    //           Container(
    //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: context.colors.outlineVariant)),
    //             padding: const EdgeInsets.all(12),
    //             child: AppText(message),
    //           ),
    //           Visibility(
    //             visible: time.isNotEmpty,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 const SizedBox(height: 16),
    //                 AppText(S.current.maintenanceTime),
    //                 const SizedBox(height: 8),
    //                 Container(
    //                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: context.colors.outlineVariant)),
    //                   padding: const EdgeInsets.all(12),
    //                   child: AppText(time),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
