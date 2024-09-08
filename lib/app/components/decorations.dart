import 'package:flutter/material.dart';

mixin MyBoxShadows {
  static final defaultBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      spreadRadius: 0,
      blurRadius: 5,
    )
  ];

  static final bottomShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      offset: const Offset(0, 2),
      blurRadius: 5,
      spreadRadius: 0,
    ),
  ];

  static final bottomShadowLarge = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      offset: const Offset(0, 4),
      blurRadius: 5,
      spreadRadius: 0,
    ),
  ];
}
