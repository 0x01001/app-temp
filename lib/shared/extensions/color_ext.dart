import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';

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

class RandomColors {
  Color get randomColor {
    return Color((math.Random().nextDouble() * 0xDDDDDD).toInt()).withOpacity(1.0);
  }

  Color get randomInCollectionColor {
    // generates a new Random object
    // generate a random index based on the list length
    // and use it to retrieve the element
    const list = ColorPalette.collectionColor;
    return list[Random().nextInt(list.length)];
  }
}

class ColorPalette {
  static const Color primaryColor = Color(0xFF00B74F);
  static const Color secondaryColor = Color(0xFF1D4289);
  static const Color loadingColor = Color(0xffD1FAE5);
  static const Color infoColor = Color(0xff3B82F6);
  static const Color selectedTabTitleTextColor = Color(0xff3B82F6);
  static const Color gold = Color(0xffFED7AA);

  static const Color text1Color = Color(0xFF374151);
  static const Color subTitleColor = Color(0xFF4B5563);
  static const Color hintTextColor = Color(0xFF9CA3AF);
  static const Color grayTextColor = Color(0xFFB0B7C3);
  static const Color lightTextColor = Color(0xFFFFFFFF);
  static const Color blueTextColor = Color(0xFF2563EB);
  static const Color httvTextColor = Color(0xFF103672);

  // static const Color backgroundGlobal = Color(0xFFF9FAFB);
  static const Color bg2Color = Color(0xFFE5E5E5);
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color bg6Color = Color(0xFF3B82F6);
  static const Color kBorderColor = Color(0xFFD1D5DB);
  static const Color grayIconColor = Color(0xFF787878);

  static const Color backgroundCommentColor = Color(0xFFF3F4F6);
  static const Color backgroundGlobal = Color(0xFFF5F5F5);
  static const Color backgroundTextField = Color(0xFF8F92A1);
  static const Color backgroundItemPost = Color(0xFFF9FAFB);
  static const Color backgroundInactive = Color(0xFFEEEEEE);
  static const Color backgroundItemGame = Color(0xFFEEEEEE);

  static const Color textSuccessColor = Color(0xFF10B981);
  static const Color textErrorColor = Color(0xFFE10600);
  static const Color warningColor = Color.fromARGB(255, 217, 132, 57);
  static const BoxShadow kBoxShadow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05),
    offset: Offset(1, 1),
    blurRadius: 5,
    spreadRadius: 2,
  );

  static const Color greenButtonColor = Color(0xff059669);
  static const Color shimmerBaseColor = Color(0xFFC1C7D0);
  static const Color shimmerHighlightColor = Color(0xFFC1C7D0);
  static const Color shimmerHighlightColor1 = Color(0xFFC8C8C8);
  static const Color shimmerHighlightColor2 = Color(0xFFF9FAFB);
  static const Color titleColor = Color(0xff111827);
  static const Color greenHeaderColor = Color(0xff0B6D36);
  static const Color raceButtonColor = Color(0xFF9FDC20);

  static const Color lacxiPrimaryColor = Color(0xffCD3300);
  static const Color lacxiTextColor = Color(0xff4C2800);

  static const List<Color> collectionColor = [
    Color(0xFFFBBF24),
    Color(0xFFF43F5E),
    Color(0xFF0EA5E9),
    Color(0xFF8B5CF6),
    Color(0xFFF97316),
    Color(0xFF10B981),
    Color(0xFF06B6D4),
    Color(0xFFEF4444),
    Color(0xFFEC4899),
    Color(0xFF1D4289),
  ];
  static const List<Color> recruitmentCollectionColor = [
    Color(0xFFFFEAEE),
    Color(0xFFFFF9E4),
    Color(0xFFE0F7FF),
    Color(0xFFE9FFF1),
    Color(0xFFFFE2CF),
    Color(0xFFDDE6FF),
  ];
}

class Gradients {
  static LinearGradient linearStatusBar = const LinearGradient(
    // begin: Alignment(0.25, 0.5),
    // end: Alignment(0.75, 0.5),
    // begin: Alignment.topLeft,
    // end: Alignment.bottomRight,
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
