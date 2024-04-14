import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/index.dart';
import '../shared/index.dart';
import 'index.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key, this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _appRouter = getIt.get<AppRouter>();
    // final _isDarkMode = ref.watch(appProvider.select((x) => x.value?.isDarkMode));
    final _languageCode = ref.watch(appProvider.select((x) => x.value?.languageCode));
    Log.d('MyApp > build -----------------------------');

    return ScreenUtilInit(
        designSize: const Size(UiConstants.designDeviceWidth, UiConstants.designDeviceHeight),
        builder: (context, _) {
          // Log.d('MyApp > ScreenUtilInit: ${ScreenUtil().scaleWidth} - ${ScreenUtil().scaleHeight} - ${ScreenUtil().screenWidth} - ${ScreenUtil().screenHeight} - $lightDynamic - $darkDynamic');
          AppSize.init(context);
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
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child != null ? FlutterEasyLoading(child: child) : const SizedBox.shrink(),
                );
              },
              // routerDelegate: AutoRouterDelegate(_appRouter, navigatorObservers: () => [AppNavigatorObserver()]),
              routerDelegate: _appRouter.delegate(
                // initialRoutes: [const MainRoute()].toList(growable: false),
                deepLinkBuilder: (deepLink) => DeepLink.defaultPath,
                navigatorObservers: () => [AppNavigatorObserver()],
              ),
              routeInformationParser: _appRouter.defaultRouteParser(),
              title: UiConstants.materialAppTitle,
              // color: UiConstants.taskMenuMaterialAppColor,
              // themeMode: AdaptiveTheme.of(context).mode.isDark ? ThemeMode.dark : ThemeMode.light,
              theme: theme,
              darkTheme: darkTheme,
              localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) => supportedLocales.contains(locale) ? locale : const Locale(LocaleConstants.defaultLocale),
              locale: _languageCode.isNotNullOrEmpty ? Locale(_languageCode!) : const Locale(LocaleConstants.defaultLocale),
              supportedLocales: S.delegate.supportedLocales,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
          );
        });
  }
}
