import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFFF6B35); // Orange
  static const primaryVariant = Color(0xFFE55100); // Dark Orange
  static const secondary = Color(0xFF4CAF50); // Green
  static const background = Color(0xFFFAFAFA); // Light Gray
  static const surface = Colors.white;
  static const error = Color(0xFFD32F2F); // Red
}

class AppTheme {
  static ThemeData get lightTheme {
    useMaterial3:
    true;
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.surface,
        background: AppColors.background,
        onPrimary: AppColors.primary,
        onSecondary: AppColors.secondary,
        onError: AppColors.error,
        onSurface: AppColors.primaryVariant,
        seedColor: AppColors.primary,
      ),
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.heading1,
        headlineMedium: AppTextStyles.heading2,
        titleLarge: AppTextStyles.caption,
        bodyLarge: AppTextStyles.body,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
        foregroundColor: AppColors.primaryVariant,
      )),
      iconTheme: const IconThemeData(
        color: AppColors.primaryVariant,
        size: 30,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const body = TextStyle(
    fontSize: 16,
    height: 1.5,
  );

  static const caption = TextStyle(
    fontSize: 30,
  );
}
