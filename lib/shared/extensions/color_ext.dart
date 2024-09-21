import 'dart:math' as math;

import 'package:flutter/material.dart';

// Hexadecimal color code for transparency: https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4
extension HexColors on Color {
  static Color? fromHex(String hexString) {
    if (hexString.isEmpty) {
      return null;
    }
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class Gradients {
  static LinearGradient linearStatusBar = const LinearGradient(
    colors: <Color>[Color(0xff0060BD), Color(0xff5FA6E3)],
    tileMode: TileMode.clamp,
    transform: GradientRotation(-math.pi * 136.86 / 180),
  );

  static const Gradient defaultGradientBackground = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Color(0xFF00B74F),
      Color(0xFF1D4289),
    ],
  );

  static const Gradient verticalGradientBackground = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xff0E7490),
      Color(0xFF1D4289),
    ],
  );

  static const Gradient wheelGradientBackground = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xff50DBFF),
      Color(0xFF2069FF),
      Color(0xFFFF5183),
    ],
  );

  static const Gradient defaultCrossGradientBackground = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xFF00B74F),
      Color(0xFF1D4289),
    ],
  );
}

final Shader textShader = const LinearGradient(
  colors: [
    Color(0xFF00B74F),
    Color(0xFF1D4289),
  ],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

final Shader wdShader = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFC9508B),
    Color(0xFFEE757F),
  ],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
