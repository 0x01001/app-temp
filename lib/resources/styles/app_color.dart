import 'package:flutter/material.dart';

import '../index.dart';

AppColor get appColor => AppColor.current;
$AssetsImagesGen get appImage => Assets.images;

class AppColor {
  const AppColor({
    required this.white1,
    required this.black1,
    required this.white2,
    required this.black2,
    required this.black3,
    required this.red1,
    required this.red2,
    required this.red3,
    required this.grey1,
    required this.grey2,
    required this.grey3,
    required this.grey4,
    required this.grey5,
    required this.grey6,
    required this.grey7,
    required this.green1,
    required this.green2,
    required this.backgroundPopup,
    required this.disabled,
    required this.secondaryText,
    required this.linkText,
    required this.borderButton,
    required this.background,
    required this.error,
  });

  static late AppColor current;

  final Color white1;
  final Color white2;
  final Color black1;
  final Color black2;
  final Color black3;
  final Color red1;
  final Color red2;
  final Color red3;
  final Color grey1;
  final Color grey2;
  final Color grey3;
  final Color grey4;
  final Color grey5;
  final Color grey6;
  final Color grey7;
  final Color green1;
  final Color green2;
  final Color backgroundPopup;
  final Color disabled;
  final Color secondaryText;
  final Color linkText;
  final Color borderButton;
  final Color background;
  final Color error;

  static AppColor of(BuildContext context) {
    current = Theme.of(context).color;
    return current;
  }

  static final lightColor = AppColor(
    white1: Colors.white,
    black1: Colors.black,
    white2: Colors.white24,
    black2: Colors.black26,
    black3: Colors.black54,
    red1: const Color(0xFFEF4444).withOpacity(0.8),
    red2: const Color(0xFFF97316).withOpacity(0.8),
    red3: const Color(0xFFEAB308).withOpacity(0.8),
    grey1: Colors.grey.shade900,
    grey2: Colors.grey.shade800,
    grey3: Colors.grey.shade700,
    grey4: Colors.grey.shade600,
    grey5: Colors.grey.shade500,
    grey6: Colors.grey.shade400,
    grey7: Colors.grey.shade300,
    green1: Colors.green,
    green2: Colors.green.withOpacity(0.8),
    backgroundPopup: Colors.grey.shade300,
    disabled: const Color(0xFFD8D8D8),
    secondaryText: const Color(0xFF545454),
    linkText: const Color(0xFF042122),
    borderButton: const Color(0xFFE6EBFF),
    background: Colors.white,
    error: const Color(0xFFF75555),
  );

  static final darkColor = AppColor(
    white1: Colors.white,
    black1: Colors.black,
    white2: Colors.white24,
    black2: Colors.black26,
    black3: Colors.black54,
    red1: const Color(0xFFEF4444).withOpacity(0.8),
    red2: const Color(0xFFF97316).withOpacity(0.8),
    red3: const Color(0xFFEAB308).withOpacity(0.8),
    grey1: Colors.grey.shade100,
    grey2: Colors.grey.shade200,
    grey3: Colors.grey.shade300,
    grey4: Colors.grey.shade400,
    grey5: Colors.grey.shade500,
    grey6: Colors.grey.shade600,
    grey7: Colors.grey.shade700,
    green1: Colors.green,
    green2: Colors.green.withOpacity(0.8),
    backgroundPopup: Colors.black, // const Color.fromARGB(255, 34, 34, 34),
    disabled: const Color(0xFF35383F),
    secondaryText: const Color(0xFF545454),
    linkText: const Color(0xFF042122),
    borderButton: const Color(0xFFE6EBFF),
    background: const Color(0xFF181A20), // dark 1
    error: const Color(0xFFF75555),
  );
}
