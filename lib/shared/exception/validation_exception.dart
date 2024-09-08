import '../../resources/index.dart';
import 'app_exception.dart';

class ValidationException extends AppException {
  ValidationException({required this.kind, super.rootException, super.onRetry}) : super();

  final ValidationExceptionKind kind;

  @override
  String toString() {
    return 'ValidationException(kind: $kind, ${super.toString()})';
  }

  @override
  AppExceptionAction get action => AppExceptionAction.doNothing;

  @override
  String get message => switch (kind) {
        ValidationExceptionKind.invalidEmail => S.current.invalidEmail,
        ValidationExceptionKind.invalidPassword => S.current.invalidPassword,
        ValidationExceptionKind.passwordsDoNotMatch => S.current.passwordsAreNotMatch,
      };
}

enum ValidationExceptionKind {
  invalidEmail,
  invalidPassword,
  passwordsDoNotMatch,
}
