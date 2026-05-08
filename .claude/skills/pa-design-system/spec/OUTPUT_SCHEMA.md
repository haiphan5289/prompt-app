# Output Schema — pa-design-system

## Files Produced by Task

| Task | Output |
|---|---|
| `implement_screen` | `lib/features/{{feature}}/presentation/screens/{{name_snake}}_screen.dart` |
| `implement_component` | `lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart` |
| `select_component` | Inline guidance (no file) |
| `apply_typography` | Modified widget file |
| `apply_iconography` | Inline guidance (no file) |
| `audit_design` | Modified files with violations corrected |

## Screen File Structure

```dart
// lib/features/{{feature}}/presentation/screens/{{name_snake}}_screen.dart
import 'package:flutter/material.dart';

class {{Name}}Screen extends StatelessWidget {
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
```

## Standard UI Pattern Shapes

### Transformer Screen (full)
```
Scaffold
└── SingleChildScrollView
    └── Column (stretch)
        ├── PromptInputSection (TextField)
        ├── SizedBox(AppSpacing.md)
        ├── PatternSelectorRow (horizontal chips)
        ├── SizedBox(AppSpacing.md)
        ├── TransformButton (FilledButton, full width)
        ├── SizedBox(AppSpacing.lg)
        └── PromptResultSection (Card + SelectableText)
```

### Pattern Card
```
Card
└── Padding(AppSpacing.md)
    └── Column
        ├── Row [Chip(category)] [Spacer] [IconButton(info)]
        ├── Text(pattern.name, titleMedium)
        ├── SizedBox(AppSpacing.xs)
        └── Text(pattern.description, bodySmall)
```

### Result Card
```
Card (colorScheme.surfaceVariant)
└── Padding(AppSpacing.md)
    └── Column
        ├── Row [Text('Enhanced Prompt', labelLarge)] [Spacer] [CopyButton]
        ├── Divider
        └── SelectableText(result.enhancedPrompt, bodyMedium)
```

### History Entry
```
ListTile
├── title: Text(originalPrompt, maxLines:1, ellipsis, bodyMedium)
├── subtitle: Text(patternName, labelSmall, colorScheme.secondary)
└── trailing: Text(formattedDate, labelSmall)
```

## Constraints

| Constraint | Rule |
|---|---|
| Screen scrolling | Always wrap body in `SingleChildScrollView` |
| Primary CTA | Always `FilledButton` — never `ElevatedButton` |
| Destructive actions | `TextButton` with `colorScheme.error` color |
| Copy actions | Always `IconButton` with `Icons.copy_outlined` |
| Selectable text | Always `SelectableText` for prompt content |
| Loading states | `LinearProgressIndicator` inline, `CircularProgressIndicator` centered |
