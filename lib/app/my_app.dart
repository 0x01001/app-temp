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
  const MyApp({super.key});

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
          final isDarkTheme = ref.watch(isDarkModeProvider);
          final languageCode = ref.watch(languageCodeProvider);
          Log.d('MyApp > build languageCode: $languageCode - $isDarkTheme');
          AppSize.init(context);
          final themeMode = isDarkTheme == null
              ? ThemeMode.system
              : isDarkTheme
                  ? ThemeMode.dark
                  : ThemeMode.light;

          return DevicePreview(
            enabled: Constant.enableDevicePreview,
            builder: (_) => MaterialApp.router(
              builder: (context, child) {
                final widget = MediaQuery.withNoTextScaling(child: child ?? const SizedBox.shrink());
                return Constant.enableDevicePreview ? DevicePreview.appBuilder(context, widget) : widget;
              },
              routerDelegate: _appRouter.delegate(
                deepLinkBuilder: (deepLink) {
                  final route = _appPreferences.isLoggedIn ? const MainRoute() : const LoginRoute();
                  return DeepLink([route]);
                },
                navigatorObservers: () => [AppNavigatorObserver()],
              ),
              routeInformationParser: _appRouter.defaultRouteParser(),
              title: Constant.materialAppTitle,
              // color: Constants.taskMenuMaterialAppColor,
              themeMode: themeMode,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              debugShowCheckedModeBanner: false,
              // useInheritedMediaQuery: true,  // `useInheritedMediaQuery` property set to `true` in order to use DevicePreview
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
