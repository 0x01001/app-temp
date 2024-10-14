import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../index.dart';

class CircleShimmer extends ConsumerWidget {
  const CircleShimmer({this.diameter, super.key});

  final double? diameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isDarkMode = ref.watch(isDarkModeProvider);
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(color: _isDarkMode == true ? Colors.black26 : Colors.white, shape: BoxShape.circle),
    );
  }
}
