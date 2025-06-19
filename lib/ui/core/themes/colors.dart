import 'package:flutter/material.dart';

/// A centralized palette of app colors for consistent theming.
abstract final class AppColors {
  // Core Neutrals
  static const Color black1 = Color(0xFF101010);
  static const Color white1 = Color(0xFFFFF7FA);
  static const Color grey1 = Color(0xFFF2F2F2);
  static const Color grey2 = Color(0xFFBDBDBD);
  static const Color grey3 = Color(0xFFA4A4A4);
  static const Color grey4 = Color(0xFF757575);
  static const Color grey5 = Color(0xFF4D4D4D);
  static const Color grey6 = Color(0xFF2B2B2B);

  // Transparent Variants
  static const Color whiteTransparent = Color(0x4DFFFFFF); // 30% opacity
  static const Color blackTransparent = Color(0x4D000000); // 30% opacity

  // Semantic Colors
  static const Color red1 = Color(0xFFE74C3C);
  static const Color green1 = Color(0xFF27AE60);
  static const Color yellow1 = Color(0xFFF1C40F);
  static const Color blue1 = Color(0xFF3498DB);
  static const Color orange1 = Color(0xFFE67E22);
  static const Color purple1 = Color(0xFF9B59B6);

  // Primary Palette (Light Blue Gray)
  static const Color primary = Color(0xFF90A4AE); // Blue Gray 300
  static const Color primaryLight = Color(0xFFCFD8DC); // Blue Gray 100
  static const Color primaryDark = Color(0xFF546E7A); // Blue Gray 600
  static const Color primaryVariant = primaryDark;

  // Secondary Palette (Accent)
  static const Color secondary = blue1;
  static const Color secondaryLight = Color(0xFF85C1E9);
  static const Color secondaryDark = Color(0xFF21618C);

  /// Light Theme ColorScheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: white1,
    onPrimaryContainer: primaryDark,
    secondary: secondary,
    onSecondary: white1,
    surface: grey1,
    onSurface: grey6,
    error: red1,
    onError: white1,
    shadow: grey3,
  );

  /// Dark Theme ColorScheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryDark,
    onPrimary: white1,
    onPrimaryContainer: primaryDark,
    secondary: secondaryDark,
    onSecondary: white1,
    surface: grey5,
    onSurface: grey1,
    error: red1,
    onError: black1,
    shadow: grey2,
  );
}
