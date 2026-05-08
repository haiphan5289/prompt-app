import 'package:flutter/material.dart';

abstract final class AppTheme {
  // Indigo 600 — distinctive, intelligent, professional
  static const _seedColor = Color(0xFF4F46E5);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ),
        textTheme: _textTheme,
        cardTheme: _cardTheme,
        inputDecorationTheme: _inputDecorationTheme,
        appBarTheme: _appBarTheme,
        chipTheme: _chipTheme,
        filledButtonTheme: _filledButtonTheme,
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ).copyWith(
          // Deepen the dark backgrounds for a premium feel
          surface: const Color(0xFF0D1117),
          onSurface: const Color(0xFFE6EDF3),
          surfaceContainerLow: const Color(0xFF161B22),
          surfaceContainer: const Color(0xFF1C2128),
          surfaceContainerHigh: const Color(0xFF222831),
        ),
        textTheme: _textTheme,
        cardTheme: _cardTheme,
        inputDecorationTheme: _inputDecorationTheme,
        appBarTheme: _appBarTheme,
        chipTheme: _chipTheme,
        filledButtonTheme: _filledButtonTheme,
      );

  static const _textTheme = TextTheme(
    displayMedium: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.5),
    headlineMedium: TextStyle(fontWeight: FontWeight.w700, letterSpacing: -0.3),
    titleLarge: TextStyle(fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(height: 1.7, letterSpacing: 0.1),
    bodyMedium: TextStyle(height: 1.6),
    labelLarge: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
    labelMedium: TextStyle(fontWeight: FontWeight.w500),
  );

  static final _cardTheme = CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    clipBehavior: Clip.antiAlias,
  );

  static final _inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
    ),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
  );

  static const _appBarTheme = AppBarTheme(
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0.5,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
    ),
  );

  static final _chipTheme = ChipThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    side: BorderSide.none,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  );

  static final _filledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  );
}
