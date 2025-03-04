import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../data/index.dart';
import '../resources/index.dart';
import '../shared/index.dart';
import 'index.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _appRouter = ref.watch(appRouterProvider);
    Log.d('MyApp > build -----------------------------');

    useEffect(() {
      ref.listenManual(
        isDarkModeProvider,
        (previous, next) => AppTheme.type = next ? AppThemeType.dark : AppThemeType.light,
        fireImmediately: true,
      );
      return null;
    }, []);

    return ScreenUtilInit(
      designSize: const Size(Constant.designDeviceWidth, Constant.designDeviceHeight),
      builder: (context, _) => Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final themeMode = ref.watch(themeModeProvider);
          final languageCode = ref.watch(languageCodeProvider);

          return DevicePreview(
            enabled: Constant.enableDevicePreview,
            builder: (_) => MaterialApp.router(
              routerDelegate: _appRouter.delegate(
                deepLinkBuilder: (deepLink) {
                  final _appPreferences = getIt.get<AppPreferences>();
                  final _appInfo = getIt.get<AppInfo>();
                  final route = _appPreferences.isLoggedIn || !_appInfo.isLoginRequired ? const MainRoute() : const LoginRoute();
                  return DeepLink([route]);
                },
                navigatorObservers: () => [AppNavigatorObserver(), HeroController()], //note: for Hero animation
              ),
              routeInformationParser: _appRouter.defaultRouteParser(),
              title: Constant.materialAppTitle,
              // color: Constants.taskMenuMaterialAppColor,
              themeMode: ThemeMode.values[themeMode],
              theme: lightTheme,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              // useInheritedMediaQuery: true,  // `useInheritedMediaQuery` property set to `true` in order to use DevicePreview
              localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) => supportedLocales.contains(locale) ? locale : const Locale(Constant.defaultLanguageCode),
              locale: Constant.enableDevicePreview ? DevicePreview.locale(context) : Locale(languageCode),
              supportedLocales: AppString.delegate.supportedLocales,
              localizationsDelegates: const [
                AppString.delegate,
                // LocaleNamesLocalizationsDelegate(),
                RefreshLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) {
                Log.d('MyApp > build languageCode: $languageCode - $themeMode');
                S.of(context);
                AppColor.of(context);
                AppSize.of(context);
                final widget = MediaQuery.withNoTextScaling(child: child ?? const SizedBox.shrink());
                return Constant.enableDevicePreview
                    ? DevicePreview.appBuilder(context, widget)
                    : AnnotatedRegion(
                        value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent),
                        child: widget,
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
