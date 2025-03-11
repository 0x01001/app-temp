import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../resources/index.dart';
import '../../../shared/index.dart';

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
    this.extendBody = false,
    this.extendBodyBehindAppBar = true,
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
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      backgroundColor: backgroundColor ?? context.colorScheme.surface,
      body: useSafeArea ? SafeArea(child: body) : body,
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
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
    return hideKeyboardWhenTouchOutside ? KeyboardDismissOnTap(dismissOnCapturedTaps: true, child: scaffoldWithBanner) : scaffoldWithBanner;
  }
}
