import '../index.dart';

class ServerConstants {
  const ServerConstants._();
  static const connectTimeout = Duration(seconds: 30); // 30000;
  static const receiveTimeout = Duration(seconds: 30); // 30000;
  static const sendTimeout = Duration(seconds: 30); // 30000;

  /// response
  static const defaultErrorResponseMapperType = ErrorResponseMapperType.jsonObject;
  static const defaultSuccessResponseMapperType = SuccessResponseMapperType.jsonObject;

  /// retry error
  static int maxRetry = 3;
  static Duration retryInterval = const Duration(seconds: 3);

  /// field
  static const nickname = 'nickname';
  static const email = 'email';
  static const password = 'password';
  static const passwordConfirmation = 'password_confirmation';

  /// error code
  static const invalidRefreshToken = 1300;
  static const invalidResetPasswordToken = 1302;
  static const multipleDeviceLogin = 1602;
  static const accountHasDeleted = 1603;
  static const pageNotFound = 1051;

  /// error id
  static const badUserInput = 'BAD_USER_INPUT';
  static const unAuthenticated = 'UNAUTHENTICATED';
  static const forbidden = 'FORBIDDEN';

  static const basicAuthorization = 'Authorization';
  static const jwtAuthorization = 'JWT-Authorization';
  static const userAgentKey = 'User-Agent';
  static const bearer = 'Bearer';
  static const appId = 'app-id';

  /// language code
  static const en = 'EN';
  static const ja = 'JA';

  /// gender
  static const male = 0;
  static const female = 1;
  static const other = 2;
  static const unknown = -1;
}
