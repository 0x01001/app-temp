import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../index.dart';

class Constant {
  const Constant._();

  /// Url
  static const termUrl = 'https://www.chatwork.com/';
  static const lineApiBaseUrl = 'https://api.line.me/';
  static const twitterApiBaseUrl = 'https://api.twitter.com/';
  static const goongApiBaseUrl = 'https://rsapi.goong.io/';
  static const firebaseStorageBaseUrl = 'https://firebasestorage.googleapis.com/';
  static const randomUserBaseUrl = 'https://randomuser.me/api/'; //?page=1&results=1000

  static const mockApiBaseUrl = 'https://api.jsonbin.io/';

  // Deep links
  static const resetPasswordLink = 'domain://';

  /// Path
  static const remoteConfigPath = '/config/RemoteConfig.json';
  static const settingsPath = '/mypage/settings';

  static String get appApiBaseUrl {
    switch (Env.flavor) {
      case Flavor.dev:
        // return 'https://identitytoolkit.googleapis.com/v1/';   // api login, register
        return 'https://dummyapi.io/data/v1/';
      case Flavor.stg:
        return 'https://api.com/api/v2/';
      case Flavor.prod:
        return 'https://api.com/api/v2/';
    }
  }

  static const String emailResetPassword = 'email';
  static const String tokenResetPassword = 'token';

  /// shimmer
  static const shimmerItemCount = 20;

  /// loading
  static const loadingTimeout = 20000;

  /// material app
  static const materialAppTitle = 'My App';
  static const taskMenuMaterialAppColor = Color.fromARGB(255, 153, 154, 251);

  /// orientation
  static const mobileOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  static const tabletOrientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  /// status bar color
  static const systemUiOverlay = SystemUiOverlayStyle(statusBarBrightness: Brightness.light, statusBarColor: Colors.transparent);

  static const textFieldTextStyleHeight = 1.3;

  static const defaultDarkMode = false;
  static const defaultSizeButton = 45.0;
  static const defaultSizeTextInput = 45.0;
  static const defaultBorderRadiusButton = 5.0;
  static const defaultBorderRadiusTextInput = 5.0;

  // device
  static const designDeviceWidth = 375.0;
  static const designDeviceHeight = 667.0;

  static const maxMobileWidth = 450;
  static const maxTabletWidth = 900;

  static const maxMobileWidthForDeviceType = 550;

  // paging
  static const initialPage = 0;
  static const itemsPerPage = 10;
  static const invisibleItemsThreshold = 3;
  static const maxItemsPerRow = 3;
  static const paddingItemsGrid = 10.0;
  static const endReachedThreshold = 200.0;

  // downloading
  static const limitActivedDownload = 3;

  // UI
  static const borderHeight = 0.5;

  static const String yen = '￥';

  // static const accessToken = 'accessToken';
  // static const refreshToken = 'refreshToken';
  // static const currentUser = 'currentUser';
  // static const isDarkMode = 'isDarkMode';
  // static const deviceToken = 'deviceToken';
  // static const isFirstLogin = 'isFirstLogin';
  // static const isFirstLaunchApp = 'isFirstLaunchApp';
  // static const languageCode = 'languageCode';
  // static const resourceData = 'resourceData';
  // static const currentResourceId = 'currentResourceId';
  // static const downloadingData = 'downloadingData';

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
  static const en = 'en';
  static const ja = 'ja';
  static const defaultLocale = 'en';

  /// gender
  static const male = 0;
  static const female = 1;
  static const other = 2;
  static const unknown = -1;

  static const enableGeneralLog = kDebugMode;
  static const isPrettyJson = kDebugMode;

  /// bloc observer
  static const logOnBlocChange = false;
  static const logOnBlocCreate = false;
  static const logOnBlocClose = false;
  static const logOnBlocError = false;
  static const logOnBlocEvent = false;
  static const logOnBlocTransition = false;

  /// navigator observer
  static const enableNavigatorObserverLog = kDebugMode;

  /// disposeBag
  static const enableDisposeBagLog = false;

  /// stream event log
  static const logOnStreamListen = false;
  static const logOnStreamData = false;
  static const logOnStreamError = false;
  static const logOnStreamDone = false;
  static const logOnStreamCancel = false;

  /// log interceptor
  static const enableLogInterceptor = kDebugMode;
  static const enableLogRequestInfo = kDebugMode;
  static const enableLogSuccessResponse = kDebugMode;
  static const enableLogErrorResponse = kDebugMode;

  /// enable log usecase
  static const enableLogUseCaseInput = kDebugMode;
  static const enableLogUseCaseOutput = false;
  static const enableLogUseCaseError = kDebugMode;

  /// device preview
  static const enableDevicePreview = false;

  /// format
  static const uiDateDmy = 'dd/MM/yyyy';
  static const uiTimeHm = 'HH:mm';
  static const uiDateTime = 'dd/MM/yyyy HH:mm';

  static const appServerRequest = 'yyyy-MM-dd';

  static const String? appServerResponse = null; // null <=> Iso8601

  static const String numberFormat = '#,###';

  /// firebase
  static const myCollection = 'myCollection';
  static const maintainDocument = 'maintain';
  static const maintainingField = 'maintaining';
  // messaging
  static const firebaseKeyImage = 'image';
  // remote
  static const androidVersion = 'android_version';
  static const iOSVersion = 'ios_version';

  /// duration
  static const defaultListGridTransitionDuration = Duration(milliseconds: 500);
  static const defaultEventTransfomDuration = Duration(milliseconds: 500);
  static const defaultGeneralDialogTransitionDuration = Duration(milliseconds: 200);
  static const defaultSnackBarDuration = Duration(seconds: 5);
  static const defaultTopBarDuration = Duration(seconds: 3);
  static const defaultErrorVisibleDuration = Duration(seconds: 3);
  static const listGridTransitionDuration = Duration(milliseconds: 500);
  static const generalDialogTransitionDuration = Duration(milliseconds: 200);
  static const snackBarDuration = Duration(seconds: 3);

  /// database
  static const databaseName = 'DB';
  static const portName = 'downloader_send_port';
}
