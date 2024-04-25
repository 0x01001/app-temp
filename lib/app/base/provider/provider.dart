import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class App extends _$App with Base {
  @override
  Future<AppEntity> build() {
    final subscription = appRepository.subscriptionConnectivity(); //#1
    ref.onDispose(() async {
      subscription.cancel();
      Log.d('App > dispose!!!');
    });
    return init();
  }

  Future<AppEntity> init() async {
    // bool? isDarkMode = appRepository.isDarkMode;
    // if (isDarkMode == null) {
    //   final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    //   isDarkMode = brightness == Brightness.dark;
    // }
    final model = AppEntity(languageCode: appRepository.languageCode);
    Log.d('AppProvider > build: ${model.toString()}');
    return model;
  }

  Future<dynamic> addOrUpdate(AppEntity data) async {
    await update((previous) async {
      if (previous.languageCode != data.languageCode) {
        await appRepository.saveLanguageCode(data.languageCode ?? LocaleConstants.defaultLocale);
      }
      // if (previous.isDarkMode != data.isDarkMode) {
      //   await appRepository.saveIsDarkMode(data.isDarkMode ?? UiConstants.defaultDarkMode);
      // }
      return data;
    });
  }

  Future<dynamic> setDarkMode(bool? val) async {
    if (!state.hasValue) return;
    await addOrUpdate(state.value!.copyWith(isDarkMode: val));
  }

  Future<dynamic> setLanguage(String val) async {
    if (!state.hasValue) return;
    // await S.load(Locale(val));
    await addOrUpdate(state.value!.copyWith(languageCode: val));
  }
}

/// uncomment if not use #1
// @riverpod
// Stream<bool> connect(ConnectRef ref) {
//   return getIt.get<AppRepository>().onConnectivityChanged;
// }

@riverpod
class ShowBottomNav extends _$ShowBottomNav {
  @override
  bool build() => true;
  void change() => state = !state;
  void hide() => state = false;
  void show() => state = true;
}
