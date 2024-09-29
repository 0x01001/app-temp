import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/index.dart';
import '../index.dart';

abstract class BaseProvider<T extends BaseState> extends StateNotifier<AppState<T>> {
  BaseProvider(AppState<T> initialState) : super(initialState) {
    this.initialState = initialState;
  }

  late final AppState<T> initialState;

  @override
  set state(AppState<T> value) {
    if (mounted) {
      super.state = value;
    } else {
      Log.e('Cannot set state when widget is not mounted');
    }
  }

  @override
  AppState<T> get state {
    if (mounted) {
      return super.state;
    } else {
      Log.e('Cannot get state when widget is not mounted');
      return initialState;
    }
  }

  set data(T? data) {
    if (mounted) {
      state = state.copyWith(data: data);
    } else {
      Log.e('Cannot set data when widget is not mounted');
    }
  }

  T? get data => state.data;

  int _loadingCount = 0;

  set exception(AppException appException) {
    if (mounted) {
      state = state.copyWith(appException: appException);
    } else {
      Log.e('Cannot set exception when widget is not mounted');
    }
  }

  void showLoading() {
    if (_loadingCount <= 0) {
      state = state.copyWith(isLoading: true);
    }

    _loadingCount++;
  }

  void hideLoading() {
    if (_loadingCount <= 1) {
      state = state.copyWith(isLoading: false);
    }

    _loadingCount--;
  }

  Future<S?> runSafe<S>({
    required Future<S?> Function() action,
    Future<void> Function()? onRetry,
    Future<void> Function(AppException)? onError,
    Future<void> Function()? onSubscribe,
    Future<S> Function(S?)? onSuccess,
    Future<void> Function()? onCompleted,
    bool handleLoading = true,
    bool handleError = true,
    bool handleRetry = true,
    bool Function(AppException)? forceHandleError,
    String? overrideErrorMessage,
  }) async {
    try {
      await onSubscribe?.call();
      if (handleLoading) showLoading();

      final result = await action.call();

      if (handleLoading) hideLoading();
      await onSuccess?.call(result);
      return result;
    } on Object catch (e) {
      if (handleLoading) hideLoading();
      final appException = e is AppException ? e : AppUncaughtException(rootException: e);
      await onError?.call(appException);

      if (handleError || forceHandleError?.call(appException) != false) {
        appException.onRetry = () async {
          await onRetry?.call();
          await runSafe(
            action: action,
            onCompleted: onCompleted,
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
        };

        exception = appException;
      }
    } finally {
      if (handleLoading) hideLoading();
      await onCompleted?.call();
    }
    return null;
  }
}
