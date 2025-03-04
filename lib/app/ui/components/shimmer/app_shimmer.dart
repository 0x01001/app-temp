import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../index.dart';

class AppShimmer extends ConsumerWidget {
  const AppShimmer({required this.child, this.baseColor, this.highlightColor, super.key});

  final Color? baseColor;
  final Color? highlightColor;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isDarkMode = ref.watch(isDarkModeProvider);

    if (_isDarkMode) {
      return Opacity(
        opacity: 0.8,
        child: Shimmer.fromColors(baseColor: baseColor ?? Colors.black12, highlightColor: highlightColor ?? Colors.white24, child: child),
      );
    }

    return Shimmer.fromColors(baseColor: baseColor ?? Colors.grey.shade400, highlightColor: highlightColor ?? Colors.grey.shade300, child: child);
  }
}
