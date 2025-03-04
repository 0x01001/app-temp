import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RectangleShimmer extends ConsumerWidget {
  const RectangleShimmer({this.width, this.height, this.borderRadius, super.key});

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(width: width, height: height, decoration: BoxDecoration(color: Colors.grey[50], borderRadius: borderRadius));
  }
}
