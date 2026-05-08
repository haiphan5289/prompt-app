# Examples — Handle UseCase

## Example 1: Transform Prompt (replace_state)

**Input:**
```
NOTIFIER: TransformerNotifier
NOTIFIER_FILE: lib/features/transformer/presentation/notifiers/transformer_notifier.dart
USE_CASE: TransformPromptUseCase
USE_CASE_PROVIDER: transformPromptUseCaseProvider
METHOD_NAME: transform
PARAMS: [{name: rawPrompt, type: String}, {name: patternId, type: String}]
RETURN_BEHAVIOR: replace_state
```

**Generated method:**
```dart
Future<void> transform(String rawPrompt, String patternId) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(
    () => ref.read(transformPromptUseCaseProvider).execute(rawPrompt, patternId),
  );
}
```

---

## Example 2: Save to History (append_to_list)

**Input:**
```
NOTIFIER: HistoryNotifier
NOTIFIER_FILE: lib/features/history/presentation/notifiers/history_notifier.dart
USE_CASE: SaveHistoryEntryUseCase
USE_CASE_PROVIDER: saveHistoryEntryUseCaseProvider
METHOD_NAME: saveEntry
PARAMS: [{name: entry, type: HistoryEntry}]
RETURN_BEHAVIOR: append_to_list
```

**Generated method:**
```dart
Future<void> saveEntry(HistoryEntry entry) async {
  final current = state.valueOrNull ?? [];
  state = const AsyncLoading();
  state = await AsyncValue.guard(() async {
    final newItem = await ref.read(saveHistoryEntryUseCaseProvider).execute(entry);
    return [...current, newItem];
  });
}
```

---

## Example 3: Delete History Entry (invalidate_self)

**Input:**
```
NOTIFIER: HistoryNotifier
NOTIFIER_FILE: lib/features/history/presentation/notifiers/history_notifier.dart
USE_CASE: DeleteHistoryEntryUseCase
USE_CASE_PROVIDER: deleteHistoryEntryUseCaseProvider
METHOD_NAME: deleteEntry
PARAMS: [{name: id, type: String}]
RETURN_BEHAVIOR: invalidate_self
```

**Generated method:**
```dart
Future<void> deleteEntry(String id) async {
  await AsyncValue.guard(
    () => ref.read(deleteHistoryEntryUseCaseProvider).execute(id),
  );
  ref.invalidateSelf();
}
```

---

## Example 4: Suggest Pattern (replace_state, no params)

**Input:**
```
NOTIFIER: PatternSuggestionNotifier
NOTIFIER_FILE: lib/features/transformer/presentation/notifiers/pattern_suggestion_notifier.dart
USE_CASE: SuggestPatternUseCase
USE_CASE_PROVIDER: suggestPatternUseCaseProvider
METHOD_NAME: suggest
PARAMS: [{name: rawPrompt, type: String}]
RETURN_BEHAVIOR: replace_state
```

**Generated method:**
```dart
Future<void> suggest(String rawPrompt) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(
    () => ref.read(suggestPatternUseCaseProvider).execute(rawPrompt),
  );
}
```
