// import 'package:flutter/material.dart';

// import '../index.dart';

// class AppColors {
//   const AppColors({
//     required this.primaryColor,
//     required this.secondaryColor,
//     required this.primaryTextColor,
//     required this.invertColor,
//     required this.errorTextColor,
//     required this.primaryGradient,
//     required this.border,
//     required this.borderInput,
//     required this.disabled,
//     required this.statusBarColor,
//     required this.bgPopupColor,
//   });

//   static late AppColors current;

//   final Color primaryColor;
//   final Color secondaryColor;
//   final Color primaryTextColor;
//   final Color invertColor;
//   final Color errorTextColor;
//   final Color border;
//   final Color borderInput;
//   final Color disabled;
//   final Color statusBarColor;
//   final Color bgPopupColor;

//   /// gradient
//   final LinearGradient primaryGradient;

//   static const defaultAppColor = AppColors(
//     primaryColor: Color(0xff110A5C),
//     secondaryColor: Color.fromARGB(255, 62, 62, 70),
//     primaryTextColor: Color(0x8a000000),
//     invertColor: Color(0xffffffff),
//     errorTextColor: Color(0xffCD3632),
//     primaryGradient: LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFE6C30)]),
//     border: Color(0xffBEBEBE),
//     borderInput: Color(0xff333333),
//     disabled: Color(0x80000548),
//     statusBarColor: Color(0xfff6f8fa),
//     bgPopupColor: Color(0xFF373737),
//   );

//   static const darkThemeColor = AppColors(
//     primaryColor: Color(0xffffffff),
//     secondaryColor: Color.fromARGB(255, 166, 168, 254),
//     primaryTextColor: Color(0xb3ffffff),
//     invertColor: Color(0xFF000000),
//     errorTextColor: Color(0xffCD3632),
//     primaryGradient: LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFE6C30)]),
//     border: Color(0xffDCDCDC),
//     borderInput: Color(0xffDCDCDC),
//     disabled: Color(0x80000548),
//     statusBarColor: Color(0xFF000000),
//     bgPopupColor: Color(0xFF373737),
//   );

//   static AppColors of(BuildContext context) {
//     final appColor = Theme.of(context).appColor;
//     current = appColor;
//     return current;
//   }

//   AppColors copyWith({
//     LinearGradient? primaryGradient,
//     Color? primaryColor,
//     Color? secondaryColor,
//     Color? primaryTextColor,
//     Color? secondaryTextColor,
//     Color? errorTextColor,
//     Color? border,
//     Color? borderInput,
//     Color? disabled,
//     Color? statusBarColor,
//     Color? bgPopupColor,
//   }) {
//     return AppColors(
//       primaryColor: primaryColor ?? this.primaryColor,
//       secondaryColor: secondaryColor ?? this.secondaryColor,
//       primaryTextColor: primaryTextColor ?? this.primaryTextColor,
//       invertColor: secondaryTextColor ?? invertColor,
//       errorTextColor: errorTextColor ?? this.errorTextColor,
//       primaryGradient: primaryGradient ?? this.primaryGradient,
//       border: border ?? this.border,
//       borderInput: borderInput ?? this.borderInput,
//       disabled: disabled ?? this.disabled,
//       statusBarColor: statusBarColor ?? this.statusBarColor,
//       bgPopupColor: bgPopupColor ?? this.bgPopupColor,
//     );
//   }
// }

// // import 'package:flutter/material.dart';

// // const Color customColor50 = Color(0xfffcd5ce);
// // const Color customColor100 = Color(0xfffaac9d);
// // const Color customColor300 = Color(0xfff8836c);
// // const Color customColor400 = Color(0xfff65a3b);

// // const Color customColor900 = Color(0xfff4310a);
// // const Color customColor600 = Color(0xffc32708);

// // const Color customErrorRed = Color(0xFFC5032B);

// // const Color customSurfaceWhite = Color(0xFFFFFBFA);
// // const Color customBackgroundWhite = Colors.white;

// // class DColorSheme {
// //   static const ColorScheme lightColorScheme = ColorScheme(
// //     primary: customColor50,
// //     primaryContainer: customColor600,
// //     secondary: Colors.amber,
// //     secondaryContainer: customColor400,
// //     surface: Colors.purpleAccent,
// //     background: customSurfaceWhite,
// //     error: customColor900,
// //     onPrimary: Colors.red,
// //     onSecondary: Colors.deepOrange,
// //     onSurface: customColor300,
// //     onBackground: customColor100,
// //     onError: Colors.redAccent,
// //     brightness: Brightness.light,
// //   );

// //   static const ColorScheme darkColorScheme = ColorScheme(
// //     primary: customColor50,
// //     primaryContainer: customColor600,
// //     secondary: Colors.amber,
// //     secondaryContainer: customColor400,
// //     surface: Colors.purpleAccent,
// //     background: customSurfaceWhite,
// //     error: customColor900,
// //     onPrimary: Colors.red,
// //     onSecondary: Colors.deepOrange,
// //     onSurface: customColor300,
// //     onBackground: customColor100,
// //     onError: Colors.redAccent,
// //     brightness: Brightness.light,
// //   );
// // }
