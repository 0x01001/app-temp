import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class MainPage extends BasePage<MainState, AutoDisposeStateNotifierProvider<MainProvider, AppState<MainState>>> {
  const MainPage({super.key});

  @override
  AutoDisposeStateNotifierProvider<MainProvider, AppState<MainState>> get provider => mainProvider;

  @override
  Widget render(BuildContext context, WidgetRef ref) {
    final _showBottomNav = ref.watch(showBottomNavProvider);

    useEffect(() {
      Future.microtask(() {
        ref.read(provider.notifier).init();
      });
      return () {};
    }, []);

    return AutoTabsScaffold(
      routes: ref.nav.routes,
      bottomNavigationBuilder: (_, tabsRouter) {
        ref.nav.tabsRouter = tabsRouter;
        final double height = _showBottomNav ? kBottomNavigationBarHeight + AppSize.deviceNavigationHeight : AppSize.deviceNavigationHeight + 3;

        return Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  // final _showSystemNavigation = ref.watch(showSystemNavigationProvider); // in reading chapter
                  // if (!_showSystemNavigation) return SizedBox.fromSize();
                  Log.d('MainPage > build: $_showBottomNav - ${AppSize.deviceNavigationHeight} - $kBottomNavigationBarHeight - ${AppSize.bottomSafeAreaPadding}');
                  return SizedBox(
                    height: height,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(color: appColor.background.withOpacity(0.8)),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: height,
              child: BottomNavigationBar(
                key: GlobalKey(),
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) async {
                  if (index == tabsRouter.activeIndex) {
                    ref.nav.popUntilRootOfCurrentBottomTab();
                  }
                  tabsRouter.setActiveIndex(index);
                  if (index == 0) {
                    FlutterStatusbarcolor.setStatusBarWhiteForeground(true); // White text
                  }
                },
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                items: BottomTab.values.map((tab) => BottomNavigationBarItem(label: tab.title, icon: tab.icon, activeIcon: tab.activeIcon(context.colors.primary))).toList(),
                selectedLabelStyle: context.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                unselectedLabelStyle: context.labelSmall,
                backgroundColor: Colors.transparent,
                selectedItemColor: context.colors.primary,
                unselectedItemColor: appColor.grey5,
                elevation: 0.0,
              ).animate(target: _showBottomNav ? 1.0 : 0.0).fade(begin: 0.0, end: 1.0, curve: Curves.easeInOutCubic).slideY(begin: 1.0, end: 0.0),
            ),
          ],
        );
      },
      // floatingActionButton: _showFab && _showBottomNav ? FAB(onPressed: onPress) : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

enum BottomTab {
  home,
  ui,
  setting;

  const BottomTab();
  // final Widget icon;
  // final Widget activeIcon;

  Widget get icon {
    switch (this) {
      case BottomTab.home:
        return Icon(Icons.home, color: appColor.grey5);
      // return AppImage(appImage.iconHome.path, color: appColor.grey5);
      case BottomTab.ui:
        return Icon(Icons.color_lens, color: appColor.grey5);
      case BottomTab.setting:
        return Icon(Icons.settings, color: appColor.grey5);
    }
  }

  Widget activeIcon(Color color) {
    switch (this) {
      case BottomTab.home:
        return Icon(Icons.home, color: color);
      case BottomTab.ui:
        return Icon(Icons.color_lens, color: color);
      case BottomTab.setting:
        return Icon(Icons.settings, color: color);
    }
  }

  String get title {
    switch (this) {
      case BottomTab.home:
        return S.current.home;
      case BottomTab.ui:
        return 'UI';
      case BottomTab.setting:
        return S.current.setting;
    }
  }
}
