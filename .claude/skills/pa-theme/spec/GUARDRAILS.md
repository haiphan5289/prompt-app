# Guardrails — pa-theme

## Core Rule

Never hardcode any color, font size, font weight, or spacing value. Always use theme tokens. This applies to every file in the project, not just new code.

## Prohibited Patterns

### Hardcoded Colors

```dart
// NEVER — any of these
color: Colors.purple,
color: Colors.blue[800],
color: Color(0xFF6750A4),
color: Color.fromARGB(255, 103, 80, 164),
backgroundColor: Colors.white,
fillColor: Colors.grey[200],

// ALWAYS
color: Theme.of(context).colorScheme.primary,
color: Theme.of(context).colorScheme.surface,
color: Theme.of(context).colorScheme.surfaceVariant,
```

### Hardcoded Font Sizes

```dart
// NEVER
style: TextStyle(fontSize: 16),
style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
style: const TextStyle(fontSize: 12, color: Colors.grey),

// ALWAYS
style: Theme.of(context).textTheme.bodyMedium,
style: Theme.of(context).textTheme.labelSmall,
```

### Hardcoded Font Weights

```dart
// NEVER
fontWeight: FontWeight.bold,
fontWeight: FontWeight.w600,
fontWeight: FontWeight.w700,

// ALWAYS — use textTheme token which encodes the correct weight
style: Theme.of(context).textTheme.titleMedium,
```

### Hardcoded Spacing

```dart
// NEVER
padding: EdgeInsets.all(16),
padding: EdgeInsets.symmetric(horizontal: 12),
SizedBox(height: 24),
SizedBox(width: 8),
margin: EdgeInsets.only(top: 32),

// ALWAYS
padding: const EdgeInsets.all(AppSpacing.md),
padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
const SizedBox(height: AppSpacing.lg),
const SizedBox(width: AppSpacing.sm),
margin: const EdgeInsets.only(top: AppSpacing.xl),
```

### Manual Brightness Branching

```dart
// NEVER — colorScheme already adapts
final isDark = Theme.of(context).brightness == Brightness.dark;
color: isDark ? Colors.white : Colors.black,

// ALWAYS
color: Theme.of(context).colorScheme.onSurface,
```

### Hard Border Radius

```dart
// NEVER
BorderRadius.circular(8),
BorderRadius.circular(12),

// PREFER — use theme shape or a named constant
shape: Theme.of(context).cardTheme.shape,
// or define in app_theme.dart as _cardTheme
```

## Verified Theme Symbols

| Symbol | Access | Notes |
|---|---|---|
| `colorScheme.primary` | `Theme.of(context).colorScheme.primary` | Primary brand color |
| `colorScheme.onPrimary` | `Theme.of(context).colorScheme.onPrimary` | Text on primary |
| `colorScheme.secondary` | `Theme.of(context).colorScheme.secondary` | Accent, chips |
| `colorScheme.surface` | `Theme.of(context).colorScheme.surface` | Card backgrounds |
| `colorScheme.onSurface` | `Theme.of(context).colorScheme.onSurface` | Text on cards |
| `colorScheme.error` | `Theme.of(context).colorScheme.error` | Error states |
| `colorScheme.outline` | `Theme.of(context).colorScheme.outline` | Borders, dividers |
| `colorScheme.surfaceVariant` | `Theme.of(context).colorScheme.surfaceVariant` | Input fields, result cards |
| `textTheme.displayMedium` | `Theme.of(context).textTheme.displayMedium` | Hero text |
| `textTheme.headlineMedium` | `Theme.of(context).textTheme.headlineMedium` | Screen titles |
| `textTheme.titleLarge` | `Theme.of(context).textTheme.titleLarge` | Section headers |
| `textTheme.titleMedium` | `Theme.of(context).textTheme.titleMedium` | Pattern names |
| `textTheme.bodyLarge` | `Theme.of(context).textTheme.bodyLarge` | Prompt content |
| `textTheme.bodyMedium` | `Theme.of(context).textTheme.bodyMedium` | Descriptions |
| `textTheme.labelLarge` | `Theme.of(context).textTheme.labelLarge` | Button labels |
| `textTheme.labelSmall` | `Theme.of(context).textTheme.labelSmall` | Timestamps, captions |
| `AppSpacing.xs` | `AppSpacing.xs` | 4px |
| `AppSpacing.sm` | `AppSpacing.sm` | 8px |
| `AppSpacing.md` | `AppSpacing.md` | 16px |
| `AppSpacing.lg` | `AppSpacing.lg` | 24px |
| `AppSpacing.xl` | `AppSpacing.xl` | 32px |
| `AppSpacing.xxl` | `AppSpacing.xxl` | 48px |
