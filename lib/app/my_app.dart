import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/index.dart';
import '../resources/index.dart';
import '../shared/index.dart';
import 'index.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key, this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _appRouter = ref.watch(appRouterProvider);
    final _appPreferences = getIt.get<AppPreferences>();
    Log.d('MyApp > build -----------------------------');

    // useEffect(() {
    //   ref.listenManual(
    //     isDarkModeProvider,
    //     (previous, next) {
    //
    //     },
    //     fireImmediately: true,
    //   );

    //   return null;
    // }, const []);

    return ScreenUtilInit(
      designSize: const Size(Constant.designDeviceWidth, Constant.designDeviceHeight),
      builder: (context, _) => Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final languageCode = ref.watch(languageCodeProvider);
          AppSize.init(context);
          // Log.d('MyApp > ScreenUtilInit: ${ScreenUtil().scaleWidth} - ${ScreenUtil().scaleHeight} - ${ScreenUtil().screenWidth} - ${ScreenUtil().screenHeight} - $lightDynamic - $darkDynamic');

          return AdaptiveTheme(
            light: AppTheme.light,
            dark: AppTheme.dark,
            initial: savedThemeMode ?? AdaptiveThemeMode.system,
            builder: (theme, darkTheme) => MaterialApp.router(
              // routerConfig: _appRouter.config(
              //   navigatorObservers: () => [AppNavigatorObserver()],
              // ),
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                // return MediaQuery(
                //   data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                //   child: child != null ? FlutterEasyLoading(child: child) : const SizedBox.shrink(),
                // );
                final widget = MediaQuery.withNoTextScaling(child: child ?? const SizedBox.shrink());
                return Constant.enableDevicePreview ? DevicePreview.appBuilder(context, widget) : widget;
              },
              // routerDelegate: AutoRouterDelegate(_appRouter, navigatorObservers: () => [AppNavigatorObserver()]),
              routerDelegate: _appRouter.delegate(
                // initialRoutes: [const MainRoute()].toList(growable: false),
                deepLinkBuilder: (deepLink) {
                  final route = _appPreferences.isLoggedIn ? const MainRoute() : const LoginRoute();
                  return DeepLink([route]);
                },
                navigatorObservers: () => [AppNavigatorObserver()],
              ),
              routeInformationParser: _appRouter.defaultRouteParser(),
              title: Constant.materialAppTitle,
              // color: Constants.taskMenuMaterialAppColor,
              // themeMode: AdaptiveTheme.of(context).mode.isDark ? ThemeMode.dark : ThemeMode.light,
              theme: theme,
              darkTheme: darkTheme,
              localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) => supportedLocales.contains(locale) ? locale : const Locale(Constant.defaultLocale),
              locale: Constant.enableDevicePreview ? DevicePreview.locale(context) : Locale(languageCode.localeCode),
              supportedLocales: S.delegate.supportedLocales,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
          );
        },
      ),
    );
  }
}
