import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppTextStyles {
  // Headlines: Poppins Bold (24-32sp)
  static const TextStyle headline1 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 32,
    color: AppTheme.charcoal,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppTheme.charcoal,
  );

  // Subtitles: Poppins SemiBold (18-20sp)
  static const TextStyle subtitle1 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppTheme.charcoal,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: AppTheme.charcoal,
  );

  // Body: Inter Regular (14-16sp)
  static const TextStyle body1 = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: AppTheme.charcoal,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: AppTheme.charcoal,
  );

  // Captions: Inter Light (12-14sp)
  static const TextStyle caption = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: AppTheme.silver,
  );

  // Buttons: Poppins Medium (16sp)
  static const TextStyle button = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppTheme.snowWhite,
  );
}
