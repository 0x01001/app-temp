import '../index.dart';

class EnvConstants {
  const EnvConstants._();

  static String flavorValue = const String.fromEnvironment('FLAVOR');
  static Flavor flavor = Flavor.values.byName(flavorValue.isNotEmpty ? flavorValue : Flavor.dev.name);
  // static String appBasicAuthName = const String.fromEnvironment(appBasicAuthNameKey);
  // static String appBasicAuthPassword = const String.fromEnvironment(appBasicAuthPasswordKey);
  static String apiKey = const String.fromEnvironment('API_KEY'); // get your API_KEY https://firebase.google.com/docs/reference/rest/auth
  static String secretkey = const String.fromEnvironment('SECRET_KEY');
  static String secretIV = const String.fromEnvironment('SECRET_IV');
  static String dummyAppId = const String.fromEnvironment('DUMMY_APP_ID');

  static void init() {
    Log.d('FLAVOR: $flavor');
    Log.d('API_KEY: $apiKey');
    Log.d('SECRET_KEY: $secretkey');
    Log.d('SECRET_IV: $secretIV');
    Log.d('DUMMY_APP_ID: $dummyAppId');
  }
}
