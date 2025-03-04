import 'package:flutter/material.dart';

import '../index.dart';

enum AppThemeType { light, dark }

class AppTheme {
  const AppTheme._();
  static late AppThemeType type = AppThemeType.light;
}

/// define custom themes here
final lightTheme = ThemeData(
  brightness: Brightness.light,
  splashColor: Colors.transparent,
  fontFamily: style.fontFamily,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFF06C149),
    surface: Colors.grey[100]!,
    secondary: const Color(0xFFFFD300),
    error: const Color(0xFFF75555),
  ),
)..addColor(type: AppThemeType.light, color: AppColor.lightColor);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
  fontFamily: style.fontFamily,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF06C149),
    surface: Color(0xFF1F222A), // dark 2 //Color(0xFF35383F), // dark 3
    secondary: Color(0xFFFFD300),
    error: Color(0xFFF75555),
  ),
)..addColor(type: AppThemeType.dark, color: AppColor.darkColor);

extension ThemeDataExt on ThemeData {
  static final Map<AppThemeType, AppColor> _map = {};

  void addColor({required AppThemeType type, required AppColor color}) {
    _map[type] = color;
  }

  AppColor get color {
    return _map[AppTheme.type] ?? AppColor.lightColor;
  }
}

// class CustomTheme extends ThemeExtension<CustomTheme> {
//   const CustomTheme({this.backgroundPopup, this.disabled, this.secondaryText, this.linkText, this.borderButton, this.background});
//   final Color? backgroundPopup;
//   final Color? disabled;
//   final Color? secondaryText;
//   final Color? linkText;
//   final Color? borderButton;
//   final Color? background;

//   @override
//   CustomTheme copyWith({Color? backgroundPopup, Color? disabled, Color? secondaryText, Color? linkText, Color? borderButton, Color? background}) => CustomTheme(
//         backgroundPopup: backgroundPopup ?? this.backgroundPopup,
//         disabled: disabled ?? this.disabled,
//         secondaryText: secondaryText ?? this.secondaryText,
//         linkText: linkText ?? this.linkText,
//         borderButton: borderButton ?? this.borderButton,
//         background: background ?? this.background,
//       );

//   @override
//   CustomTheme lerp(ThemeExtension<CustomTheme>? other, double t) {
//     if (other is! CustomTheme) {
//       return this;
//     }
//     return CustomTheme(
//       backgroundPopup: Color.lerp(backgroundPopup, other.backgroundPopup, t),
//       disabled: Color.lerp(disabled, other.disabled, t),
//       secondaryText: Color.lerp(secondaryText, other.secondaryText, t),
//       linkText: Color.lerp(linkText, other.linkText, t),
//       borderButton: Color.lerp(borderButton, other.borderButton, t),
//       background: Color.lerp(background, other.background, t),
//     );
//   }
// }

// const CustomTheme lightTheme = CustomTheme(
//   backgroundPopup: Colors.white,
//   disabled: Color(0xFFB2B7C7),
//   secondaryText: Color(0xFF545454),
//   linkText: Color(0xFF042122),
//   borderButton: Color(0xFFE6EBFF),
//   background: Color(0xFFFCFDFC),
// );

// const CustomTheme darkTheme = CustomTheme(
//   backgroundPopup: Color.fromARGB(255, 34, 34, 34),
//   disabled: Color(0xFFB2B7C7),
//   secondaryText: Color(0xFF545454),
//   linkText: Color(0xFF042122),
//   borderButton: Color(0xFFE6EBFF),
//   background: Color(0xff181A20),
// );

// // Hexadecimal color code for transparency: https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4
// final FlexSchemeColor _schemeLight = FlexSchemeColor.from(
//   primary: const Color(0xFF06C149),
//   // secondary: const Color(0xFF09565A), // const Color(0xFF404e8c), //const Color(0xFF006B54),
//   brightness: Brightness.light,
// );

// final FlexSchemeColor _schemeDark = FlexSchemeColor.from(
//   primary: const Color(0xFF06C149),
//   // secondary: const Color(0xFF90c4f9), // const Color(0xFF404e8c),
//   brightness: Brightness.dark,
// );

// const FlexScheme _scheme = FlexScheme.ebonyClay;
// const bool _useScheme = false;
// const double _appBarElevation = 5;
// const double _appBarOpacity = 1;
// const bool _computeDarkTheme = false;
// const int _toDarkLevel = 30;
// const bool _swapColors = false;
// const int _usedColors = 6;

// const FlexKeyColors _keyColors = FlexKeyColors(
//   useKeyColors: false,
//   useSecondary: true,
//   useTertiary: true,
//   keepPrimary: false,
//   keepPrimaryContainer: false,
//   keepSecondary: false,
//   keepSecondaryContainer: false,
//   keepTertiary: false,
//   keepTertiaryContainer: false,
// );

// final FlexTones _flexTonesLight = FlexTones.material(Brightness.light);
// final FlexTones _flexTonesDark = FlexTones.material(Brightness.dark);

// final String? _fontFamily = GoogleFonts.notoSansJp().fontFamily;

// // const TextTheme _textTheme = TextTheme(
// //   displayMedium: TextStyle(fontSize: 41),
// //   displaySmall: TextStyle(fontSize: 36),
// //   labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.5),
// // );

// const FlexSurfaceMode _surfaceMode = FlexSurfaceMode.highBackgroundLowScaffold;

// const int _blendLevel = 20;

// const bool _useSubThemes = true;

// const FlexSubThemesData _subThemesData = FlexSubThemesData(
//   interactionEffects: true,
//   defaultRadius: null,
//   bottomSheetRadius: 24,
//   useTextTheme: true,
//   inputDecoratorBorderType: FlexInputBorderType.outline,
//   inputDecoratorIsFilled: true,
//   inputDecoratorUnfocusedHasBorder: false,
//   inputDecoratorSchemeColor: SchemeColor.primary,
//   inputDecoratorBackgroundAlpha: 20,
//   chipSchemeColor: SchemeColor.primary,
//   elevatedButtonElevation: 1,
//   thickBorderWidth: 1.5,
//   thinBorderWidth: 1,
//   bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
//   bottomNavigationBarBackgroundSchemeColor: SchemeColor.background,
// );

// const bool _transparentStatusBar = false;

// const FlexTabBarStyle _tabBarForAppBar = FlexTabBarStyle.forAppBar;

// const bool _tooltipsMatchBackground = true;

// final VisualDensity _visualDensity = FlexColorScheme.comfortablePlatformDensity;

// final TargetPlatform _platform = defaultTargetPlatform;

// bool useMaterial3 = true;

// class AppTheme {
//   const AppTheme._();

//   static final light = FlexThemeData.light(
//     useMaterial3: useMaterial3,
//     colors: _useScheme ? null : _schemeLight,
//     scheme: _scheme,
//     swapColors: _swapColors,
//     usedColors: _usedColors,
//     lightIsWhite: false,
//     // appBarStyle: null,
//     // appBarElevation: _appBarElevation,
//     // appBarOpacity: _appBarOpacity,
//     transparentStatusBar: _transparentStatusBar,
//     // tabBarStyle: _tabBarForAppBar,
//     surfaceMode: _surfaceMode,
//     blendLevel: _blendLevel,
//     tooltipsMatchBackground: _tooltipsMatchBackground,
//     fontFamily: _fontFamily,
//     // textTheme: _textTheme,
//     // primaryTextTheme: _textTheme,
//     keyColors: _keyColors,
//     // tones: _flexTonesLight,
//     subThemesData: _useSubThemes ? _subThemesData : null,
//     visualDensity: _visualDensity,
//     platform: _platform,
//     extensions: <ThemeExtension<dynamic>>{lightTheme},
//   );

//   static final dark = FlexThemeData.dark(
//     useMaterial3: useMaterial3,
//     colors: (_useScheme && _computeDarkTheme)
//         ? FlexColor.schemes[_scheme]!.light.toDark(_toDarkLevel)
//         : _useScheme
//             ? null
//             : _computeDarkTheme
//                 ? _schemeLight.toDark(_toDarkLevel, true)
//                 : _schemeDark,
//     scheme: _scheme,
//     swapColors: _swapColors,
//     usedColors: _usedColors,
//     darkIsTrueBlack: false,
//     // appBarStyle: null,
//     // appBarElevation: _appBarElevation,
//     // appBarOpacity: _appBarOpacity,
//     // transparentStatusBar: _transparentStatusBar,
//     // tabBarStyle: _tabBarForAppBar,
//     surfaceMode: _surfaceMode,
//     blendLevel: _blendLevel,
//     tooltipsMatchBackground: _tooltipsMatchBackground,
//     fontFamily: _fontFamily,
//     // textTheme: _textTheme,
//     // primaryTextTheme: _textTheme,
//     keyColors: _keyColors,
//     // tones: _flexTonesDark,
//     subThemesData: _useSubThemes ? _subThemesData : null,
//     visualDensity: _visualDensity,
//     platform: _platform,
//     extensions: <ThemeExtension<dynamic>>{darkTheme},
//   );
// }
