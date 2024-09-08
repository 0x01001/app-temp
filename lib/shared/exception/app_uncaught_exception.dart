import '../../resources/index.dart';
import '../index.dart';

class AppUncaughtException extends AppException {
  AppUncaughtException({
    super.rootException,
    super.onRetry,
  }) : super();

  @override
  String toString() {
    return 'AppUncaughtException(${super.toString()})';
  }

  @override
  String get message => S.current.unknownException;

  @override
  AppExceptionAction get action => AppExceptionAction.doNothing;
}
