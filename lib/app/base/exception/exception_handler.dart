import '../../../shared/index.dart';
import '../../index.dart';

class ExceptionHandler {
  const ExceptionHandler({required this.navigator, this.listener});

  final AppNavigator navigator;
  final ExceptionHandlerListener? listener;

  Future<void> handleException(AppExceptionWrapper appExceptionWrapper, String commonExceptionMessage) async {
    final message = appExceptionWrapper.overrideMessage ?? commonExceptionMessage;

    switch (appExceptionWrapper.appException.appExceptionType) {
      case AppExceptionType.remote:
        final exception = appExceptionWrapper.appException as RemoteException;
        switch (exception.kind) {
          case RemoteExceptionKind.refreshTokenFailed:
            await _showErrorDialog(
              isRefreshTokenFailed: true,
              message: message,
              onPressed: Func0(() {
                navigator.pop();
              }),
            );
            break;
          case RemoteExceptionKind.noInternet:
          case RemoteExceptionKind.timeout:
            await _showErrorDialogWithRetry(
              message: message,
              onPressedRetry: Func0(() async {
                await navigator.pop();
                await appExceptionWrapper.doOnRetry?.call();
              }),
            );
            break;
          default:
            // await _showErrorDialog(message: message);
            _showErrorMessage(message: message);
            break;
        }
        break;
      case AppExceptionType.parse:
      case AppExceptionType.remoteConfig:
      case AppExceptionType.message:
      case AppExceptionType.validation:
        return _showErrorMessage(message: message);
      case AppExceptionType.uncaught:
        return null;
    }
  }

  void _showErrorMessage({required String message, Duration duration = DurationConstants.defaultErrorVisibleDuration}) {
    navigator.showErrorMessage(message, duration: duration);
  }

  Future<void> _showErrorDialog({required String message, void Function()? onPressed, bool isRefreshTokenFailed = false}) async {
    await navigator.showDialog(AppPopupInfo.infoDialog(message: message, onPressed: onPressed)).then((value) {
      if (isRefreshTokenFailed) {
        listener?.onRefreshTokenFailed();
      }
    });
  }

  Future<void> _showErrorDialogWithRetry({required String message, required void Function()? onPressedRetry}) async {
    await navigator.showDialog(AppPopupInfo.errorWithRetryDialog(message: message, onPressedRetry: onPressedRetry));
  }
}

abstract class ExceptionHandlerListener {
  void onRefreshTokenFailed();
}
