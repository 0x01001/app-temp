import '../index.dart';

class AppFirebaseAuthException extends AppException {
  AppFirebaseAuthException({
    required this.kind,
    super.rootException,
    super.onRetry,
  }) : super();

  final AppFirebaseAuthExceptionKind kind;

  @override
  String toString() {
    return 'AppFirebaseAuthExceptionKind(kind: $kind, ${super.toString()})';
  }

  @override
  String get message => switch (kind) {
        AppFirebaseAuthExceptionKind.invalidEmail => L.current.invalidEmail,
        AppFirebaseAuthExceptionKind.userDoesNotExist => L.current.userDoesNotExist,
        AppFirebaseAuthExceptionKind.invalidLoginCredentials => L.current.invalidLoginCredentials,
        AppFirebaseAuthExceptionKind.usernameAlreadyInUse => L.current.usernameAlreadyInUse,
        AppFirebaseAuthExceptionKind.requiresRecentLogin => L.current.requiresRecentLogin,
        AppFirebaseAuthExceptionKind.unknown => L.current.unknownException,
      };

  @override
  AppExceptionAction get action => AppExceptionAction.showMessage;
}

enum AppFirebaseAuthExceptionKind {
  invalidEmail,
  invalidLoginCredentials,
  userDoesNotExist,
  usernameAlreadyInUse,
  requiresRecentLogin,
  unknown,
}
