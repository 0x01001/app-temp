import 'package:flutter/material.dart';

import '../index.dart';

// Hexadecimal color code for transparency: https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4
class AppTheme {
  const AppTheme._();

  /// define custom themes here
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      splashColor: Colors.transparent,
      fontFamily: style.fontFamily,
      colorScheme: ColorScheme.light(
        primary: AppColor.lightPrimary,
        surface: AppColor.lightSurface,
        secondary: AppColor.lightSecondary,
        error: AppColor.lightError,
      ),
      extensions: const [
        AppColorExt(
          backgroundTab: AppColor.lightBackgroundTab,
          scrim: AppColor.lightScrim,
          textDefault: AppColor.lightTextDefault,
          textWeak: AppColor.lightTextWeak,
          iconDefault: AppColor.lightIconDefault,
          iconHighlighted: AppColor.lightIconHighlighted,
          borderDefault: AppColor.lightBorderDefault,
          borderGradient: AppColor.lightBorderGradient,
          lightBorderGradient: AppColor.lightBorderGradient,
          darkBorderGradient: AppColor.darkBorderGradient,
          skeleton: AppColor.lightSkeleton,
          borderButton: AppColor.lightBorderButton,
          backgroundPopup: AppColor.lightBackgroundPopup,
          disabled: AppColor.lightDisabled,
          secondaryText: AppColor.lightSecondaryText,
          linkText: AppColor.lightLinkText,
          grey3: AppColor.lightGrey3,
          grey5: AppColor.lightGrey5,
          grey7: AppColor.lightGrey7,
          black3: AppColor.lightBlack3,
          red1: AppColor.lightRed1,
          red2: AppColor.lightRed2,
          red3: AppColor.lightRed3,
          green1: AppColor.lightGreen1,
        ),
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      splashColor: Colors.transparent,
      fontFamily: style.fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: AppColor.darkPrimary,
        surface: AppColor.darkSurface, // dark 2 //Color(0xFF35383F), // dark 3
        secondary: AppColor.darkSecondary,
        error: AppColor.darkError,
      ),
      extensions: const [
        AppColorExt(
          backgroundTab: AppColor.darkBackgroundTab,
          scrim: AppColor.darkScrim,
          textDefault: AppColor.darkTextDefault,
          textWeak: AppColor.darkTextWeak,
          iconDefault: AppColor.darkIconDefault,
          iconHighlighted: AppColor.darkIconHighlighted,
          borderDefault: AppColor.darkBorderDefault,
          borderGradient: AppColor.darkBorderGradient,
          lightBorderGradient: AppColor.lightBorderGradient,
          darkBorderGradient: AppColor.darkBorderGradient,
          skeleton: AppColor.darkSkeleton,
          borderButton: AppColor.darkBorderButton,
          backgroundPopup: AppColor.darkBackgroundPopup,
          disabled: AppColor.darkDisabled,
          secondaryText: AppColor.darkSecondaryText,
          linkText: AppColor.darkLinkText,
          grey3: AppColor.darkGrey3,
          grey5: AppColor.darkGrey5,
          grey7: AppColor.darkGrey7,
          black3: AppColor.darkBlack3,
          red1: AppColor.darkRed1,
          red2: AppColor.darkRed2,
          red3: AppColor.darkRed3,
          green1: AppColor.darkGreen1,
        ),
      ],
    );
  }
}

extension AppThemeExt on BuildContext {
  AppColorExt get color => Theme.of(this).extension<AppColorExt>()!;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  AppTextStyle get text => AppTextStyle(this);
  $AssetsImagesGen get image => Assets.images;
}
