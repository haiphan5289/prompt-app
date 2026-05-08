# Output Schema — Handle UseCase

## Modified File

| File | Change |
|---|---|
| `NOTIFIER_FILE` | New method added to existing Notifier |

## Generated Method Shape

The generated method is inserted into the existing Notifier class body, following any existing methods.

### Variant A — `replace_state`
```dart
Future<void> {{methodName}}({{params}}) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(
    () => ref.read({{useCaseProvider}}).execute({{paramNames}}),
  );
}
```

### Variant B — `append_to_list`
```dart
Future<void> {{methodName}}({{params}}) async {
  final current = state.valueOrNull ?? [];
  state = const AsyncLoading();
  state = await AsyncValue.guard(() async {
    final newItem = await ref.read({{useCaseProvider}}).execute({{paramNames}});
    return [...current, newItem];
  });
}
```

### Variant C — `invalidate_self`
```dart
Future<void> {{methodName}}({{params}}) async {
  await AsyncValue.guard(
    () => ref.read({{useCaseProvider}}).execute({{paramNames}}),
  );
  ref.invalidateSelf();
}
```

### Optional Reset Helper
```dart
void reset() => state = const AsyncData(null);
```
Only added when explicitly requested.

## State Transition Guarantee

Every generated method must transition through:
1. `AsyncLoading()` — before any async work
2. `AsyncData(value)` — on success
3. `AsyncError(e, st)` — on failure (via `AsyncValue.guard`)
