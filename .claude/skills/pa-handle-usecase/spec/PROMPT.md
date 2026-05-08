# Handle UseCase — Execution Workflow

Add a new action method to an existing Notifier that executes a UseCase.

---

## Step 1: Read the Existing Notifier

Read the Notifier file at `NOTIFIER_FILE` to understand:
- The current state type (`AsyncValue<T>`)
- Existing methods and their naming conventions
- Which UseCase providers are already being consumed

---

## Step 2: Confirm UseCase Provider Exists

```bash
grep -n "{{USE_CASE_PROVIDER}}" lib/core/di/providers.dart
```

If the provider does not exist, stop and use `pa-generate-usecase` to create the UseCase and provider first.

---

## Step 3: Select the Correct Variant

Based on `RETURN_BEHAVIOR`:

### Variant A: `replace_state`

The UseCase result becomes the new Notifier state.

```dart
Future<void> {{methodName}}({{params}}) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(
    () => ref.read({{useCaseProvider}}).execute({{paramNames}}),
  );
}
```

Use when: transformer, single item fetch, search, suggest pattern.

---

### Variant B: `append_to_list`

The UseCase returns a new item that is added to the existing list in state.

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

Use when: adding a saved item, adding a bookmark.

---

### Variant C: `invalidate_self`

The UseCase performs a side effect (delete/save/clear), then the Notifier reloads from the repository.

```dart
Future<void> {{methodName}}({{params}}) async {
  await AsyncValue.guard(
    () => ref.read({{useCaseProvider}}).execute({{paramNames}}),
  );
  ref.invalidateSelf();
}
```

Use when: delete, clear, save (then reload fresh from repository).

---

## Step 4: Add Reset Helper (if needed)

If the Notifier needs to be able to clear its state (e.g., after navigation away):

```dart
void reset() => state = const AsyncData(null);
```

Add this only when explicitly required by the feature.

---

## Step 5: Format the Modified File

```bash
dart format lib/features/{{feature}}/presentation/notifiers/{{notifier_file}}.dart
flutter analyze lib/features/{{feature}}/presentation/notifiers/
```

Zero warnings required.

---

## Step 6: Write the Test

Write a unit test that verifies the Notifier's new method transitions correctly through:
1. Loading state (after method is called)
2. Data state (on success)
3. Error state (on failure — repository throws)
