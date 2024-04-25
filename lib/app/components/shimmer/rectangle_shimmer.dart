import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RectangleShimmer extends ConsumerWidget {
  const RectangleShimmer({this.width, this.height, this.borderRadius, super.key});

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final _isDarkMode = ref.watch(appProvider.select((x) => x.value?.isDarkMode));
    final _isDarkMode = AdaptiveTheme.of(context).mode.isDark;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: _isDarkMode == true ? Colors.black26 : Colors.white, borderRadius: borderRadius),
    );
  }
}
