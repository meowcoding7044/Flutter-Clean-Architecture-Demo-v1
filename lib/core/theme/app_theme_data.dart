import 'package:first_flutter_v1/core/config/color/colors.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      useMaterial3: false,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: isDark ? AppColors.primaryDark : AppColors.primaryLight,
        onPrimary: isDark ? AppColors.onSurFaceDark : AppColors.onSurFaceLight,
        secondary: isDark ? AppColors.secondaryDark : AppColors.secondaryLight,
        onSecondary: isDark
            ? AppColors.onSurFaceDark
            : AppColors.onSurFaceLight,
        error: Colors.red,
        onError: Colors.white,
        surface: isDark ? AppColors.surFaceDark : AppColors.surFaceLight,
        onSurface: isDark ? AppColors.onSurFaceDark : AppColors.onSurFaceLight,
      ),
    );
  }
}
