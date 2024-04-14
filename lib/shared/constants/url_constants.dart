import '../index.dart';

class UrlConstants {
  const UrlConstants._();

  /// Url
  static const termUrl = 'https://www.chatwork.com/';
  static const lineApiBaseUrl = 'https://api.line.me/';
  static const twitterApiBaseUrl = 'https://api.twitter.com/';
  static const goongApiBaseUrl = 'https://rsapi.goong.io/';
  static const firebaseStorageBaseUrl = 'https://firebasestorage.googleapis.com/';
  static const randomUserBaseUrl = 'https://randomuser.me/api/'; //?page=1&results=1000

  static const mockApiBaseUrl = 'https://api.jsonbin.io/';

  /// Path
  static const remoteConfigPath = '/config/RemoteConfig.json';
  static const settingsPath = '/mypage/settings';

  static String get appApiBaseUrl {
    switch (EnvConstants.flavor) {
      case Flavor.dev:
        // return 'https://identitytoolkit.googleapis.com/v1/';   // api login, register
        return 'https://dummyapi.io/data/v1/';
      case Flavor.qa:
        return 'https://api.com/api/v2/';
      case Flavor.stg:
        return 'https://api.com/api/v2/';
      case Flavor.prod:
        return 'https://api.com/api/v2/';
    }
  }
}
