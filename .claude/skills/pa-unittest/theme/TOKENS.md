# Theme Tokens — Intelligent Indigo

Design tokens for Prompt App. Always use these — never hardcode values.

## Spacing — AppSpacing

| Token | Value | Use |
|---|---|---|
| `AppSpacing.xs` | 4px | Icon gaps, tight padding |
| `AppSpacing.sm` | 8px | Chip padding, small gaps |
| `AppSpacing.md` | 16px | Card padding, section padding |
| `AppSpacing.lg` | 24px | Between sections |
| `AppSpacing.xl` | 32px | Major section breaks |
| `AppSpacing.xxl` | 48px | Hero spacing |

## Color Tokens

### Semantic — colorScheme.*

| Token | Use |
|---|---|
| `colorScheme.primary` | Primary actions, active state, FAB |
| `colorScheme.onPrimary` | Text/icons on primary surfaces |
| `colorScheme.surface` | Screen background |
| `colorScheme.onSurface` | Body text |
| `colorScheme.surfaceContainerLow` | Input fill, subtle surfaces |
| `colorScheme.surfaceContainer` | Card fill |
| `colorScheme.onSurfaceVariant` | Secondary text, idle icons |
| `colorScheme.error` | Errors, destructive actions |
| `colorScheme.secondary` | Pattern names, metadata |
| `colorScheme.outline` | Dividers, subtle borders |

### Domain — AppColors.*

| Token | Color | Use |
|---|---|---|
| `AppColors.roleBased` | Indigo `#6366F1` | Role-based pattern badge |
| `AppColors.chainOfThought` | Sky `#0EA5E9` | Chain-of-Thought badge |
| `AppColors.fewShot` | Amber `#F59E0B` | Few-Shot badge |
| `AppColors.risen` | Emerald `#10B981` | RISEN badge |
| `AppColors.cato` | Pink `#EC4899` | CATO badge |
| `AppColors.custom` | Slate `#64748B` | Custom pattern badge |
| `AppColors.brandGradient` | Indigo→Violet | Hero surfaces |
| `AppColors.darkSurfaceGradient` | Navy gradient | Dark Scaffold background |

## Typography — textTheme.*

| Token | Use |
|---|---|
| `textTheme.displayMedium` | App hero / splash text |
| `textTheme.headlineMedium` | Screen titles |
| `textTheme.titleLarge` | Card titles, section headers |
| `textTheme.titleMedium` | Pattern names |
| `textTheme.bodyLarge` | Prompt content (large, readable) |
| `textTheme.bodyMedium` | Descriptions, secondary text |
| `textTheme.labelLarge` | Button labels, tab labels |
| `textTheme.labelMedium` | Chip labels |
| `textTheme.labelSmall` | Timestamps, captions |

## Theme Shape Constants

| Widget | Shape |
|---|---|
| Card | `borderRadius: 16` |
| TextField | `borderRadius: 14` |
| FilledButton | `borderRadius: 14`, height `52` |
| Chip | `borderRadius: 8` |

## Required Imports

```dart
import 'package:prompt_app/core/theme/app_spacing.dart';
import 'package:prompt_app/core/theme/app_colors.dart';
```

