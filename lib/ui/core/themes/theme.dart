import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// Application themes configured with a productivity-based Google Font (Inter).
abstract final class AppTheme {
  static const TextTheme _baseTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1,
      color: AppColors.grey6,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1,
      color: AppColors.grey6,
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1,
      color: AppColors.grey6,
    ),
    titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.grey3,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      color: AppColors.grey3,
      fontWeight: FontWeight.w300,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      color: AppColors.grey3,
      fontWeight: FontWeight.w300,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      color: AppColors.grey3,
      fontWeight: FontWeight.w300,
    ),
  );

  static final TextTheme _textTheme = GoogleFonts.interTextTheme(
    _baseTextTheme,
  );

  static const _inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.grey3,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
  );

  /// Light theme data
  static final ThemeData lightTheme = ThemeData(
    colorScheme: AppColors.lightColorScheme,
    shadowColor: AppColors.lightColorScheme.shadow,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightColorScheme.surface,
    inputDecorationTheme: _inputDecorationTheme,
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      titleTextStyle: _textTheme.headlineSmall?.copyWith(
        color: AppColors.black1,
      ),
    ),
  );

  /// Dark theme data
  static final ThemeData darkTheme = ThemeData(
    colorScheme: AppColors.darkColorScheme,
    shadowColor: AppColors.darkColorScheme.shadow,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkColorScheme.surface,
    inputDecorationTheme: _inputDecorationTheme,
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      color: AppColors.primaryDark,
      titleTextStyle: _textTheme.headlineSmall?.copyWith(
        color: AppColors.white1,
      ),
    ),
  );
}
