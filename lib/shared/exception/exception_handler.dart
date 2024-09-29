import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/index.dart';
import '../index.dart';

final exceptionHandlerProvider = Provider<ExceptionHandler>((ref) => ExceptionHandler(ref));

class ExceptionHandler {
  const ExceptionHandler(this._ref);

  final Ref _ref;

  Future<void> handleException(AppException appException) async {
    if (appException.recordError) {
      await _ref.crashlytics.recordError(exception: appException, stack: StackTrace.current, reason: appException.message);
    }

    Log.e('[APP] handleException: $appException');

    switch (appException.action) {
      case AppExceptionAction.showMessage:
        _showErrorMessage(message: appException.message);
        break;
      case AppExceptionAction.showSnackBar:
        _showErrorSnackBar(appException.message);
        break;
      case AppExceptionAction.showDialog:
        await _showErrorDialog(message: appException.message);
        break;
      case AppExceptionAction.showDialogWithRetry:
        await _showErrorDialogWithRetry(
          message: appException.message,
          onRetryPressed: () async {
            await _ref.nav.pop();
            await appException.onRetry?.call();
          },
        );
        break;
      case AppExceptionAction.showDialogForceLogout:
        await _showErrorDialog(message: appException.message, forceLogout: true);
        break;
      case AppExceptionAction.doNothing:
        break;
    }
  }

  void _showErrorSnackBar(String message) {
    _ref.nav.showSnackBar(AppPopup.errorSnackBar(message));
  }

  Future<void> _showErrorDialog({required String message, bool forceLogout = false}) async {
    await _ref.nav.showDialog(AppPopup.errorDialog(message));
    if (forceLogout) {
      try {
        // await _ref.sharedViewModel.forceLogout();
      } catch (e) {
        Log.e('force logout error: $e');
        await _ref.nav.replaceAll([const LoginRoute()]);
      }
    }
  }

  Future<void> _showErrorDialogWithRetry({required String message, required VoidCallback? onRetryPressed}) async {
    // await _ref.nav.showDialog(
    //   AppPopup.errorWithRetryDialog(message: message, onRetryPressed: onRetryPressed),
    // );
  }

  void _showErrorMessage({required String message, Duration duration = Constant.defaultErrorVisibleDuration}) {
    _ref.nav.showErrorMessage(message, duration: duration);
  }

  // Future<void> _showErrorDialog({required String message, void Function()? onPressed, bool isRefreshTokenFailed = false}) async {
  //   await navigator.showDialog(AppPopupInfo.infoDialog(message: message, onPressed: onPressed)).then((value) {
  //     if (isRefreshTokenFailed) {
  //       listener?.onRefreshTokenFailed();
  //     }
  //   });
  // }

  // Future<void> _showErrorDialogWithRetry({required String message, required void Function()? onPressedRetry}) async {
  //   await navigator.showDialog(AppPopupInfo.errorWithRetryDialog(message: message, onPressedRetry: onPressedRetry));
  // }
}

// abstract class ExceptionHandlerListener {
//   void onRefreshTokenFailed();
// }
