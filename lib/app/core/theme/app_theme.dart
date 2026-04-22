import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ✅ STEP 1: Define semantic text styles in your AppTheme
// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: _buildTextTheme(Colors.black87),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: _buildTextTheme(Colors.white),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        brightness: Brightness.dark,
      ),
    );
  }

  static TextTheme _buildTextTheme(Color baseColor) {
    return TextTheme(
      // Use semantic names — NOT size-based names
      displayLarge: _poppins(32.sp, FontWeight.w700, baseColor),
      displayMedium: _poppins(28.sp, FontWeight.w700, baseColor),
      headlineLarge: _poppins(24.sp, FontWeight.w600, baseColor),
      headlineMedium: _poppins(20.sp, FontWeight.w600, baseColor),
      titleLarge: _poppins(18.sp, FontWeight.w600, baseColor),
      titleMedium: _poppins(16.sp, FontWeight.w500, baseColor),
      titleSmall: _poppins(14.sp, FontWeight.w500, baseColor),
      bodyLarge: _poppins(16.sp, FontWeight.w400, baseColor),
      bodyMedium: _poppins(14.sp, FontWeight.w400, baseColor),
      bodySmall: _poppins(12.sp, FontWeight.w400, baseColor),
      labelLarge: _poppins(14.sp, FontWeight.w500, baseColor),
      labelSmall: _poppins(11.sp, FontWeight.w400, baseColor),
    );
  }

  static TextStyle _poppins(
      double size,
      FontWeight weight,
      Color color,
      ) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }
}