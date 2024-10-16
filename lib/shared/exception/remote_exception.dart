import 'package:dartx/dartx.dart';

import '../../data/index.dart';
import '../index.dart';

class RemoteException extends AppException {
  RemoteException({required this.kind, this.httpErrorCode, this.serverError, super.rootException, super.onRetry}) : super();

  final RemoteExceptionKind kind;
  final int? httpErrorCode;
  final ServerError? serverError;

  @override
  String get message => switch (kind) {
        RemoteExceptionKind.badCertificate => L.current.unknownException,
        RemoteExceptionKind.noInternet => L.current.noInternetException,
        RemoteExceptionKind.network => L.current.canNotConnectToHost,
        RemoteExceptionKind.serverDefined => generalServerMessage ?? L.current.unknownException,
        RemoteExceptionKind.serverUndefined => generalServerMessage ?? L.current.unknownException,
        RemoteExceptionKind.timeout => L.current.timeoutException,
        RemoteExceptionKind.cancellation => L.current.unknownException,
        RemoteExceptionKind.unknown => L.current.unknownException,
        RemoteExceptionKind.refreshTokenFailed => L.current.tokenExpired,
        RemoteExceptionKind.decodeError => L.current.unknownException,
      };

  @override
  AppExceptionAction get action {
    return switch (kind) {
      RemoteExceptionKind.refreshTokenFailed => AppExceptionAction.showDialogForceLogout,
      RemoteExceptionKind.serverDefined || RemoteExceptionKind.serverUndefined => AppExceptionAction.showDialog,
      RemoteExceptionKind.noInternet || RemoteExceptionKind.network || RemoteExceptionKind.timeout => AppExceptionAction.showDialogWithRetry,
      _ => AppExceptionAction.doNothing,
    };
  }

  int get generalServerStatusCode => serverError?.generalServerStatusCode ?? serverError?.errors.firstOrNull?.serverStatusCode ?? -1;

  String? get generalServerErrorId => serverError?.generalServerErrorId ?? serverError?.errors.firstOrNull?.serverErrorId;

  String? get generalServerMessage => serverError?.generalMessage ?? serverError?.errors.firstOrNull?.message;

  @override
  String toString() {
    return '''RemoteException(
      kind: $kind,
      message: $message,
      action: $action,
      httpErrorCode: $httpErrorCode,
      serverError: $serverError,
      rootException: $rootException,
      generalServerMessage: $generalServerMessage,
      generalServerStatusCode: $generalServerStatusCode,
      generalServerErrorId: $generalServerErrorId,
      stackTrace: ${rootException is Error ? (rootException as Error).stackTrace : ''}
)''';
  }
}

enum RemoteExceptionKind {
  noInternet,

  /// host not found, cannot connect to host, SocketException
  network,

  /// server has defined response
  serverDefined,

  /// server has not defined response
  serverUndefined,

  /// Caused by an incorrect certificate as configured by [ValidateCertificate]
  badCertificate,

  /// error occurs when passing JSON
  decodeError,

  refreshTokenFailed,
  timeout,
  cancellation,
  unknown,
}
