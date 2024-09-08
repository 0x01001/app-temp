import '../../../shared/index.dart';

abstract class ExceptionMapper<T extends AppException> {
  T map(Object? exception);
}
