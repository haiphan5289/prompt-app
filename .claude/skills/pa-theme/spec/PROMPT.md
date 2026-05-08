# Execution Workflow — pa-theme

## Step 1: Identify the Task

Determine which theming task is needed:

| Task | Action |
|---|---|
| Adding a new color to a widget | Map to nearest `colorScheme.*` token |
| Adding a new text style | Map to nearest `textTheme.*` token |
| Adding spacing/padding | Map to `AppSpacing.*` constant |
| Setting up ThemeData for a new app | Generate `AppTheme` class |
| Adding a new pattern category color | Add to `AppColors` class |
| Enabling dark mode | Configure `MaterialApp` with `AppTheme.light` and `AppTheme.dark` |

## Step 2: Apply Color Tokens

When a widget needs a color, map it using this lookup order:
1. Check `colorScheme.*` tokens — prefer these for semantic meaning
2. Check `AppColors.*` — use for domain-specific colors (pattern categories)
3. If no match: add a new entry to `AppColors` — never hardcode

```dart
// Correct usage
color: Theme.of(context).colorScheme.primary,         // primary action
color: Theme.of(context).colorScheme.surface,         // card background
color: Theme.of(context).colorScheme.error,           // error state
color: AppColors.roleBased,                           // category-specific
```

## Step 3: Apply Typography Tokens

Map design text sizes to `textTheme.*`:

| Visual Hierarchy | Token |
|---|---|
| Hero / App name | `displayMedium` |
| Screen title | `headlineMedium` |
| Section header / Card title | `titleLarge` |
| Pattern name | `titleMedium` |
| Body / Prompt content | `bodyLarge` |
| Descriptions / Secondary | `bodyMedium` |
| Button label / Tabs | `labelLarge` |
| Chip label / Tag | `labelMedium` |
| Timestamp / Caption | `labelSmall` |

```dart
Text('Screen Title', style: Theme.of(context).textTheme.headlineMedium),
Text(pattern.description, style: Theme.of(context).textTheme.bodyMedium),
```

## Step 4: Apply Spacing Tokens

Map pixel values from designs to `AppSpacing` constants:

| Value | Token |
|---|---|
| 4px | `AppSpacing.xs` |
| 8px | `AppSpacing.sm` |
| 16px | `AppSpacing.md` |
| 24px | `AppSpacing.lg` |
| 32px | `AppSpacing.xl` |
| 48px | `AppSpacing.xxl` |

```dart
Padding(padding: const EdgeInsets.all(AppSpacing.md), child: ...)
const SizedBox(height: AppSpacing.lg)
```

## Step 5: Set Up ThemeData (if new app)

Create or update `lib/core/theme/app_theme.dart`:

```dart
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
}
```

## Step 6: Configure MaterialApp for Dark Mode

Dark mode is automatic with Material 3. Do NOT branch on `Brightness` manually:

```dart
MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: ThemeMode.system,
)
```

## Step 7: Verify

Run through EVAL.md checklist. Specifically check:
- No hardcoded `Color(0xFF...)` or `Colors.*` in modified files
- No hardcoded `fontSize` or `fontWeight`
- No hardcoded pixel spacing values
