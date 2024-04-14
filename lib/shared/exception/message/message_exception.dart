import '../../index.dart';

class MessageException extends AppException {
  const MessageException(this.kind) : super(AppExceptionType.message);

  final MessageExceptionKind kind;

  @override
  String toString() {
    return 'MessageException: {kind: $kind}';
  }
}

enum MessageExceptionKind {
  userNotFound,
  wrongPassword,
  passwordTooWeak,
  accountAlreadyExists,
}
