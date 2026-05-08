# Output Schema — pa-widget

## Generated Files

| File | Description |
|---|---|
| `lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart` | The widget class (always exactly 1 file) |

## File Structure

```
lib/features/{{feature}}/
└── presentation/
    └── widgets/
        └── {{name_snake}}.dart
```

## Widget File Structure

```dart
// 1. Imports (Flutter, then Riverpod if needed, then local)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // only if ConsumerWidget

// 2. Main widget class
class {{Name}} extends [ConsumerWidget | StatelessWidget] {
  // const constructor
  // prop fields (final)
  // build() method
}

// 3. Private helper sub-widgets (if build() > 50 lines)
class _SubSection extends StatelessWidget { ... }
```

## Constraints

| Constraint | Rule |
|---|---|
| Build method length | Max 50 lines — extract `_SubWidget` if longer |
| Constructor | Must be `const` |
| State management | `ConsumerWidget` only when reading a provider |
| Props | Via constructor only — no global variable access in StatelessWidget |
| Callbacks | Typed as `VoidCallback?` or `void Function(T)?` |
| Colors | Only `colorScheme.*` or `AppColors.*` |
| Typography | Only `textTheme.*` tokens |
| Spacing | Only `AppSpacing.*` constants |

## Common Widget Output Shapes

### PatternCard (StatelessWidget)
One file, ~30 lines, `Card > ListTile` structure.

### PromptResultCard (ConsumerWidget)
One file, ~25 lines, `state.when(data:, loading:, error:)` pattern.

### CopyButton (StatelessWidget)
One file, ~20 lines, `IconButton` with `Clipboard.setData` and `SnackBar`.

### CategoryChip (StatelessWidget)
One file, ~15 lines, `FilterChip` with `selected` and `onSelected`.
