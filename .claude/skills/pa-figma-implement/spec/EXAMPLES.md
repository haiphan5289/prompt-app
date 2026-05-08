# Examples — pa-figma-implement

## Example 1: Transformer Screen (Screen target)

### Input

```
FIGMA_URL: https://www.figma.com/file/abc123?node-id=10-50
TARGET: Screen
NAME: TransformerScreen
FEATURE: transformer
```

### Design Analysis (extracted from Figma)

- Layout: vertical Column, full-width, scrollable
- Sections: text input, chip row, CTA button, result card
- Colors: primary (#6750A4 → `colorScheme.primary`), card bg (light grey → `colorScheme.surfaceVariant`)
- Spacing: 16px between sections → `AppSpacing.md`; 24px before result → `AppSpacing.lg`

### Token Mapping

| Design value | Token |
|---|---|
| Purple (#6750A4) | `colorScheme.primary` |
| Light grey card | `colorScheme.surfaceVariant` |
| Section gap 16px | `AppSpacing.md` |
| Before result 24px | `AppSpacing.lg` |
| Screen title "Prompt App" | `textTheme.headlineMedium` (AppBar) |

### Output: lib/features/transformer/presentation/screens/transformer_screen.dart

```dart
import 'package:flutter/material.dart';
import 'package:prompt_app/core/theme/app_spacing.dart';

class TransformerScreen extends StatelessWidget {
  const TransformerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prompt App')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _PromptInputSection(),
            const SizedBox(height: AppSpacing.md),
            const _PatternSelectorRow(),
            const SizedBox(height: AppSpacing.md),
            const _TransformButton(),
            const SizedBox(height: AppSpacing.lg),
            const _ResultSection(),
          ],
        ),
      ),
    );
  }
}

class _TransformButton extends StatelessWidget {
  const _TransformButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: const Icon(Icons.auto_fix_high),
      label: const Text('Transform'),
      onPressed: () {},
    );
  }
}
```

---

## Example 2: Pattern Selector Row (Widget target)

### Input

```
FIGMA_URL: (not available)
TARGET: Widget
NAME: PatternSelectorRow
FEATURE: transformer
DESCRIPTION: Horizontal scrollable row of filter chips. Selected chip has primary-tinted background. Unselected chip is surface variant. Short category name labels.
```

### Token Mapping

| Design | Token |
|---|---|
| Selected chip bg | `colorScheme.primaryContainer` |
| Unselected chip bg | `colorScheme.surfaceVariant` |
| Chip label | `textTheme.labelMedium` (default for FilterChip) |
| Row scroll | horizontal `SingleChildScrollView` |

### Output: lib/features/transformer/presentation/widgets/pattern_selector_row.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prompt_app/core/theme/app_spacing.dart';

class PatternSelectorRow extends ConsumerWidget {
  const PatternSelectorRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patterns = ref.watch(availablePatternsProvider);
    final selected = ref.watch(selectedPatternProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final pattern in patterns)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: FilterChip(
                label: Text(pattern.category),
                selected: selected?.id == pattern.id,
                onSelected: (_) => ref
                    .read(selectedPatternProvider.notifier)
                    .select(pattern),
              ),
            ),
        ],
      ),
    );
  }
}
```

---

## Example 3: Enhanced Prompt Display (Component target)

### Input

```
FIGMA_URL: https://www.figma.com/file/abc123?node-id=22-80
TARGET: Component
NAME: EnhancedPromptCard
FEATURE: transformer
```

### Design Analysis

- Card with light purple-grey background
- "Enhanced Prompt" label top-left, copy icon top-right
- Horizontal divider
- Monospace-ish text body (user's enhanced prompt)
- Text is selectable

### Token Mapping

| Design | Token |
|---|---|
| Card background | `colorScheme.surfaceVariant` |
| Label "Enhanced Prompt" | `textTheme.labelLarge` |
| Copy icon | `Icons.copy_outlined` |
| Prompt body text | `textTheme.bodyMedium` |
| Padding | `AppSpacing.md` |
| Gap header→divider | `AppSpacing.xs` |

### Output: lib/features/transformer/presentation/widgets/enhanced_prompt_card.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prompt_app/core/theme/app_spacing.dart';

class EnhancedPromptCard extends StatelessWidget {
  const EnhancedPromptCard({super.key, required this.enhancedPrompt});

  final String enhancedPrompt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Enhanced Prompt', style: theme.textTheme.labelLarge),
                const Spacer(),
                _CopyButton(text: enhancedPrompt),
              ],
            ),
            const Divider(),
            SelectableText(
              enhancedPrompt,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  const _CopyButton({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.copy_outlined),
      tooltip: 'Copy to clipboard',
      onPressed: () {
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Copied!')),
        );
      },
    );
  }
}
```
