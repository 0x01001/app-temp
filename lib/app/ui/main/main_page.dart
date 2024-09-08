import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/extensions/num_ext.dart';
import '../../../shared/index.dart';
import '../../index.dart';

@RoutePage()
class MainPage extends BasePage<MainState, AutoDisposeStateNotifierProvider<MainProvider, AppState<MainState>>> {
  const MainPage({super.key});

  @override
  AutoDisposeStateNotifierProvider<MainProvider, AppState<MainState>> get provider => mainProvider;

  @override
  Widget render(BuildContext context, WidgetRef ref) {
    // ref.watch(appProvider.select((value) => value.value?.languageCode)); // for change language of bottom tab
    final _navigator = getIt.get<AppNavigator>();
    // final _bottomBarKey = GlobalKey();
    // final _showFab = MediaQuery.viewInsetsOf(context).bottom == 0.0; // MediaQuery.of(context).viewInsets.bottom == 0.0;
    final _showBottomNav = ref.watch(showBottomNavProvider);
    final _selectedIndex = useState(0);

    useEffect(
      () {
        Future.microtask(() {
          ref.read(provider.notifier).init();
        });
        return () {};
      },
      [],
    );

    return AutoTabsScaffold(
      routes: _navigator.tabRoutes,
      bottomNavigationBuilder: (_, tabsRouter) {
        _navigator.tabsRouter = tabsRouter;
        return SafeArea(
          child: AnimatedContainer(
            duration: 300.ms,
            height: _showBottomNav ? kBottomNavigationBarHeight : 0,
            child: Container(
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Theme.of(context).dividerColor, width: Constant.borderHeight))),
              child: GNav(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                gap: 8,
                color: Colors.grey[800], // color of gbutton
                activeColor: Theme.of(context).colorScheme.secondary,
                iconSize: 24,
                // tabBackgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                tabBorderRadius: 0,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: S.current.home,
                    leading: _selectedIndex.value == 0 // || badge == 0
                        ? null
                        : b.Badge(
                            badgeStyle: const b.BadgeStyle(badgeColor: Colors.red),
                            position: b.BadgePosition.topEnd(top: -8, end: -8),
                            badgeContent: const Text('8', style: TextStyle(color: Colors.white, fontSize: 10)),
                            child: Icon(Icons.home, color: Colors.grey[800]),
                          ),
                  ),
                  const GButton(icon: Icons.design_services, text: 'UI'),
                  const GButton(icon: Icons.api, text: 'API'),
                  GButton(icon: Icons.settings, text: S.current.setting)
                ],
                selectedIndex: _selectedIndex.value,
                onTabChange: (index) {
                  _selectedIndex.value = index;
                  tabsRouter.setActiveIndex(index);
                },
              ),
              // BottomNavigationBar(
              //   key: _bottomBarKey,
              //   currentIndex: tabsRouter.activeIndex,
              //   onTap: (index) {
              //     if (index == tabsRouter.activeIndex) {
              //       _navigator.popUntilRootOfCurrentBottomTab();
              //     }
              //     // check press on middle button tab
              //     if (index == 1) {
              //       onPress();
              //     } else {
              //       tabsRouter.setActiveIndex(index);
              //     }
              //   },
              //   showSelectedLabels: true,
              //   showUnselectedLabels: true,
              //   type: BottomNavigationBarType.fixed,
              //   items: BottomTab.values.map((tab) => BottomNavigationBarItem(label: tab.title, icon: tab.icon, activeIcon: tab.activeIcon)).toList(),
              //   selectedLabelStyle: context.labelSmall,
              //   unselectedLabelStyle: context.labelSmall,
              // ),
            ),
          ),
        );
      },
      // floatingActionButton: _showFab && _showBottomNav ? FAB(onPressed: onPress) : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// class FAB extends ConsumerWidget {
//   const FAB({this.onPressed, super.key});
//   final Function()? onPressed;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10.0),
//       child: SizedBox(
//         width: 66,
//         height: 66,
//         child: Column(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(33),
//               child: FloatingActionButton(
//                 backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
//                 onPressed: onPressed,
//                 elevation: 3,
//                 child: const Icon(Icons.token, size: 30),
//               ),
//             ),
//             // SizedBox(height: 6.sp),
//             // AppText(S.current.source, textStyle: context.labelSmall?.copyWith(color: AppColors.current.primaryTextColor)),
//           ],
//         ),
//       ),
//     );
//   }
// }
