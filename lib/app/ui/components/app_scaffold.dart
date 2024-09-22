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
    // final safeArea = SafeArea(child: AppConnect(child: body));
    final scaffold = Scaffold(
      backgroundColor: backgroundColor ?? context.theme.extension<CustomTheme>()?.background,
      body: Shimmer(child: useSafeArea ? SafeArea(child: body) : body),
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      extendBodyBehindAppBar: true,
    );
    return hideKeyboardWhenTouchOutside ? GestureDetector(onTap: () => ViewUtils.hideKeyboard(context), child: scaffold) : scaffold;
  }
}
