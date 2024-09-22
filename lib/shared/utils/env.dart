import '../index.dart';

class Env {
  const Env._();

  static String flavorValue = const String.fromEnvironment('FLAVOR');
  static Flavor flavor = flavorValue.isNotEmpty ? Flavor.values.byName(flavorValue) : Flavor.dev;
  // static String appBasicAuthName = const String.fromEnvironment(appBasicAuthNameKey);
  // static String appBasicAuthPassword = const String.fromEnvironment(appBasicAuthPasswordKey);
  static String apiKey = const String.fromEnvironment('API_KEY'); // get your API_KEY https://firebase.google.com/docs/reference/rest/auth
  static String secretkey = const String.fromEnvironment('SECRET_KEY');
  static String secretIV = const String.fromEnvironment('SECRET_IV');
  static String dummyAppId = const String.fromEnvironment('DUMMY_APP_ID');
  static String appBasicAuthName = const String.fromEnvironment('APP_BASIC_AUTH_NAME');
  static String appBasicAuthPassword = const String.fromEnvironment('APP_BASIC_AUTH_PASSWORD');

  static void init() {
    Log.d('FLAVOR: $flavor');
    Log.d('API_KEY: $apiKey');
    Log.d('SECRET_KEY: $secretkey');
    Log.d('SECRET_IV: $secretIV');
    Log.d('DUMMY_APP_ID: $dummyAppId');
    Log.d('APP_BASIC_AUTH_NAME: $appBasicAuthName');
    Log.d('APP_BASIC_AUTH_PASSWORD: $appBasicAuthPassword');
  }
}
