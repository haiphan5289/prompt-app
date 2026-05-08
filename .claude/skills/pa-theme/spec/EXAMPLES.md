# Examples — pa-theme

## Example 1: Applying Color Tokens to a Widget

### Before (hardcoded — wrong)

```dart
Card(
  color: Color(0xFFEDE7F6),
  child: Text(
    'Enhanced Prompt',
    style: TextStyle(
      color: Color(0xFF6750A4),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
)
```

### After (theme tokens — correct)

```dart
Card(
  color: Theme.of(context).colorScheme.surfaceVariant,
  child: Text(
    'Enhanced Prompt',
    style: Theme.of(context).textTheme.titleMedium,
  ),
)
```

---

## Example 2: Spacing Token Usage

### Before (hardcoded — wrong)

```dart
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  child: Column(
    children: [
      const SizedBox(height: 8),
      const SizedBox(height: 24),
    ],
  ),
)
```

### After (spacing tokens — correct)

```dart
Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.sm,
  ),
  child: Column(
    children: [
      const SizedBox(height: AppSpacing.sm),
      const SizedBox(height: AppSpacing.lg),
    ],
  ),
)
```

---

## Example 3: Adding a New Pattern Category Color

### Input

```
TASK: add_category_color
CATEGORY: meta_prompt
COLOR_HEX: #607D8B
```

### Output: app_colors.dart (new entry added)

```dart
abstract class AppColors {
  static const roleBased      = Color(0xFF4CAF50);
  static const chainOfThought = Color(0xFF2196F3);
  static const fewShot        = Color(0xFFFF9800);
  static const outputFormat   = Color(0xFF9C27B0);
  static const constrained    = Color(0xFFF44336);
  static const risen          = Color(0xFF00BCD4);
  static const cato           = Color(0xFFFF5722);
  static const metaPrompt     = Color(0xFF607D8B); // NEW
}

Color categoryColor(String category) => switch (category) {
  'role_based'       => AppColors.roleBased,
  'chain_of_thought' => AppColors.chainOfThought,
  'few_shot'         => AppColors.fewShot,
  'output_format'    => AppColors.outputFormat,
  'constraint_based' => AppColors.constrained,
  'risen'            => AppColors.risen,
  'cato'             => AppColors.cato,
  'meta_prompt'      => AppColors.metaPrompt,     // NEW
  _                  => Colors.grey,
};
```

---

## Example 4: Full ThemeData Setup

### Output: lib/core/theme/app_theme.dart

```dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      brightness: Brightness.light,
    ),
    textTheme: _textTheme,
    cardTheme: _cardTheme,
    inputDecorationTheme: _inputDecorationTheme,
    appBarTheme: _appBarTheme,
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      brightness: Brightness.dark,
    ),
    textTheme: _textTheme,
    cardTheme: _cardTheme,
    inputDecorationTheme: _inputDecorationTheme,
    appBarTheme: _appBarTheme,
  );

  static const TextTheme _textTheme = TextTheme();

  static const CardTheme _cardTheme = CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  static const InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(),
    filled: true,
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    centerTitle: false,
    elevation: 0,
  );
}
```

### Output: lib/main.dart (MaterialApp config)

```dart
MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: ThemeMode.system,
  home: const TransformerScreen(),
)
```
