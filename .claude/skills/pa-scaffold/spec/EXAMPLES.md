# Examples — Scaffold

## Example 1: Screen

**Input:**
```
FILE_TYPE: Screen
NAME: PatternSelector
FEATURE: transformer
```

**Output file:** `lib/features/transformer/presentation/screens/pattern_selector_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatternSelectorScreen extends ConsumerWidget {
  const PatternSelectorScreen({super.key});

  static const routePath = '/pattern-selector';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: watch provider
    return Scaffold(
      appBar: AppBar(title: const Text('PatternSelector')),
      body: const _PatternSelectorBody(),
    );
  }
}

class _PatternSelectorBody extends ConsumerWidget {
  const _PatternSelectorBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement body
    return const SizedBox.shrink();
  }
}
```

**Also added to** `lib/core/router/app_router.dart`:
```dart
GoRoute(
  path: PatternSelectorScreen.routePath,
  builder: (_, __) => const PatternSelectorScreen(),
),
```

---

## Example 2: AsyncNotifier

**Input:**
```
FILE_TYPE: Notifier
NAME: Transformer
FEATURE: transformer
STATE_TYPE: TransformResult
```

**Output file:** `lib/features/transformer/presentation/notifiers/transformer_notifier.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transformer_notifier.g.dart';

@riverpod
class TransformerNotifier extends _$TransformerNotifier {
  @override
  FutureOr<TransformResult?> build() => null;

  Future<void> execute(/* params */) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(/* useCase provider */).execute(/* params */),
    );
  }

  void reset() => state = const AsyncData(null);
}
```

---

## Example 3: Entity

**Input:**
```
FILE_TYPE: Entity
NAME: Bookmark
FEATURE: transformer
```

**Output file:** `lib/features/transformer/domain/entities/bookmark.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';

@freezed
class Bookmark with _$Bookmark {
  const factory Bookmark({
    required String id,
    // TODO: add fields
    required DateTime createdAt,
  }) = _Bookmark;
}
```
