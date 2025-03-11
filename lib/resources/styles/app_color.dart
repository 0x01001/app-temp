import 'package:flutter/material.dart';

abstract class AppColor {
  static const lightPrimary = Color(0xFF06C149);
  static final lightSurface = Colors.grey.shade100;
  static const lightSecondary = Color(0xFFFFD300);
  static const lightError = Color(0xFFF75555);
  static const lightBackgroundTab = Color(0xFFFFFFFF);
  static const lightScrim = Color(0x4C000000);
  static const lightTextDefault = Color(0xFF222222);
  static const lightTextWeak = Color(0xFF999999);
  static const lightIconDefault = Color(0xFFB3B3B3);
  static const lightIconHighlighted = Color(0xFF222222);
  static const lightBorderDefault = Color(0xFFF7F7F7);
  static const lightBorderGradient = [Color(0xFF00B2FF), Color(0xFF91E0FF), Color(0xFF00B2FF)];
  static const lightSkeleton = Color(0xFFF5F5F5);
  static const lightBackgroundPopup = Color(0xFF2C282C);
  static const lightDisabled = Color(0xFFD8D8D8);
  static const lightSecondaryText = Color(0xFFFFFFFF);
  static const lightLinkText = Color(0xFF00B2FF);
  static const lightBorderButton = Color(0xFFE6EBFF);
  static const lightGrey3 = Color(0xFF616161); //Colors.grey.shade700
  static const lightGrey5 = Color.fromRGBO(158, 158, 158, 1); //Colors.grey.shade500
  static const lightGrey7 = Color(0xFFE0E0E0); //Colors.grey.shade300
  static const lightBlack3 = Color(0x8A000000); //Colors.black54
  static const lightRed1 = Color(0xCCEF4444);
  static const lightRed2 = Color(0xCCF97316);
  static const lightRed3 = Color(0xCCEAB308);
  static const lightGreen1 = Color(0xCC4CAF50); //Colors.green.withOpacity(0.8),

  // dark
  static const darkPrimary = Color(0xFF06C149);
  static const darkSurface = Color(0xFF1F222A);
  static const darkSecondary = Color(0xFFFFD300);
  static const darkError = Color(0xFFF75555);
  static const darkBackgroundTab = Color(0xFF000000);
  static const darkScrim = Color(0xCC000000);
  static const darkTextDefault = Color(0xFFFFFFFF);
  static const darkTextWeak = Color(0xFF666666);
  static const darkIconDefault = Color(0xFF666666);
  static const darkIconHighlighted = Color(0xFFFFFFFF);
  static const darkBorderDefault = Color(0xFF323232);
  static const darkBorderGradient = [Color(0xFF797579), Color(0xFFFFFCFF), Color(0xFF797579)];
  static const darkSkeleton = Color(0xFF292929);
  static const darkBackgroundPopup = Color(0xFF2C282C);
  static const darkDisabled = Color(0xFF35383F);
  static const darkSecondaryText = Color(0xFFFFFFFF);
  static const darkLinkText = Color(0xFF00B2FF);
  static const darkBorderButton = Color(0xFFE6EBFF);
  static const darkGrey3 = Color(0xFFE0E0E0); //Colors.grey.shade300
  static const darkGrey5 = Color.fromRGBO(158, 158, 158, 1); //Colors.grey.shade500
  static const darkGrey7 = Color(0xFF616161); //Colors.grey.shade700
  static const darkBlack3 = Color(0x8A000000); //Colors.black54
  static const darkRed1 = Color(0xCCEF4444);
  static const darkRed2 = Color(0xCCF97316);
  static const darkRed3 = Color(0xCCEAB308);
  static const darkGreen1 = Color(0xCC4CAF50); //Colors.green.withOpacity(0.8),
  // final test = Colors.grey.shade700;
}

class AppColorExt extends ThemeExtension<AppColorExt> {
  const AppColorExt({
    required this.scrim,
    required this.textDefault,
    required this.textWeak,
    required this.iconDefault,
    required this.iconHighlighted,
    required this.borderDefault,
    required this.borderGradient,
    required this.lightBorderGradient,
    required this.darkBorderGradient,
    required this.skeleton,
    required this.backgroundTab,
    required this.backgroundPopup,
    required this.disabled,
    required this.secondaryText,
    required this.linkText,
    required this.borderButton,
    required this.grey3,
    required this.grey5,
    required this.grey7,
    required this.black3,
    required this.red1,
    required this.red2,
    required this.red3,
    required this.green1,
  });

  final Color scrim;
  final Color textDefault;
  final Color textWeak;
  final Color iconDefault;
  final Color iconHighlighted;
  final Color borderDefault;
  final List<Color> borderGradient;
  final List<Color> lightBorderGradient;
  final List<Color> darkBorderGradient;
  final Color skeleton;
  final Color backgroundTab;
  final Color backgroundPopup;
  final Color disabled;
  final Color secondaryText;
  final Color linkText;
  final Color borderButton;
  final Color grey3;
  final Color grey5;
  final Color grey7;
  final Color black3;
  final Color red1;
  final Color red2;
  final Color red3;
  final Color green1;

  @override
  AppColorExt copyWith({
    Color? backgroundTab,
    Color? scrim,
    Color? textDefault,
    Color? textWeak,
    Color? iconDefault,
    Color? iconHighlighted,
    Color? borderDefault,
    List<Color>? borderGradient,
    List<Color>? lightBorderGradient,
    List<Color>? darkBorderGradient,
    Color? skeleton,
    Color? backgroundPopup,
    Color? disabled,
    Color? secondaryText,
    Color? linkText,
    Color? borderButton,
    Color? grey3,
    Color? grey5,
    Color? grey7,
    Color? black3,
    Color? red1,
    Color? red2,
    Color? red3,
    Color? green1,
  }) {
    return AppColorExt(
      backgroundTab: backgroundTab ?? this.backgroundTab,
      scrim: scrim ?? this.scrim,
      textDefault: textDefault ?? this.textDefault,
      textWeak: textWeak ?? this.textWeak,
      iconDefault: iconDefault ?? this.iconDefault,
      iconHighlighted: iconHighlighted ?? this.iconHighlighted,
      borderDefault: borderDefault ?? this.borderDefault,
      borderGradient: borderGradient ?? this.borderGradient,
      lightBorderGradient: lightBorderGradient ?? this.lightBorderGradient,
      darkBorderGradient: darkBorderGradient ?? this.darkBorderGradient,
      skeleton: skeleton ?? this.skeleton,
      backgroundPopup: backgroundPopup ?? this.backgroundPopup,
      disabled: disabled ?? this.disabled,
      secondaryText: secondaryText ?? this.secondaryText,
      linkText: linkText ?? this.linkText,
      borderButton: borderButton ?? this.borderButton,
      grey3: grey3 ?? this.grey3,
      grey5: grey5 ?? this.grey5,
      grey7: grey7 ?? this.grey7,
      black3: black3 ?? this.black3,
      red1: red1 ?? this.red1,
      red2: red2 ?? this.red2,
      red3: red3 ?? this.red3,
      green1: green1 ?? this.green1,
    );
  }

  @override
  AppColorExt lerp(AppColorExt? other, double t) {
    if (other is! AppColorExt) {
      return this;
    }

    return AppColorExt(
      backgroundTab: Color.lerp(backgroundTab, other.backgroundTab, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      textDefault: Color.lerp(textDefault, other.textDefault, t)!,
      textWeak: Color.lerp(textWeak, other.textWeak, t)!,
      iconDefault: Color.lerp(iconDefault, other.iconDefault, t)!,
      iconHighlighted: Color.lerp(iconHighlighted, other.iconHighlighted, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderGradient: [for (final (i, color) in borderGradient.indexed) Color.lerp(color, other.borderGradient[i], t)!],
      lightBorderGradient: lightBorderGradient,
      darkBorderGradient: darkBorderGradient,
      skeleton: Color.lerp(skeleton, other.skeleton, t)!,
      backgroundPopup: Color.lerp(backgroundPopup, other.backgroundPopup, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      linkText: Color.lerp(linkText, other.linkText, t)!,
      borderButton: Color.lerp(borderButton, other.borderButton, t)!,
      grey3: Color.lerp(grey3, other.grey3, t)!,
      grey5: Color.lerp(grey5, other.grey5, t)!,
      grey7: Color.lerp(grey7, other.grey7, t)!,
      black3: Color.lerp(black3, other.black3, t)!,
      red1: Color.lerp(red1, other.red1, t)!,
      red2: Color.lerp(red2, other.red2, t)!,
      red3: Color.lerp(red3, other.red3, t)!,
      green1: Color.lerp(green1, other.green1, t)!,
    );
  }
}
