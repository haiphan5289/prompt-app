# Guardrails — Handle UseCase

## Hard Rules

### Never use ref.watch in callbacks
```dart
// PROHIBITED
Future<void> transform(String prompt) async {
  final useCase = ref.watch(transformPromptUseCaseProvider); // WRONG
}

// CORRECT
Future<void> transform(String prompt) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(
    () => ref.read(transformPromptUseCaseProvider).execute(prompt),
  );
}
```

### Never skip AsyncValue.guard
```dart
// PROHIBITED — swallows errors silently
Future<void> transform(String prompt) async {
  state = const AsyncLoading();
  try {
    final result = await ref.read(transformPromptUseCaseProvider).execute(prompt);
    state = AsyncData(result);
  } catch (e, st) {
    state = AsyncError(e, st);
  }
}

// CORRECT
Future<void> transform(String prompt) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(
    () => ref.read(transformPromptUseCaseProvider).execute(prompt),
  );
}
```

### Never add business logic to Notifier methods
```dart
// PROHIBITED — logic belongs in UseCase
Future<void> transform(String prompt) async {
  if (prompt.trim().isEmpty) return; // WRONG — belongs in UseCase
  final enhanced = prompt + ' be detailed'; // WRONG — belongs in UseCase
  state = const AsyncLoading();
  state = await AsyncValue.guard(
    () => ref.read(transformPromptUseCaseProvider).execute(enhanced),
  );
}
```

### Never capture stale state for append_to_list inside the guard
```dart
// PROHIBITED
Future<void> saveEntry(HistoryEntry entry) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(() async {
    final current = state.valueOrNull ?? []; // WRONG — state is now AsyncLoading
    final newItem = await ref.read(saveHistoryEntryUseCaseProvider).execute(entry);
    return [...current, newItem];
  });
}

// CORRECT — capture before setting loading
Future<void> saveEntry(HistoryEntry entry) async {
  final current = state.valueOrNull ?? []; // Capture here
  state = const AsyncLoading();
  state = await AsyncValue.guard(() async {
    final newItem = await ref.read(saveHistoryEntryUseCaseProvider).execute(entry);
    return [...current, newItem];
  });
}
```

## Verification Before Writing

```bash
# Confirm UseCase provider exists
grep -n "{{USE_CASE_PROVIDER}}" lib/core/di/providers.dart

# Confirm Notifier file path
ls {{NOTIFIER_FILE}}

# Confirm no duplicate method name
grep -n "{{METHOD_NAME}}" {{NOTIFIER_FILE}}
```

Stop if any verification fails. Do not guess or create missing providers inline.

## Prohibited Patterns Summary

| Pattern | Why |
|---|---|
| `ref.watch` in method | Causes rebuild loops; use `ref.read` |
| Manual try/catch | Use `AsyncValue.guard` instead |
| Business logic in Notifier | Belongs in UseCase, not presentation |
| Capturing state inside `AsyncValue.guard` after setting `AsyncLoading` | Returns stale/null value |
| Creating new providers inline | Use `pa-generate-usecase` first |
