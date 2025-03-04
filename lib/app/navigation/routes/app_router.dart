import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../data/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

part 'app_router.gr.dart';

final appRouterProvider = Provider<AppRouter>((ref) => getIt.get<AppRouter>());

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@LazySingleton()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
        reverseDurationInMilliseconds: 300,
        transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
              CurvedAnimation(parent: animation, curve: Curves.linearToEaseOut, reverseCurve: Curves.easeInToLinear),
            ),
            child: child,
          );
          // return SwipeablePageRoute(builder: (_) => child).buildTransitions(ctx, animation1, animation2, child);
          // return child;
        },
      );

  @override
  final List<AutoRoute> routes = [
    CupertinoRoute(
      page: MainRoute.page,
      path: '/',
      guards: [getIt.get<RouteGuard>()],
      children: [
        RedirectRoute(path: '', redirectTo: 'home'),
        homeTab,
        uiTab,
        settingTab,
      ],
    ),
    CupertinoRoute(page: LoginRoute.page, path: '/login'),
    CupertinoRoute(page: SignUpRoute.page, path: '/signUp'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}

@RoutePage(name: 'HomeTab')
class BottomTabHomePage extends AutoRouter {
  const BottomTabHomePage({super.key});
}

final homeTab = CupertinoRoute(
  page: HomeTab.page,
  children: [
    CupertinoRoute(page: HomeRoute.page, initial: true),
    // CustomRoute(path: 'SlideBottomToTop', page: SlideBottomToTopRoute.page, title: (ctx, _) => 'SelectChapter', transitionsBuilder: TransitionsBuilders.slideBottom, durationInMilliseconds: 300), // popup
  ],
);

@RoutePage(name: 'UITab')
class UITabPage extends AutoRouter {
  const UITabPage({super.key});
}

final uiTab = CupertinoRoute(
  page: UITab.page,
  children: [
    CupertinoRoute(page: UIRoute.page, initial: true),
  ],
);

@RoutePage(name: 'SettingTab')
class SettingTabPage extends AutoRouter {
  const SettingTabPage({super.key});
}

final settingTab = CupertinoRoute(
  page: SettingTab.page,
  children: [
    CupertinoRoute(page: SettingRoute.page, initial: true),
    CupertinoRoute(page: SettingThemeRoute.page),
    CupertinoRoute(page: SettingLanguageRoute.page),
  ],
);
