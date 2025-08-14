import 'package:flutter/material.dart';

class AppTheme {
  // Ocean-Inspired Color Palette
  static const Color oceanBlue = Color(0xFF2563EB);
  static const Color deepNavy = Color(0xFF1E40AF);
  static const Color aquaTeal = Color(0xFF06B6D4);
  static const Color sandBeige = Color(0xFFF5F5DC);
  static const Color coralOrange = Color(0xFFFF7849);
  static const Color seafoam = Color(0xFF34D399);

  // Neutral Colors
  static const Color charcoal = Color(0xFF374151);
  static const Color silver = Color(0xFF9CA3AF);
  static const Color snowWhite = Color(0xFFFFFFFF);

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: oceanBlue,
      scaffoldBackgroundColor: sandBeige,
      fontFamily: 'Inter',

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: oceanBlue,
        foregroundColor: snowWhite,
        elevation: 0,
        centerTitle: true,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: oceanBlue,
          foregroundColor: snowWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: snowWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
