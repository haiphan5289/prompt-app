# Execution Workflow — pa-figma-implement

## Phase 1: Design Analysis

### If Figma MCP is available

```
Use mcp__figma to fetch the frame by FIGMA_URL
Extract from the frame:
  - Layout structure (Column, Row, Stack, Grid, ListView)
  - Colors used
  - Typography (font size, weight, style)
  - Spacing values (padding, gaps, margins)
  - Component hierarchy (nesting, z-order)
  - Interactive elements (taps, inputs, gestures)
  - Component states (normal, hover/pressed, disabled, loading, empty, error)
```

### If no MCP

Ask the user for:
1. A screenshot or description of the design
2. Colors used (identify via eyedropper if screenshot provided)
3. Text styles (size, weight, hierarchy level)
4. Spacing values (pixel measurements)
5. Interactive elements and their behaviors
6. Empty / error / loading states

## Phase 2: Token Mapping

Map every design value to a Flutter token:

### Color Mapping

| Figma Color | Flutter Token |
|---|---|
| Primary brand color | `colorScheme.primary` |
| Background | `colorScheme.surface` |
| Card background | `colorScheme.surfaceVariant` |
| Divider / border | `colorScheme.outline` |
| Error / destructive | `colorScheme.error` |
| Secondary accent | `colorScheme.secondary` |

**If a color has no matching semantic token:** use `AppColors.*` or add a new entry to `AppColors`. Never hardcode.

### Typography Mapping

| Figma Text Style | Flutter Token |
|---|---|
| Large heading / hero | `textTheme.headlineMedium` |
| Section header | `textTheme.titleLarge` |
| Card title | `textTheme.titleMedium` |
| Body text | `textTheme.bodyMedium` |
| Caption / metadata | `textTheme.labelSmall` |

### Spacing Mapping

| Figma Value | Flutter Token |
|---|---|
| 4px | `AppSpacing.xs` |
| 8px | `AppSpacing.sm` |
| 16px | `AppSpacing.md` |
| 24px | `AppSpacing.lg` |
| 32px | `AppSpacing.xl` |
| 48px | `AppSpacing.xxl` |

**If a spacing value has no token match:** round to the nearest token, or add a new constant — never hardcode.

## Phase 3: Widget Generation

Generate the Flutter widget following `pa-design-system` and `pa-widget` standards:

```dart
class {{Name}} extends StatelessWidget {
  const {{Name}}({super.key, /* props */});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return [layout widget](
      // All values from theme tokens
      // build() under 50 lines
      // Extract _SubSection if needed
    );
  }
}
```

Rules during generation:
- Every color → token
- Every text style → token
- Every spacing value → token
- `const` constructor always
- `build()` ≤ 50 lines

## Phase 4: Common Prompt App Design Patterns

Apply these patterns for known UI areas:

### Transformer Input Area
- Large `TextField` with `maxLines: null` (expands with content)
- Label above: `Text` with `textTheme.labelLarge`
- Char count below: `Text` with `textTheme.labelSmall`, `colorScheme.outline`

### Pattern Selector
- Horizontal `SingleChildScrollView` with `Row` of `FilterChip`s
- Selected chip: `colorScheme.primaryContainer`
- Unselected chip: `colorScheme.surfaceVariant`

### Enhanced Prompt Display
- `Card` with `colorScheme.surfaceVariant`
- `SelectableText` for copyable content
- `IconButton` with `Icons.copy_outlined` in top-right corner

## Phase 5: Visual Validation

Before marking done, run through all items in EVAL.md checklist.
