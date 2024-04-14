import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final FlexSchemeColor _schemeLight = FlexSchemeColor.from(
  primary: const Color(0xFF202541),
  secondary: const Color(0xFF1b75d0), // const Color(0xff404e8c), //const Color(0xFF006B54),
  brightness: Brightness.light,
);

final FlexSchemeColor _schemeDark = FlexSchemeColor.from(
  primary: const Color(0xFF4E597D),
  secondary: const Color(0xFF90c4f9), // const Color(0xff404e8c),
  brightness: Brightness.dark,
);

const FlexScheme _scheme = FlexScheme.ebonyClay;
const bool _useScheme = false;
const double _appBarElevation = 5;
const double _appBarOpacity = 1;
const bool _computeDarkTheme = false;
const int _toDarkLevel = 30;
const bool _swapColors = false;
const int _usedColors = 6;

const FlexKeyColors _keyColors = FlexKeyColors(
  useKeyColors: false,
  useSecondary: true,
  useTertiary: true,
  keepPrimary: false,
  keepPrimaryContainer: false,
  keepSecondary: false,
  keepSecondaryContainer: false,
  keepTertiary: false,
  keepTertiaryContainer: false,
);

final FlexTones _flexTonesLight = FlexTones.material(Brightness.light);
final FlexTones _flexTonesDark = FlexTones.material(Brightness.dark);

final String? _fontFamily = GoogleFonts.notoSans().fontFamily;

const TextTheme _textTheme = TextTheme(
  displayMedium: TextStyle(fontSize: 41),
  displaySmall: TextStyle(fontSize: 36),
  labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.5),
);

const FlexSurfaceMode _surfaceMode = FlexSurfaceMode.highBackgroundLowScaffold;

const int _blendLevel = 20;

const bool _useSubThemes = true;

const FlexSubThemesData _subThemesData = FlexSubThemesData(
  interactionEffects: true,
  defaultRadius: null,
  bottomSheetRadius: 24,
  useTextTheme: true,
  inputDecoratorBorderType: FlexInputBorderType.outline,
  inputDecoratorIsFilled: true,
  inputDecoratorUnfocusedHasBorder: false,
  inputDecoratorSchemeColor: SchemeColor.primary,
  inputDecoratorBackgroundAlpha: 20,
  chipSchemeColor: SchemeColor.primary,
  elevatedButtonElevation: 1,
  thickBorderWidth: 1.5,
  thinBorderWidth: 1,
  bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
  bottomNavigationBarBackgroundSchemeColor: SchemeColor.background,
);

const bool _transparentStatusBar = true;

const FlexTabBarStyle _tabBarForAppBar = FlexTabBarStyle.forAppBar;

const bool _tooltipsMatchBackground = true;

final VisualDensity _visualDensity = FlexColorScheme.comfortablePlatformDensity;

final TargetPlatform _platform = defaultTargetPlatform;

class CustomTheme extends ThemeExtension<CustomTheme> {
  const CustomTheme({this.backgroundPopup});
  final Color? backgroundPopup;

  @override
  CustomTheme copyWith({Color? backgroundPopup}) => CustomTheme(backgroundPopup: backgroundPopup ?? this.backgroundPopup);

  @override
  CustomTheme lerp(ThemeExtension<CustomTheme>? other, double t) {
    if (other is! CustomTheme) {
      return this;
    }
    return CustomTheme(
      backgroundPopup: Color.lerp(backgroundPopup, other.backgroundPopup, t),
    );
  }
}

const CustomTheme lightTheme = CustomTheme(
  backgroundPopup: Colors.white,
);

const CustomTheme darkTheme = CustomTheme(
  backgroundPopup: Color.fromARGB(255, 34, 34, 34),
);

bool useMaterial3 = true;

class AppTheme {
  const AppTheme._();

  static final light = FlexThemeData.light(
    useMaterial3: useMaterial3,
    colors: _useScheme ? null : _schemeLight,
    scheme: _scheme,
    swapColors: _swapColors,
    usedColors: _usedColors,
    lightIsWhite: false,
    appBarStyle: null,
    appBarElevation: _appBarElevation,
    appBarOpacity: _appBarOpacity,
    transparentStatusBar: _transparentStatusBar,
    tabBarStyle: _tabBarForAppBar,
    surfaceMode: _surfaceMode,
    blendLevel: _blendLevel,
    tooltipsMatchBackground: _tooltipsMatchBackground,
    fontFamily: _fontFamily,
    // textTheme: _textTheme,
    // primaryTextTheme: _textTheme,
    keyColors: _keyColors,
    tones: _flexTonesLight,
    subThemesData: _useSubThemes ? _subThemesData : null,
    visualDensity: _visualDensity,
    platform: _platform,
    extensions: <ThemeExtension<dynamic>>{lightTheme},
  );

  static final dark = FlexThemeData.dark(
    useMaterial3: useMaterial3,
    colors: (_useScheme && _computeDarkTheme)
        ? FlexColor.schemes[_scheme]!.light.toDark(_toDarkLevel)
        : _useScheme
            ? null
            : _computeDarkTheme
                ? _schemeLight.toDark(_toDarkLevel, true)
                : _schemeDark,
    scheme: _scheme,
    swapColors: _swapColors,
    usedColors: _usedColors,
    darkIsTrueBlack: false,
    appBarStyle: null,
    appBarElevation: _appBarElevation,
    appBarOpacity: _appBarOpacity,
    transparentStatusBar: _transparentStatusBar,
    tabBarStyle: _tabBarForAppBar,
    surfaceMode: _surfaceMode,
    blendLevel: _blendLevel,
    tooltipsMatchBackground: _tooltipsMatchBackground,
    fontFamily: _fontFamily,
    // textTheme: _textTheme,
    // primaryTextTheme: _textTheme,
    keyColors: _keyColors,
    tones: _flexTonesDark,
    subThemesData: _useSubThemes ? _subThemesData : null,
    visualDensity: _visualDensity,
    platform: _platform,
    extensions: <ThemeExtension<dynamic>>{darkTheme},
  );
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// // import 'package:material_color_utilities/material_color_utilities.dart';

// import '../index.dart';

// class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
//   const NoAnimationPageTransitionsBuilder();

//   @override
//   Widget buildTransitions<T>(
//     PageRoute<T> route,
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     return child;
//   }
// }

// const sourceColor = Color(0xff110A5C);

// class ThemeProvider extends InheritedWidget {
//   const ThemeProvider({required this.lightDynamic, required this.darkDynamic, required super.child, super.key});

//   // final ValueNotifier<ThemeSettings> settings;
//   final ColorScheme? lightDynamic;
//   final ColorScheme? darkDynamic;

//   final pageTransitionsTheme = const PageTransitionsTheme(
//     builders: <TargetPlatform, PageTransitionsBuilder>{
//       TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
//       TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
//     },
//   );

//   // Color custom(CustomColor custom) {
//   //   if (custom.blend) {
//   //     return blend(custom.color);
//   //   } else {
//   //     return custom.color;
//   //   }
//   // }

//   // Color blend(Color targetColor) {
//   //   return Color(Blend.harmonize(targetColor.value, sourceColor.value));
//   // }

//   // Color source(Color? target) {
//   //   Color source = sourceColor;
//   //   if (target != null) {
//   //     source = blend(target);
//   //   }
//   //   return source;
//   // }

//   ColorScheme colors(Brightness brightness, Color? targetColor) {
//     final dynamicPrimary = brightness == Brightness.light ? lightDynamic!.primary : darkDynamic!.primary;
//     return ColorScheme.fromSeed(
//       seedColor: dynamicPrimary, // ?? source(targetColor),
//       brightness: brightness,
//     );
//   }

//   ShapeBorder get shapeMedium => RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       );

//   CardTheme cardTheme() {
//     return CardTheme(
//       elevation: 0,
//       shape: shapeMedium,
//       clipBehavior: Clip.antiAlias,
//     );
//   }

//   ListTileThemeData listTileTheme(ColorScheme colors) {
//     return ListTileThemeData(
//       shape: shapeMedium,
//       selectedColor: colors.secondary,
//     );
//   }

//   AppBarTheme appBarTheme(ColorScheme colors) {
//     return AppBarTheme(
//       elevation: 0.5,
//       // backgroundColor: colors.surface,
//       backgroundColor: AppColors.current.statusBarColor,
//       foregroundColor: colors.onSurface,
//     );
//   }

//   TabBarTheme tabBarTheme(ColorScheme colors) {
//     return TabBarTheme(
//       labelColor: colors.secondary,
//       unselectedLabelColor: colors.onSurfaceVariant,
//       indicator: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: colors.secondary,
//             width: 2,
//           ),
//         ),
//       ),
//     );
//   }

//   BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
//     return BottomAppBarTheme(
//       color: colors.surface,
//       elevation: 0,
//     );
//   }

//   BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
//     return BottomNavigationBarThemeData(
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: colors.surfaceVariant,
//       // selectedItemColor: colors.onSurface,
//       // unselectedItemColor: colors.onSurfaceVariant,
//       elevation: 1,
//       landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
//     );
//   }

//   NavigationRailThemeData navigationRailTheme(ColorScheme colors) {
//     return const NavigationRailThemeData();
//   }

//   DrawerThemeData drawerTheme(ColorScheme colors) {
//     return DrawerThemeData(
//       backgroundColor: colors.surface,
//     );
//   }

//   ThemeData light() {
//     final colorScheme = colors(Brightness.light, sourceColor);
//     final baseTheme = ThemeData(brightness: Brightness.light);
//     return ThemeData.light(useMaterial3: true).copyWith(
//       pageTransitionsTheme: pageTransitionsTheme,
//       colorScheme: colorScheme,
//       appBarTheme: appBarTheme(colorScheme),
//       cardTheme: cardTheme(),
//       listTileTheme: listTileTheme(colorScheme),
//       // bottomAppBarTheme: bottomAppBarTheme(colorScheme),
//       // bottomNavigationBarTheme: bottomNavigationBarTheme(colorScheme),
//       // navigationRailTheme: navigationRailTheme(colorScheme),
//       tabBarTheme: tabBarTheme(colorScheme),
//       drawerTheme: drawerTheme(colorScheme),
//       scaffoldBackgroundColor: colorScheme.background,
//       textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
//     )..addAppColor(
//         AppThemeType.light,
//         AppColors.defaultAppColor,
//       );
//   }

//   ThemeData dark() {
//     final colorScheme = colors(Brightness.dark, sourceColor);
//     final baseTheme = ThemeData(brightness: Brightness.dark);
//     return ThemeData.dark(useMaterial3: true).copyWith(
//       pageTransitionsTheme: pageTransitionsTheme,
//       colorScheme: colorScheme,
//       appBarTheme: appBarTheme(colorScheme),
//       cardTheme: cardTheme(),
//       listTileTheme: listTileTheme(colorScheme),
//       // bottomAppBarTheme: bottomAppBarTheme(colorScheme),
//       // bottomNavigationBarTheme: bottomNavigationBarTheme(colorScheme),
//       // navigationRailTheme: navigationRailTheme(colorScheme),
//       tabBarTheme: tabBarTheme(colorScheme),
//       drawerTheme: drawerTheme(colorScheme),
//       scaffoldBackgroundColor: colorScheme.background,
//       textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
//     )..addAppColor(
//         AppThemeType.dark,
//         AppColors.darkThemeColor,
//       );
//   }

//   ThemeData theme(BuildContext context, [Color? targetColor]) {
//     final brightness = MediaQuery.platformBrightnessOf(context); //https://www.aicodeday.com/flutter-3-10-update-mediaquery
//     return brightness == Brightness.light ? light() : dark();
//   }

//   static ThemeProvider of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     // return oldWidget.settings != settings;
//     return false;
//   }
// }

// // Color randomColor() {
// //   return Color(Random().nextInt(0xFFFFFFFF));
// // }

// // // Custom Colors
// // const linkColor = CustomColor(
// //   name: 'Link Color',
// //   color: Color(0xFF00B0FF),
// // );

// // class CustomColor {
// //   const CustomColor({
// //     required this.name,
// //     required this.color,
// //     this.blend = true,
// //   });

// //   final String name;
// //   final Color color;
// //   final bool blend;

// //   Color value(ThemeProvider provider) {
// //     return provider.custom(this);
// //   }
// // }

// /// define custom themes here
// // final lightTheme = ThemeData(
// //   brightness: Brightness.light,
// //   splashColor: Colors.transparent,
// // )..addAppColor(
// //     AppThemeType.light,
// //     AppColors.defaultAppColor,
// //   );

// // final darkTheme = ThemeData(
// //   brightness: Brightness.dark,
// //   splashColor: Colors.transparent,
// // )..addAppColor(
// //     AppThemeType.dark,
// //     AppColors.darkThemeColor,
// //   );

// enum AppThemeType { light, dark }

// extension ThemeDataExt on ThemeData {
//   static final Map<AppThemeType, AppColors> _appColorMap = {};

//   void addAppColor(AppThemeType type, AppColors appColor) {
//     _appColorMap[type] = appColor;
//   }

//   AppColors get appColor {
//     return _appColorMap[AppThemeSetting.currentAppThemeType] ?? AppColors.defaultAppColor;
//   }
// }

// class AppThemeSetting {
//   const AppThemeSetting._();
//   static late AppThemeType currentAppThemeType = AppThemeType.light;
// }
