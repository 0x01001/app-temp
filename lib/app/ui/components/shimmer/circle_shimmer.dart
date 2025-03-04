import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CircleShimmer extends ConsumerWidget {
  const CircleShimmer({this.diameter, super.key});

  final double? diameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(width: diameter, height: diameter, decoration: BoxDecoration(color: Colors.grey[50], shape: BoxShape.circle));
  }
}
