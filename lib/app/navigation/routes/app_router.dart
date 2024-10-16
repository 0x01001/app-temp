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
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
        reverseDurationInMilliseconds: 300,
        transitionsBuilder: (ctx, animation1, animation2, child) {
          return child;
        },
      );

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: MainRoute.page,
      path: '/',
      guards: [getIt.get<RouteGuard>()],
      children: [
        RedirectRoute(path: '', redirectTo: 'home'),
        homeTab,
        conversationTab,
        uiTab,
        settingTab,
      ],
    ),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignUpRoute.page, path: '/signUp'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}

@RoutePage(name: 'HomeTab')
class BottomTabHomePage extends AutoRouter {
  const BottomTabHomePage({super.key});
}

final homeTab = AutoRoute(
  page: HomeTab.page,
  children: [
    AutoRoute(page: HomeRoute.page, initial: true),
    // AutoRoute(
    //   path: ':id',
    //   page: ItemDetailRoute.page,
    //   title: (ctx, data) {
    //     return 'Item Details ${data.pathParams.get('id')}';
    //   },
    // ),
    // CustomRoute(path: 'SlideBottomToTop', page: SlideBottomToTopRoute.page, title: (ctx, _) => 'SelectChapter', transitionsBuilder: TransitionsBuilders.slideBottom, durationInMilliseconds: 300), // popup
  ],
);

@RoutePage(name: 'ConversationTab')
class ConversationTabPage extends AutoRouter {
  const ConversationTabPage({super.key});
}

final conversationTab = AutoRoute(
  page: ConversationTab.page,
  children: [
    AutoRoute(page: ConversationRoute.page, initial: true),
    AutoRoute(page: ChatRoute.page),
    AutoRoute(page: UserRoute.page),
  ],
);

@RoutePage(name: 'UITab')
class UITabPage extends AutoRouter {
  const UITabPage({super.key});
}

final uiTab = AutoRoute(
  page: UITab.page,
  children: [
    AutoRoute(page: UIRoute.page, initial: true),
  ],
);

@RoutePage(name: 'SettingTab')
class SettingTabPage extends AutoRouter {
  const SettingTabPage({super.key});
}

final settingTab = AutoRoute(
  page: SettingTab.page,
  children: [
    AutoRoute(page: SettingRoute.page, initial: true),
    AutoRoute(page: SettingThemeRoute.page),
    AutoRoute(page: SettingLanguageRoute.page),
  ],
);
