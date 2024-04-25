import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CircleShimmer extends ConsumerWidget {
  const CircleShimmer({this.diameter, super.key});

  final double? diameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final _isDarkMode = ref.watch(appProvider.select((x) => x.value?.isDarkMode));
    final _isDarkMode = AdaptiveTheme.of(context).mode.isDark;
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(color: _isDarkMode == true ? Colors.black26 : Colors.white, shape: BoxShape.circle),
    );
  }
}
