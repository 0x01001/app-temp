import '../../resources/index.dart';
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
        AppFirebaseAuthExceptionKind.invalidEmail => S.current.invalidEmail,
        AppFirebaseAuthExceptionKind.userDoesNotExist => S.current.userDoesNotExist,
        AppFirebaseAuthExceptionKind.invalidLoginCredentials => S.current.invalidLoginCredentials,
        AppFirebaseAuthExceptionKind.usernameAlreadyInUse => S.current.usernameAlreadyInUse,
        AppFirebaseAuthExceptionKind.requiresRecentLogin => S.current.requiresRecentLogin,
        AppFirebaseAuthExceptionKind.unknown => S.current.unknownException,
      };

  @override
  AppExceptionAction get action => AppExceptionAction.doNothing;
}

enum AppFirebaseAuthExceptionKind {
  invalidEmail,
  invalidLoginCredentials,
  userDoesNotExist,
  usernameAlreadyInUse,
  requiresRecentLogin,
  unknown,
}
