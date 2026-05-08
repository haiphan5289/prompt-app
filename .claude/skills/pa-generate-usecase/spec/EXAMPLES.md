# Examples — Generate UseCase

## Common UseCase Patterns for Prompt App

| Operation | Method signature | Notifier variant |
|---|---|---|
| Load list | `Future<List<T>> execute()` | `replace_state` |
| Save item | `Future<void> execute(T item)` | `invalidate_self` |
| Delete item | `Future<void> execute(String id)` | `invalidate_self` |
| Transform prompt | `Future<TransformResult> execute(String raw, String patternId)` | `replace_state` |
| Suggest pattern | `Future<PromptPattern?> execute(String rawPrompt)` | `replace_state` |
| Clear history | `Future<void> execute()` | `invalidate_self` |

---

## Example 1: Delete History Entry

```
USE_CASE_NAME: DeleteHistory
FEATURE: history
REPOSITORY: HistoryRepository
METHOD:
  name: delete
  params: [{name: id, type: String}]
  returns: Future<void>
```

**Generated UseCase:**
```dart
// lib/features/history/domain/usecases/delete_history_use_case.dart

class DeleteHistoryUseCase {
  const DeleteHistoryUseCase({required this.repository});

  final HistoryRepository repository;

  Future<void> execute(String id) => repository.delete(id);
}
```

**Generated Provider (added to providers.dart):**
```dart
@riverpod
DeleteHistoryUseCase deleteHistoryUseCase(DeleteHistoryUseCaseRef ref) =>
    DeleteHistoryUseCase(
      repository: ref.watch(historyRepositoryProvider),
    );
```

**Generated Notifier Method (invalidate_self — delete then reload):**
```dart
Future<void> delete(String id) async {
  await AsyncValue.guard(
    () => ref.read(deleteHistoryUseCaseProvider).execute(id),
  );
  ref.invalidateSelf();
}
```

---

## Example 2: Suggest Pattern

```
USE_CASE_NAME: SuggestPattern
FEATURE: transformer
REPOSITORY: PatternRepository
METHOD:
  name: suggestForPrompt
  params: [{name: rawPrompt, type: String}]
  returns: Future<PromptPattern?>
```

**Generated UseCase:**
```dart
// lib/features/transformer/domain/usecases/suggest_pattern_use_case.dart

class SuggestPatternUseCase {
  const SuggestPatternUseCase({required this.repository});

  final PatternRepository repository;

  Future<PromptPattern?> execute(String rawPrompt) =>
      repository.suggestForPrompt(rawPrompt);
}
```

**Generated Provider:**
```dart
@riverpod
SuggestPatternUseCase suggestPatternUseCase(SuggestPatternUseCaseRef ref) =>
    SuggestPatternUseCase(
      repository: ref.watch(patternRepositoryProvider),
    );
```

**Generated Notifier Method (replace_state — result becomes new state):**
```dart
Future<void> suggestPattern(String rawPrompt) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(
    () => ref.read(suggestPatternUseCaseProvider).execute(rawPrompt),
  );
}
```
