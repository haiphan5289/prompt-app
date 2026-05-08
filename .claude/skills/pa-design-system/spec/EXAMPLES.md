# Examples — pa-design-system

## Example 1: Transformer Screen Layout

### Input

```
TASK: implement_screen
SCREEN: TransformerScreen
FEATURE: transformer
COMPONENTS: [PromptInput, PatternSelector, TransformButton, ResultCard]
```

### Output

```dart
Scaffold(
  appBar: AppBar(title: const Text('Prompt App')),
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PromptInputSection(),
        const SizedBox(height: AppSpacing.md),
        const PatternSelectorRow(),
        const SizedBox(height: AppSpacing.md),
        const TransformButton(),
        const SizedBox(height: AppSpacing.lg),
        const PromptResultSection(),
      ],
    ),
  ),
)
```

---

## Example 2: Pattern Card Component

### Input

```
TASK: implement_component
WIDGET_TYPE: PatternCard
FEATURE: pattern_library
```

### Output

```dart
Card(
  child: Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Chip(
              label: Text(pattern.category),
              backgroundColor: categoryColor(pattern.category).withOpacity(0.15),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: onInfo,
            ),
          ],
        ),
        Text(pattern.name, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(
          pattern.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  ),
)
```

---

## Example 3: Result Card Component

### Input

```
TASK: implement_component
WIDGET_TYPE: ResultCard
FEATURE: transformer
```

### Output

```dart
Card(
  color: Theme.of(context).colorScheme.surfaceVariant,
  child: Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Enhanced Prompt',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Spacer(),
            CopyButton(text: result.enhancedPrompt),
          ],
        ),
        const Divider(),
        SelectableText(
          result.enhancedPrompt,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
  ),
)
```

---

## Example 4: History Entry

### Input

```
TASK: implement_component
WIDGET_TYPE: HistoryEntry
FEATURE: history
```

### Output

```dart
ListTile(
  title: Text(
    entry.originalPrompt,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: Theme.of(context).textTheme.bodyMedium,
  ),
  subtitle: Text(
    entry.appliedPattern.name,
    style: Theme.of(context).textTheme.labelSmall?.copyWith(
      color: Theme.of(context).colorScheme.secondary,
    ),
  ),
  trailing: Text(
    _formatDate(entry.createdAt),
    style: Theme.of(context).textTheme.labelSmall,
  ),
  onTap: () => _showDetail(context, entry),
)
```

---

## Example 5: Component Selection Q&A

### Input

```
TASK: select_component
NEED: allow user to copy the enhanced prompt text
```

### Answer

Use `SelectableText` for the text content itself (long-press to select) and an `IconButton` with `Icons.copy_outlined` in the card header for one-tap copy:

```dart
// One-tap copy
IconButton(
  icon: const Icon(Icons.copy_outlined),
  onPressed: () {
    Clipboard.setData(ClipboardData(text: result.enhancedPrompt));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied!')),
    );
  },
),
// Selectable text (long-press)
SelectableText(result.enhancedPrompt),
```
