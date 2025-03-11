import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../index.dart';

TextStyle get style => GoogleFonts.urbanist();

class AppTextStyle {
  const AppTextStyle(this.context);

  final BuildContext context;

  ThemeData get theme => Theme.of(context);

  TextTheme get textTheme => GoogleFonts.urbanistTextTheme(theme.textTheme); // GoogleFonts.latoTextTheme(theme.textTheme);

  TextStyle? get displayLarge => textTheme.displayLarge?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get displayMedium => textTheme.displayMedium?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get displaySmall => textTheme.displaySmall?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get headlineLarge => textTheme.headlineLarge?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get headlineMedium => textTheme.headlineMedium?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get headlineSmall => textTheme.headlineSmall?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get titleLarge => textTheme.titleLarge?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get titleMedium => textTheme.titleMedium?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get titleSmall => textTheme.titleSmall?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get labelLarge => textTheme.labelLarge?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get labelMedium => textTheme.labelMedium?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get labelSmall => textTheme.labelSmall?.copyWith(
        color: context.colorScheme.onSurface,
        letterSpacing: 0,
      );
  TextStyle? get bodyLarge => textTheme.bodyLarge?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get bodyMedium => textTheme.bodyMedium?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get bodySmall => textTheme.bodySmall?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get headline4 => textTheme.headlineMedium?.copyWith(
        color: context.colorScheme.onSurface,
      );
  TextStyle? get headline5 => textTheme.headlineSmall?.copyWith(
        color: context.colorScheme.onSurface,
      );
}
