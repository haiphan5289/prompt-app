# Output Schema — pa-theme

## Files Produced by Task

| Task | Files Modified/Created |
|---|---|
| `setup_theme` | `lib/core/theme/app_theme.dart` (create), `lib/core/theme/app_spacing.dart` (create), `lib/core/theme/app_colors.dart` (create) |
| `add_category_color` | `lib/core/theme/app_colors.dart` (modify — add entry) |
| `enable_dark_mode` | `lib/main.dart` (modify — MaterialApp config) |
| `audit_hardcoded` | The target file (modify — replace hardcoded values) |
| `add_color_token` | The target widget file (inline guidance) |
| `add_typography_token` | The target widget file (inline guidance) |
| `add_spacing_token` | The target widget file (inline guidance) |

## Core Theme Files

```
lib/core/theme/
├── app_theme.dart      ← ThemeData light + dark
├── app_spacing.dart    ← AppSpacing constants
└── app_colors.dart     ← AppColors domain-specific constants
```

## app_theme.dart Structure

```dart
class AppTheme {
  static ThemeData get light => ThemeData(useMaterial3: true, colorScheme: ...)
  static ThemeData get dark  => ThemeData(useMaterial3: true, colorScheme: ...)

  // Private sub-themes
  static TextTheme get _textTheme => ...
  static CardTheme get _cardTheme => ...
  static InputDecorationTheme get _inputDecorationTheme => ...
  static AppBarTheme get _appBarTheme => ...
}
```

## app_spacing.dart Structure

```dart
abstract class AppSpacing {
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 16;
  static const double lg  = 24;
  static const double xl  = 32;
  static const double xxl = 48;
}
```

## app_colors.dart Structure

```dart
abstract class AppColors {
  // Pattern category colors (fixed, not semantic)
  static const roleBased      = Color(0xFF4CAF50);
  static const chainOfThought = Color(0xFF2196F3);
  static const fewShot        = Color(0xFFFF9800);
  static const outputFormat   = Color(0xFF9C27B0);
  static const constrained    = Color(0xFFF44336);
  static const risen          = Color(0xFF00BCD4);
  static const cato           = Color(0xFFFF5722);
}

Color categoryColor(String category) => switch (category) { ... };
```

## Constraints

- `AppTheme` must always declare both `light` and `dark`
- Both themes use the same `seedColor`
- `AppSpacing` values are `const double` — no functions
- `AppColors` values are `const Color` — no functions (only the `categoryColor` helper is a function)
