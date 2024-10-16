import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final _selectedIndex = useState(0);

    useEffect(() {
      Future.microtask(() {
        ref.read(provider.notifier).init();
      });
      return () {};
    }, []);

    return AutoTabsScaffold(
      routes: ref.nav.listRoutes,
      bottomNavigationBuilder: (_, tabsRouter) {
        ref.nav.tabsRouter = tabsRouter;
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
                    text: L.current.home,
                    leading: _selectedIndex.value == 0 // || badge == 0
                        ? null
                        : b.Badge(
                            badgeStyle: const b.BadgeStyle(badgeColor: Colors.red),
                            position: b.BadgePosition.topEnd(top: -8, end: -8),
                            badgeContent: const Text('8', style: TextStyle(color: Colors.white, fontSize: 10)),
                            child: Icon(Icons.home, color: Colors.grey[800]),
                          ),
                  ),
                  GButton(icon: Icons.chat, text: L.current.conversation),
                  const GButton(icon: Icons.design_services, text: 'UI'),
                  GButton(icon: Icons.settings, text: L.current.setting)
                ],
                selectedIndex: _selectedIndex.value,
                onTabChange: (index) {
                  _selectedIndex.value = index;
                  tabsRouter.setActiveIndex(index);
                },
              ),
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
//             // AppText(L.current.source, textStyle: context.labelSmall?.copyWith(color: AppColorL.current.primaryTextColor)),
//           ],
//         ),
//       ),
//     );
//   }
// }
