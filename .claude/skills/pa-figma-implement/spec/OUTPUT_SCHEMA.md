# Output Schema — pa-figma-implement

## Files Produced

| TARGET | File Generated |
|---|---|
| `Screen` | `lib/features/{{feature}}/presentation/screens/{{name_snake}}_screen.dart` |
| `Widget` | `lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart` |
| `Component` | `lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart` |

One file per invocation. Screens may contain private helper sub-widgets, all in the same file.

## Screen File Structure

```dart
import 'package:flutter/material.dart';
// + feature-specific imports

class {{Name}}Screen extends StatelessWidget {    // or ConsumerWidget
  const {{Name}}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{{Title}}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [/* sections */],
        ),
      ),
    );
  }
}

// Private sub-widgets below (if needed)
class _SectionName extends StatelessWidget { ... }
```

## Widget File Structure

```dart
import 'package:flutter/material.dart';

class {{Name}} extends StatelessWidget {    // or ConsumerWidget
  const {{Name}}({super.key, /* props */});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return /* widget tree using theme tokens */;
  }
}
```

## Constraints on Generated Code

| Constraint | Rule |
|---|---|
| Colors | Only `colorScheme.*` or `AppColors.*` — never raw |
| Typography | Only `textTheme.*` — never `TextStyle(fontSize:...)` |
| Spacing | Only `AppSpacing.*` — never numeric literals |
| Build length | Max 50 lines — extract `_SubWidget` if longer |
| Constructors | Always `const` |
| Provider reads | Use `ConsumerWidget` only if provider state is needed |
| Interactive text | `SelectableText` for all prompt output |
| Scroll | `SingleChildScrollView` wraps all screen bodies |

## What Is NOT Generated

- Tests (use `pa-unittest` skill)
- Notifier / provider files (use `pa-flutter-expert-skill`)
- Navigation routing (configure separately)
- Data models or repositories (use `pa-service` or `pa-scaffold`)
