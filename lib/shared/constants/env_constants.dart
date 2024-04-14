import '../index.dart';

class EnvConstants {
  const EnvConstants._();

  static late Flavor flavor = Flavor.values.byName(String.fromEnvironment('FLAVOR', defaultValue: Flavor.dev.name));
  // static late String appBasicAuthName = const String.fromEnvironment(appBasicAuthNameKey);
  // static late String appBasicAuthPassword = const String.fromEnvironment(appBasicAuthPasswordKey);
  static late String apiKey = const String.fromEnvironment('API_KEY'); // get your API_KEY https://firebase.google.com/docs/reference/rest/auth
  static late String secretkey = const String.fromEnvironment('SECRET_KEY');
  static late String secretIV = const String.fromEnvironment('SECRET_IV');
  static late String dummyAppId = const String.fromEnvironment('DUMMY_APP_ID');

  static void init() {
    Log.d('FLAVOR: $flavor');
    Log.d('API_KEY: $apiKey');
    Log.d('SECRET_KEY: $secretkey');
    Log.d('SECRET_IV: $secretIV');
    Log.d('DUMMY_APP_ID: $dummyAppId');
  }
}
