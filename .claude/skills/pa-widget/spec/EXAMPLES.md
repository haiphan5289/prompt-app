# Examples — pa-widget

## Example 1: PatternCard (StatelessWidget, no provider)

### Input

```
WIDGET_TYPE: Card
NAME: PatternCard
FEATURE: pattern_library
READS_PROVIDER: no
PROPS:
  - pattern: PromptPattern
  - onTap: VoidCallback?
```

### Output: lib/features/pattern_library/presentation/widgets/pattern_card.dart

```dart
import 'package:flutter/material.dart';
import 'package:prompt_app/features/pattern_library/domain/entities/prompt_pattern.dart';

class PatternCard extends StatelessWidget {
  const PatternCard({
    super.key,
    required this.pattern,
    this.onTap,
  });

  final PromptPattern pattern;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(pattern.name),
        subtitle: Text(pattern.description),
        trailing: Chip(label: Text(pattern.category)),
        onTap: onTap,
      ),
    );
  }
}
```

---

## Example 2: PromptResultCard (ConsumerWidget, reads provider)

### Input

```
WIDGET_TYPE: Card
NAME: PromptResultCard
FEATURE: transformer
READS_PROVIDER: yes
PROPS: []
```

### Output: lib/features/transformer/presentation/widgets/prompt_result_card.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prompt_app/features/transformer/presentation/notifiers/transformer_notifier.dart';

class PromptResultCard extends ConsumerWidget {
  const PromptResultCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transformerNotifierProvider);
    return state.when(
      data: (result) => result == null
          ? const SizedBox.shrink()
          : _ResultContent(result: result),
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => _ErrorBanner(message: e.toString()),
    );
  }
}

class _ResultContent extends StatelessWidget {
  const _ResultContent({required this.result});

  final TransformerResult result;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: SelectableText(
          result.enhancedPrompt,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
```

---

## Example 3: CopyButton (StatelessWidget, utility)

### Input

```
WIDGET_TYPE: Button
NAME: CopyButton
FEATURE: shared
READS_PROVIDER: no
PROPS:
  - text: String
```

### Output: lib/features/shared/presentation/widgets/copy_button.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({super.key, required this.text});

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

---

## Example 4: CategoryChip (StatelessWidget, selectable)

### Input

```
WIDGET_TYPE: Chip
NAME: CategoryChip
FEATURE: shared
READS_PROVIDER: no
PROPS:
  - label: String
  - isSelected: bool
  - onTap: VoidCallback
```

### Output: lib/features/shared/presentation/widgets/category_chip.dart

```dart
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
    );
  }
}
```
