import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/index.dart';
import '../../shared/index.dart';

final languageCodeProvider = StateProvider<LanguageCode>(
  (ref) {
    ref.listenSelf((previous, next) {
      ref.appPreferences.saveLanguageCode(next.value);
    });

    return LanguageCode.fromValue(ref.appPreferences.languageCode);
  },
);

// final isDarkModeProvider = StateProvider<bool>(
//   (ref) {
//     ref.listenSelf((previous, next) {
//       ref.appPreferences.saveIsDarkMode(next);
//     });

//     return ref.appPreferences.isDarkMode;
//   },
// );

class ShowBottomNav extends StateNotifier<bool> {
  ShowBottomNav() : super(true); // Initial state is true

  void change() => state = !state;
  void hide() => state = false;
  void show() => state = true;
}

final showBottomNavProvider = StateNotifierProvider<ShowBottomNav, bool>((ref) => ShowBottomNav());

final currentUserProvider = StateProvider<FirebaseUserModel>(
  (ref) {
    ref.listenSelf((previous, next) {
      // ref.appPreferences.saveUserId(next.id);
      // ref.appPreferences.saveEmail(next.email);
    });

    return FirebaseUserModel();
  },
);


// final appProvider = Provider((_ref) => App(_ref));

// class AppProvider {
//   AppProvider(this._ref);

//   final Ref _ref;

  // @override
  // Future<AppEntity> build() {
  //   final subscription = appRepository.subscriptionConnectivity(); //#1
  //   ref.onDispose(() async {
  //     subscription.cancel();
  //     Log.d('App > dispose!!!');
  //   });
  //   return init();
  // }

  // Future<AppEntity> init() async {
  //   // bool? isDarkMode = appRepository.isDarkMode;
  //   // if (isDarkMode == null) {
  //   //   final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
  //   //   isDarkMode = brightness == Brightness.dark;
  //   // }
  //   final model = AppEntity(languageCode: appRepository.languageCode);
  //   Log.d('AppProvider > build: ${model.toString()}');
  //   return model;
  // }

  // Future<dynamic> addOrUpdate(AppEntity data) async {
  //   await update((previous) async {
  //     if (previous.languageCode != data.languageCode) {
  //       await appRepository.saveLanguageCode(data.languageCode ?? Constants.defaultLocale);
  //     }
  //     // if (previous.isDarkMode != data.isDarkMode) {
  //     //   await appRepository.saveIsDarkMode(data.isDarkMode ?? UiConstants.defaultDarkMode);
  //     // }
  //     return data;
  //   });
  // }

  // Future<dynamic> setDarkMode(bool? val) async {
  //   if (!state.hasValue) return;
  //   await addOrUpdate(state.value!.copyWith(isDarkMode: val));
  // }

  // Future<dynamic> setLanguage(String val) async {
  //   if (!state.hasValue) return;
  //   // await S.load(Locale(val));
  //   await addOrUpdate(state.value!.copyWith(languageCode: val));
  // }
// }

/// uncomment if not use #1
// @riverpod
// Stream<bool> connect(ConnectRef ref) {
//   return getIt.get<AppRepository>().onConnectivityChanged;
// }

// @riverpod
// class ShowBottomNav extends _$ShowBottomNav {
//   @override
//   bool build() => true;
//   void change() => state = !state;
//   void hide() => state = false;
//   void show() => state = true;
// }
