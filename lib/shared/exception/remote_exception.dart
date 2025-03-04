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
        RemoteExceptionKind.badCertificate => S.current.unknownException,
        RemoteExceptionKind.noInternet => S.current.noInternetException,
        RemoteExceptionKind.network => S.current.canNotConnectToHost,
        RemoteExceptionKind.serverDefined => generalServerMessage ?? S.current.unknownException,
        RemoteExceptionKind.userNotFound || RemoteExceptionKind.serverUndefined => generalServerMessage ?? S.current.unknownException,
        RemoteExceptionKind.timeout => S.current.timeoutException,
        RemoteExceptionKind.cancellation => S.current.unknownException,
        RemoteExceptionKind.unknown => S.current.unknownException,
        RemoteExceptionKind.refreshTokenFailed => S.current.tokenExpired,
        RemoteExceptionKind.decodeError => S.current.unknownException,
        RemoteExceptionKind.serverMaintenance => S.current.messageMaintenance,
      };

  @override
  AppExceptionAction get action {
    return switch (kind) {
      RemoteExceptionKind.serverMaintenance => AppExceptionAction.showDialogMaintenance,
      RemoteExceptionKind.refreshTokenFailed => AppExceptionAction.showDialogForceLogout,
      RemoteExceptionKind.serverDefined || RemoteExceptionKind.serverUndefined || RemoteExceptionKind.badCertificate || RemoteExceptionKind.decodeError || RemoteExceptionKind.cancellation || RemoteExceptionKind.unknown => AppExceptionAction.showDialog,
      RemoteExceptionKind.noInternet || RemoteExceptionKind.network || RemoteExceptionKind.timeout => AppExceptionAction.showDialogWithRetry,
      _ => AppExceptionAction.doNothing,
    };
  }

  @override
  bool get isForcedErrorToHandle => kind == RemoteExceptionKind.refreshTokenFailed || kind == RemoteExceptionKind.serverMaintenance;

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
  timeout,

  /// host not found, cannot connect to host, SocketException
  network,

  /// server has defined response
  serverDefined,

  /// specific serverDefined errors need to be handled in separate ways
  refreshTokenFailed,
  serverMaintenance,
  userNotFound,

  /// server has not defined response
  serverUndefined,

  /// Caused by an incorrect certificate as configured by [ValidateCertificate]
  badCertificate,

  /// error occurs when passing JSON
  decodeError,

  /// other errors
  cancellation,
  unknown,
}
