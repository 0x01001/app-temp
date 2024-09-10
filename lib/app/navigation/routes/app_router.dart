import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

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
        uiTab,
        apiTab,
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
  path: 'home',
  page: HomeTab.page,
  maintainState: true,
  children: [
    AutoRoute(path: '', page: HomeRoute.page, title: (ctx, _) => 'Home'),
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

@RoutePage(name: 'UITab')
class BottomTabUIPage extends AutoRouter {
  const BottomTabUIPage({super.key});
}

final uiTab = AutoRoute(
  path: 'ui',
  page: UITab.page,
  children: [
    AutoRoute(path: '', page: UIRoute.page, title: (ctx, _) => 'UI'),
  ],
);

@RoutePage(name: 'APITab')
class BottomTabAPIPage extends AutoRouter {
  const BottomTabAPIPage({super.key});
}

final apiTab = AutoRoute(
  path: 'api',
  page: APITab.page,
  children: [
    AutoRoute(path: '', page: APIRoute.page, title: (ctx, _) => 'API'),
  ],
);

@RoutePage(name: 'SettingTab')
class BottomTabSettingPage extends AutoRouter {
  const BottomTabSettingPage({super.key});
}

final settingTab = AutoRoute(
  path: 'setting',
  page: SettingTab.page,
  children: [
    AutoRoute(path: '', page: SettingRoute.page, title: (ctx, _) => 'Setting'),
  ],
);
