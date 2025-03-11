import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class FAB extends HookConsumerWidget {
  const FAB({required this.controller, this.isAuto = true, this.isShow = false, super.key});
  final ScrollController controller;
  final bool? isAuto;
  final bool? isShow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _showFAB = useState(false);
    final _showBottomNav = ref.watch(showBottomNavProvider);
    final double height = _showBottomNav ? kBottomNavigationBarHeight + AppSize.deviceNavigationHeight : AppSize.deviceNavigationHeight;
    //Log.d('FAB > _showFAB: ${_showFAB.value} - $isShow - ${AppSize.deviceNavigationHeight}');

    Future<void> _onScroll() async {
      if (!controller.hasClients || isAuto == false) return;
      // Log.d('_onScroll: ${controller.position.extentBefore} - ${AppSize.screenHeight * 0.4} - ${AppSize.topSafeAreaPadding}');
      final thresholdReached = controller.position.extentBefore > AppSize.screenHeight * 0.4 - AppSize.topSafeAreaPadding;
      if (thresholdReached) {
        _showFAB.value = true;
      } else {
        _showFAB.value = false;
      }
    }

    useEffect(() {
      if (isAuto == true) controller.addListener(_onScroll);
      return () {
        if (isAuto == true) controller.removeListener(_onScroll);
      };
    }, [controller]);

    Future<void> _onPressed() async {
      if (controller.hasClients == false || (isAuto == true && _showFAB.value == false) || (isAuto == false && isShow == false)) return;
      controller.animateTo(0, duration: 300.ms, curve: Curves.easeInOut);
    }

    return AnimatedOpacity(
      duration: 500.ms,
      opacity: isAuto == true ? (_showFAB.value ? 1 : 0) : (isShow == true ? 1 : 0),
      child: Padding(
        padding: EdgeInsets.only(bottom: height),
        child: SizedBox(
          width: 66,
          height: 66,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(33),
              child: FloatingActionButton(
                heroTag: null, //note: fixed There are multiple heroes that share the same tag within a subtree. In this case, multiple heroes had the following tag: <default FloatingActionButton tag>
                // backgroundColor: context.color.black3,
                onPressed: _onPressed,
                child: const Icon(Icons.arrow_upward, color: Colors.white, size: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
