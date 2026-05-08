# Input Schema — pa-theme

## Parameters

| Parameter | Type | Required | Values | Description |
|---|---|---|---|---|
| `TASK` | enum | Yes | See below | The type of theming work being done |
| `TOKEN` | string | Conditional | `colorScheme.*`, `textTheme.*`, `AppSpacing.*` | The specific token to use or add |
| `USAGE` | string | Conditional | — | Where the token will be used (for documentation) |
| `CATEGORY` | string | Conditional | See AppColors | Pattern category name (when adding a new category color) |
| `COLOR_HEX` | string | Conditional | `#RRGGBB` | Hex value for a new `AppColors` entry |

## TASK Values

| Value | Description |
|---|---|
| `add_color_token` | Apply a color token to a widget |
| `add_typography_token` | Apply a text style token to a widget |
| `add_spacing_token` | Apply a spacing constant |
| `setup_theme` | Generate the full `AppTheme` class |
| `add_category_color` | Add a new pattern category to `AppColors` |
| `enable_dark_mode` | Configure `MaterialApp` for light/dark/system |
| `audit_hardcoded` | Scan a file for hardcoded values and replace with tokens |

## Example Inputs

### Apply a color token

```
TASK: add_color_token
TOKEN: colorScheme.primary
USAGE: FilledButton background in transformer screen
```

### Add a new category color

```
TASK: add_category_color
CATEGORY: meta_prompt
COLOR_HEX: #607D8B
```

### Audit a file for hardcoded values

```
TASK: audit_hardcoded
FILE: lib/features/transformer/presentation/screens/transformer_screen.dart
```

### Set up theme from scratch

```
TASK: setup_theme
SEED_COLOR: #6750A4
```
