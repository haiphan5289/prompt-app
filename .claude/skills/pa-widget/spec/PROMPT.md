# Execution Workflow — pa-widget

## Step 1: Parse Input

Read all input fields:
- `WIDGET_TYPE` — Card | TextField | Button | Chip | ListItem | Sheet | Banner
- `NAME` — PascalCase widget name (e.g. `PatternCard`)
- `FEATURE` — feature folder or `shared` (e.g. `pattern_library`, `shared`)
- `READS_PROVIDER` — `yes` | `no`
- `PROPS` — list of `name: Type` pairs

Derive:
- `name_snake` = snake_case of NAME (e.g. `pattern_card`)
- File path = `lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart`

## Step 2: Choose Base Class

| Condition | Use |
|---|---|
| `READS_PROVIDER: yes` | `ConsumerWidget` |
| `READS_PROVIDER: no` | `StatelessWidget` |

Never use `StatefulWidget` for simple widgets. If local ephemeral state is truly needed, consult the feature Notifier instead.

## Step 3: Generate Widget File

### If ConsumerWidget

```dart
// lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class {{Name}} extends ConsumerWidget {
  const {{Name}}({
    super.key,
    // props here
  });

  // prop declarations here

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(/* relevant provider */);
    return /* widget tree */;
  }
}
```

### If StatelessWidget

```dart
// lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart
import 'package:flutter/material.dart';

class {{Name}} extends StatelessWidget {
  const {{Name}}({
    super.key,
    required this./* requiredProp */,
    this./* optionalProp */,
    this.onTap,
  });

  final /* Type requiredProp */;
  final /* Type? optionalProp */;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return /* widget tree */;
  }
}
```

## Step 4: Implement Widget Body

Apply design system rules:
- Use `Theme.of(context).colorScheme.*` for all colors
- Use `Theme.of(context).textTheme.*` for all text styles
- Use `AppSpacing.xs/sm/md/lg/xl` for all padding/gaps
- Use `const` for all `EdgeInsets`, `SizedBox`, `Icon`

If `build()` exceeds 50 lines, extract private helper widgets:

```dart
class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => /* ... */;
}
```

Private helpers use leading underscore and are declared in the same file, after the main class.

## Step 5: Map WIDGET_TYPE to Material Component

| WIDGET_TYPE | Material Component |
|---|---|
| Card | `Card` with `Padding` + `Column`/`ListTile` |
| TextField | `TextField` with `InputDecoration` |
| Button | `FilledButton` (primary), `OutlinedButton` (secondary) |
| Chip | `FilterChip` (selectable) or `Chip` (display only) |
| ListItem | `ListTile` |
| Sheet | `DraggableScrollableSheet` inside `showModalBottomSheet` |
| Banner | `Material` + `Row` with icon + text + close button |

## Step 6: Handle Interactive States

For widgets with `onTap` or similar callbacks:
- Pass callback as optional `VoidCallback?`
- Do NOT implement business logic in the widget — delegate to the callback
- For loading/disabled states, accept a `bool isLoading` or `bool isEnabled` prop

## Step 7: Verify

Run through the EVAL.md checklist before marking done.
