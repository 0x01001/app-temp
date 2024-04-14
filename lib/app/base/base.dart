import 'dart:async';

import '../../domain/index.dart';
import '../../shared/index.dart';
import '../index.dart';

mixin class Base implements ExceptionHandlerListener {
  late final AppNavigator navigator = getIt.get<AppNavigator>();
  late final ExceptionHandler exceptionHandler = ExceptionHandler(navigator: navigator, listener: this);
  late final ExceptionMessageMapper exceptionMessageMapper = const ExceptionMessageMapper();
  // late final AppPreferences appPreferences = getIt.get<AppPreferences>();
  late final AppRepository appRepository = getIt.get<AppRepository>();
  late final UserRepository userRepository = getIt.get<UserRepository>();
  late final PostRepository postRepository = getIt.get<PostRepository>();

  Future<T?> runSafe<T>({
    required Future<T?> Function() action,
    Future<void> Function()? onRetry,
    Future<void> Function(AppException)? onError,
    Future<void> Function()? onSubscribe,
    Future<T> Function(T?)? onSuccess,
    Future<void> Function()? onEventCompleted,
    bool handleLoading = true,
    bool handleError = true,
    bool handleRetry = true,
    bool Function(AppException)? forceHandleError,
    String? overrideErrorMessage,
  }) async {
    Completer<void>? recursion;
    try {
      await onSubscribe?.call();
      if (handleLoading) AppUtils.showLoading();

      final result = await action.call();

      if (handleLoading) AppUtils.hideLoading();
      await onSuccess?.call(result);
      return result;
    } on AppException catch (e) {
      if (handleLoading) AppUtils.hideLoading();
      await onError?.call(e);

      if (handleError || (forceHandleError?.call(e) ?? _forceHandle(e))) {
        await handle(AppExceptionWrapper(
          appException: e,
          doOnRetry: onRetry ??
              (handleRetry
                  ? () async {
                      recursion = Completer();
                      await runSafe(
                        action: action,
                        onEventCompleted: onEventCompleted,
                        onSubscribe: onSubscribe,
                        onSuccess: onSuccess,
                        onError: onError,
                        onRetry: onRetry,
                        forceHandleError: forceHandleError,
                        handleError: handleError,
                        handleLoading: handleLoading,
                        handleRetry: handleRetry,
                        overrideErrorMessage: overrideErrorMessage,
                      );
                      recursion?.complete();
                    }
                  : null),
          exceptionCompleter: Completer<void>(),
          overrideMessage: overrideErrorMessage,
        ));
      }
    } finally {
      await recursion?.future;
      await onEventCompleted?.call();
    }
    return null;
  }

  Future<void> handle(AppExceptionWrapper appExceptionWrapper) async {
    await exceptionHandler.handleException(appExceptionWrapper, _handleMessage(appExceptionWrapper.appException)).then((value) {
      appExceptionWrapper.exceptionCompleter?.complete();
    });

    return appExceptionWrapper.exceptionCompleter?.future;
  }

  bool _forceHandle(AppException appException) {
    return appException is RemoteException && appException.kind == RemoteExceptionKind.refreshTokenFailed;
  }

  String _handleMessage(AppException appException) {
    final result = exceptionMessageMapper.map(appException);
    Log.d('Base > _handleExceptionMessage: $appException');
    return result;
  }

  @override
  void onRefreshTokenFailed() {
    // TODO:  force to logout
  }
}
