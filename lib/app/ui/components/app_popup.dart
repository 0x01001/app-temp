import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../index.dart';

class AppPopup {
  const AppPopup._({required this.builder, required this.id});

  final String id;
  final Widget Function(BuildContext, AppNavigator) builder;

  @override
  String toString() => id;

  static AppPopup errorDialog(String message, {VoidCallback? onPressed}) {
    return AppPopup._(
      id: 'errorDialog_$message',
      builder: (context, navigator) => CommonDialog(
        message: message,
        actions: [
          PopupButton(
              text: L.current.ok,
              onPressed: () {
                navigator.pop(useRootNavigator: true);
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
            text: L.current.cancel,
            onPressed: onCancel ?? () => navigator.pop(useRootNavigator: true),
          ),
          PopupButton(
              text: L.current.ok,
              onPressed: () {
                navigator.pop(useRootNavigator: true);
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
            text: L.current.cancel,
            onPressed: () => navigator.pop(useRootNavigator: true),
          ),
          PopupButton(
              text: L.current.retry,
              onPressed: () {
                navigator.pop(useRootNavigator: true);
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
            text: L.current.cancel,
            onPressed: () => navigator.pop(useRootNavigator: true),
          ),
          PopupButton(
              text: L.current.retry,
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
              text: L.current.ok,
              onPressed: () {
                navigator.pop(useRootNavigator: true);
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
            onPressed: () => navigator.pop(),
            child: AppText(L.current.ok),
          ),
          CupertinoDialogAction(
            onPressed: () => navigator.pop(),
            child: AppText(L.current.cancel),
          ),
        ],
      ),
    );
  }

  static AppPopup successSnackBar(String message) {
    return AppPopup._(
      id: 'successSnackBar_$message',
      builder: (context, navigator) => SnackBar(
        content: AppText(message),
        duration: Constant.snackBarDuration,
        backgroundColor: Colors.green,
      ),
    );
  }

  static AppPopup errorSnackBar(String message) {
    return AppPopup._(
      id: 'errorSnackBar_$message',
      builder: (context, navigator) => SnackBar(
        content: AppText(message),
        duration: Constant.snackBarDuration,
        backgroundColor: Colors.red,
      ),
    );
  }
}
