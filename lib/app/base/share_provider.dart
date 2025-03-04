import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/index.dart';
import '../../shared/index.dart';

final shareProvider = Provider((_ref) => ShareProvider(_ref));

class ShareProvider {
  ShareProvider(this._ref);

  final Ref _ref;

  Future<String> get deviceToken async {
    final deviceToken = await _ref.firebaseNotification.deviceToken;
    if (deviceToken != null) {
      await _ref.preferences.saveDeviceToken(deviceToken);
    }

    return deviceToken ?? '';
  }

  // Future<void> forceLogout() async {
  //   try {
  //     await _ref.appPreferences.clearCurrentUserData();
  //     _ref.update<FirebaseUserData>(currentUserProvider, (state) => const FirebaseUserData());
  //     await _ref.nav.replaceAll([const LoginRoute()]);
  //   } catch (e) {
  //     await _ref.nav.replaceAll([const LoginRoute()]);
  //   }
  // }

  // Future<void> logout() async {
  //   try {
  //     final deviceToken = await this.deviceToken;
  //     final userId = _ref.appPreferences.userId;
  //     await _ref.firebaseFirestoreService.updateCurrentUser(userId: userId, data: {
  //       FirebaseUserData.keyDeviceIds: [],
  //       FirebaseUserData.keyDeviceTokens: FieldValue.arrayRemove([deviceToken]),
  //     });
  //     await _ref.appPreferences.clearCurrentUserData();
  //     await _ref.firebaseAuthService.signOut();
  //     _ref.update<FirebaseUserData>(currentUserProvider, (state) => const FirebaseUserData());
  //     await _ref.nav.replaceAll([const LoginRoute()]);
  //   } catch (e) {
  //     await _ref.nav.replaceAll([const LoginRoute()]);
  //   }
  // }
}

final showBottomNavProvider = StateProvider<bool>((ref) => true);
final showKeyboardProvider = StateProvider<bool>((ref) => false);

final languageCodeProvider = StateProvider<String>(
  (ref) {
    ref.listenSelf((previous, next) {
      Log.d('languageCodeProvider > listenSelf: $previous - $next');
      ref.preferences.saveLanguageCode(next);
    });

    return ref.preferences.languageCode;
  },
);

final themeModeProvider = StateProvider<int>(
  (ref) {
    ref.listenSelf((previous, next) {
      Log.d('themeModeProvider > listenSelf: $previous - $next');
      if (next != previous) {
        ref.preferences.saveThemeMode(next);
      }
    });
    final themeMode = ref.preferences.themeMode;
    Log.d('themeModeProvider: ${themeMode}');
    return themeMode;
  },
);

final isDarkModeProvider = StateProvider<bool>(
  (ref) {
    final themeMode = ref.watch(themeModeProvider);
    bool isDarkTheme = themeMode == 2;
    Log.d('isDarkModeProvider: ${themeMode}');
    if (themeMode == 0) {
      isDarkTheme = PlatformDispatcher.instance.platformBrightness == Brightness.dark; //MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
    Log.d('isDarkModeProvider > result: ${isDarkTheme} - ${PlatformDispatcher.instance.platformBrightness == Brightness.dark}');
    AppUtils.changeStatusBarColor(isDarkTheme);
    return isDarkTheme;
  },
);

final currentUserProvider = StateProvider<FirebaseUserModel>(
  (ref) {
    ref.listenSelf((previous, next) {
      ref.preferences.saveUserId(next.id ?? '');
      ref.preferences.saveEmail(next.email ?? '');
    });

    return FirebaseUserModel();
  },
);
