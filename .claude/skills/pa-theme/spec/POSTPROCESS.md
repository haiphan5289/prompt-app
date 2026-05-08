# Post-Execution Steps — pa-theme

After applying theme changes, complete these steps.

## 1. Run Static Analysis

```bash
flutter analyze lib/core/theme/
flutter analyze lib/features/
```

Fix any errors before proceeding. Common issues:
- Import of `AppSpacing` or `AppColors` missing from widget files
- `Theme.of(context)` called outside `BuildContext` scope

## 2. Search for Remaining Hardcoded Values

Scan the modified files (and the entire features/ folder if doing an audit):

```bash
grep -r "Colors\." lib/features/ --include="*.dart"
grep -r "fontSize:" lib/features/ --include="*.dart"
grep -r "FontWeight\." lib/features/ --include="*.dart"
grep -r "Color(0x" lib/features/ --include="*.dart"
grep -rE "EdgeInsets\.(all|symmetric|only)\([0-9]" lib/features/ --include="*.dart"
```

Replace any matches found with appropriate tokens.

## 3. Test Dark Mode

Toggle the device/simulator to dark mode and visually verify:
- Cards, surfaces, and backgrounds adapt correctly
- Text remains readable against backgrounds
- No pure white or pure black elements visible (all via tokens)
- Pattern category colors remain visible in dark mode

## 4. Check New Theme Files (if app_theme.dart was created)

Confirm `MaterialApp` uses the new theme:

```dart
MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: ThemeMode.system,
)
```

## 5. Export Check (if AppSpacing or AppColors was created)

Ensure the new files are accessible to the rest of the app. If a `core/theme/theme.dart` barrel file exists, export the new files from it.

## 6. Hot Reload Test

After all changes, hot reload the app and visually verify:
- Transformer screen renders correctly
- Pattern library cards use correct colors
- All button styles consistent
- No visual regressions on previously-styled screens
