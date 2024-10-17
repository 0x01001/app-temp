import 'package:flutter/material.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';
import '../../index.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.backgroundColor,
    this.hideKeyboardWhenTouchOutside = false,
    this.useSafeArea = true,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final bool hideKeyboardWhenTouchOutside;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      backgroundColor: backgroundColor ?? context.theme.extension<CustomTheme>()?.background,
      body: useSafeArea ? SafeArea(child: body) : body,
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      extendBodyBehindAppBar: true,
    );
    final scaffoldWithBanner = Env.flavor == Flavor.prod
        ? scaffold
        : Banner(
            location: BannerLocation.topEnd,
            message: Env.flavor.name.toUpperCase(),
            color: Env.flavor == Flavor.stg ? Colors.yellow.withOpacity(0.6) : Colors.red.withOpacity(0.6),
            textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 1),
            textDirection: TextDirection.ltr,
            child: scaffold,
          );
    return hideKeyboardWhenTouchOutside ? GestureDetector(onTap: () => AppUtils.hideKeyboard(context), child: scaffoldWithBanner) : scaffoldWithBanner;
  }
}
