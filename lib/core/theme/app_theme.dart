import 'package:flutter/material.dart';

/// Basic light theme used by the app.
class AppTheme {
  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      );
}
