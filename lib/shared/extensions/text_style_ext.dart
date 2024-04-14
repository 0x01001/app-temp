// import 'package:flutter/material.dart'; 

// extension TextStyleExtended on TextStyle {
//   // define text's font weight
//   TextStyle get light {
//     return copyWith(fontWeight: FontWeight.w300);
//   }

//   TextStyle get regular {
//     return copyWith(fontWeight: FontWeight.w400);
//   }

//   TextStyle get italic {
//     return copyWith(
//       fontWeight: FontWeight.normal,
//       fontStyle: FontStyle.italic,
//     );
//   }

//   TextStyle get medium {
//     return copyWith(fontWeight: FontWeight.w500);
//   }

//   TextStyle get semibold {
//     return copyWith(fontWeight: FontWeight.w600);
//   }

//   TextStyle get bold {
//     return copyWith(fontWeight: FontWeight.w700);
//   }

//   // define text's color
//   TextStyle get text1Color {
//     return copyWith(color: ColorPalette.text1Color);
//   }

//   TextStyle get text2Color {
//     return copyWith(color: const Color(0xFFABABAB));
//   }

//   TextStyle get lynkIDColor {
//     return copyWith(color: ColorPalette.lynkIDColor);
//   }

//   TextStyle get lynkIDThemeColor {
//     return copyWith(color: ColorPalette.lynkIDThemeColor);
//   }

//   TextStyle get blueTextColor {
//     return copyWith(color: ColorPalette.blueTextColor);
//   }

//   TextStyle get subTitleColor {
//     return copyWith(color: ColorPalette.subTitleColor);
//   }

//   TextStyle get hintTextColor {
//     return copyWith(color: ColorPalette.hintTextColor);
//   }

//   TextStyle get grayTextColor {
//     return copyWith(color: ColorPalette.grayTextColor);
//   }

//   TextStyle get textErrorColor {
//     return copyWith(color: ColorPalette.textErrorColor);
//   }

//   TextStyle get lightTextColor {
//     return copyWith(color: ColorPalette.lightTextColor);
//   }

//   TextStyle get primaryTextColor {
//     return copyWith(color: ColorPalette.primaryColor);
//   }

//   TextStyle get warningTextColor {
//     return copyWith(color: ColorPalette.warningColor);
//   }

//   TextStyle get whiteTextColor {
//     return copyWith(color: Colors.white);
//   }

//   TextStyle get httvTextColor {
//     return copyWith(color: ColorPalette.httvTextColor);
//   }

//   TextStyle get fontGilroy {
//     return copyWith(fontFamily: 'Gilroy');
//   }

//   TextStyle get fontRoboto {
//     return copyWith(fontFamily: 'Roboto');
//   }

//   TextStyle get fontSuiGeneris {
//     return copyWith(fontFamily: 'SuiGeneris');
//   }

//   TextStyle get fontGothamRounded {
//     return copyWith(fontFamily: 'GothamRounded');
//   }

//   // convenience functions
//   TextStyle setColor(Color color) {
//     return copyWith(color: color);
//   }

//   TextStyle setTextSize(double size) {
//     return copyWith(fontSize: size);
//   }
// }

// class TextStyles {
//   TextStyles(this.context);

//   BuildContext? context;

//   static TextStyles of(BuildContext context) {
//     return TextStyles(context);
//   }

//   static const TextStyle _defaultStyle = TextStyle(
//     fontSize: 14,
//     color: ColorPalette.text1Color,
//     fontWeight: FontWeight.w400,
//     height: 16 / 14,
//   );
// }

// extension TextStyleExt on TextStyles {
//   TextStyle get body1Text => Theme.of(context!).textTheme.bodyLarge ?? TextStyles._defaultStyle;
//   TextStyle get body2Text => Theme.of(context!).textTheme.bodyMedium ?? TextStyles._defaultStyle;

//   TextStyle get subtitle1 => Theme.of(context!).textTheme.titleMedium ?? TextStyles._defaultStyle;
//   TextStyle get subtitle2 => Theme.of(context!).textTheme.titleSmall ?? TextStyles._defaultStyle;

//   TextStyle get overline => Theme.of(context!).textTheme.labelSmall ?? TextStyles._defaultStyle;
//   TextStyle get button => Theme.of(context!).textTheme.labelLarge ?? TextStyles._defaultStyle;
//   TextStyle get caption => Theme.of(context!).textTheme.bodySmall ?? TextStyles._defaultStyle;

//   TextStyle get headline1 => Theme.of(context!).textTheme.displayLarge ?? TextStyles._defaultStyle;
//   TextStyle get headline2 => Theme.of(context!).textTheme.displayMedium ?? TextStyles._defaultStyle;
//   TextStyle get headline3 => Theme.of(context!).textTheme.displaySmall ?? TextStyles._defaultStyle;
//   TextStyle get headline4 => Theme.of(context!).textTheme.headlineMedium ?? TextStyles._defaultStyle;
//   TextStyle get headline5 => Theme.of(context!).textTheme.headlineSmall ?? TextStyles._defaultStyle;
//   TextStyle get headline6 => Theme.of(context!).textTheme.titleLarge ?? TextStyles._defaultStyle;
// }

// // How to use?
// // Text('test text', style: TextStyles.normalText.semibold.whiteColor);
// // Text('test text', style: TextStyles.itemText.whiteColor.bold);

// /*
//         bodyLarge: defaultTextStyle.copyWith(fontSize: 16.8, height: 24 / 16.8, color: ColorPalette.text1Color),
//         bodyMedium: defaultTextStyle.copyWith(fontSize: 14, height: 20 / 14, color: ColorPalette.text1Color),
//         titleMedium: defaultTextStyle.copyWith(fontSize: 11.7, height: 16 / 11.7, color: ColorPalette.subTitleColor),
//         titleSmall: defaultTextStyle.copyWith(fontSize: 9.7, height: 1, color: ColorPalette.hintTextColor),
//         bodySmall: defaultTextStyle.copyWith(fontSize: 16.8, height: 24 / 16.8, fontWeight: FontWeight.w600, color: ColorPalette.hintTextColor),
//         labelLarge: defaultTextStyle.copyWith(fontSize: 16.8, height: 24 / 16.8, fontWeight: FontWeight.w600, color: ColorPalette.text1Color),
//         labelSmall: defaultTextStyle.copyWith(fontSize: 8.1, height: 16 / 8.1),
//         displayLarge: defaultTextStyle.copyWith(fontSize: 34.8, height: 40 / 34.8, fontWeight: FontWeight.bold, fontFamily: 'Gilroy', color: ColorPalette.text1Color),
//         displayMedium: defaultTextStyle.copyWith(fontSize: 29, height: 32 / 29, fontWeight: FontWeight.bold, fontFamily: 'Gilroy', color: ColorPalette.text1Color),
//         displaySmall: defaultTextStyle.copyWith(fontSize: 24.2, height: 32 / 24.2, fontWeight: FontWeight.bold, fontFamily: 'Gilroy', color: ColorPalette.text1Color),
//         headlineMedium: defaultTextStyle.copyWith(fontSize: 20.2, height: 24 / 20.2, fontWeight: FontWeight.bold, fontFamily: 'Gilroy', color: ColorPalette.text1Color),
//         headlineSmall: defaultTextStyle.copyWith(fontSize: 16.8, height: 24 / 16.8, fontWeight: FontWeight.bold, fontFamily: 'Gilroy', color: ColorPalette.text1Color),
//         titleLarge: defaultTextStyle.copyWith(fontSize: 14, height: 16 / 14, fontWeight: FontWeight.bold, fontFamily: 'Gilroy', color: ColorPalette.text1Color),
// */
