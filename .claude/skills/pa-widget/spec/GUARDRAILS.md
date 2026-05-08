# Guardrails — pa-widget

## Anti-Hallucination: Verify Before Using

Before referencing any provider in a `ConsumerWidget`, verify the provider name exists in the codebase:
- Search for `final {{name}}Provider` or `@riverpod` declarations
- If the provider does not exist, do NOT reference it — generate a placeholder comment or ask

Never invent:
- Provider names that are not confirmed to exist
- Widget class names from other packages (e.g. do not assume `PatternListView` exists)
- Custom sub-packages or barrel imports that are not confirmed

## Prohibited Patterns

### Hardcoded Colors

```dart
// NEVER
color: Colors.purple,
color: Colors.blue[800],
color: Color(0xFF6750A4),
backgroundColor: Colors.white,

// ALWAYS
color: Theme.of(context).colorScheme.primary,
color: Theme.of(context).colorScheme.surface,
```

### Hardcoded Typography

```dart
// NEVER
style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
style: TextStyle(fontSize: 14, color: Colors.grey),

// ALWAYS
style: Theme.of(context).textTheme.bodyMedium,
style: Theme.of(context).textTheme.labelSmall,
```

### Hardcoded Spacing

```dart
// NEVER
padding: const EdgeInsets.all(16),
padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
const SizedBox(height: 24),

// ALWAYS
padding: const EdgeInsets.all(AppSpacing.md),
padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
const SizedBox(height: AppSpacing.lg),
```

### Business Logic in Build

```dart
// NEVER — logic belongs in Notifier
Widget build(BuildContext context) {
  final sorted = patterns.sort((a, b) => a.name.compareTo(b.name)); // prohibited
  final filtered = patterns.where((p) => p.isActive).toList();      // prohibited
  return /* ... */;
}

// CORRECT — accept already-processed data via props
final List<PromptPattern> patterns; // sorted/filtered by the Notifier
```

### Reading Provider in StatelessWidget

```dart
// NEVER
class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final ref = ProviderScope.containerOf(context); // prohibited
  }
}

// CORRECT — extend ConsumerWidget
class MyWidget extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myProvider);
  }
}
```

### Non-Const Constructor

```dart
// NEVER
class MyCard extends StatelessWidget {
  MyCard({super.key, required this.title}); // missing const

// ALWAYS
class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.title});
```

### StatefulWidget for Provider State

```dart
// NEVER — use Riverpod for state, not StatefulWidget
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}
class _MyWidgetState extends State<MyWidget> {
  String _result = '';
  void _fetch() => setState(() { _result = compute(); }); // prohibited
}

// CORRECT — use ConsumerWidget + Notifier
```

## Verified Widget Symbols

| Widget | Import | Notes |
|---|---|---|
| `Card` | `flutter/material.dart` | Standard card |
| `ListTile` | `flutter/material.dart` | Row layout with leading/trailing |
| `FilterChip` | `flutter/material.dart` | Selectable chip |
| `FilledButton` | `flutter/material.dart` | Primary CTA |
| `OutlinedButton` | `flutter/material.dart` | Secondary action |
| `IconButton` | `flutter/material.dart` | Icon-only action |
| `SelectableText` | `flutter/material.dart` | User-selectable text |
| `LinearProgressIndicator` | `flutter/material.dart` | Inline loading |
| `CircularProgressIndicator` | `flutter/material.dart` | Center loading |
| `SnackBar` | `flutter/material.dart` | Transient feedback |
| `ConsumerWidget` | `flutter_riverpod/flutter_riverpod.dart` | Riverpod widget base |
| `WidgetRef` | `flutter_riverpod/flutter_riverpod.dart` | Riverpod ref |
| `Clipboard` | `flutter/services.dart` | Clipboard access |
| `ClipboardData` | `flutter/services.dart` | Clipboard data wrapper |
