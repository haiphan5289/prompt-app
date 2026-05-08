# Generate UseCase — Execution Workflow

Wire a new operation end-to-end: Repository method → UseCase → Provider → Notifier method.

---

## Step 1: Verify Repository Method Exists

```bash
grep -n "<methodName>" lib/features/<feature>/domain/repositories/<name>_repository.dart
```

If the method does **not** exist:
1. Add the method signature to the repository abstract interface
2. Add the method implementation to the `RepositoryImpl` class
3. Then continue to Step 2

---

## Step 2: Generate UseCase Class

Create the file at:
`lib/features/{{feature}}/domain/usecases/{{use_case_snake}}_use_case.dart`

```dart
class {{UseCaseName}}UseCase {
  const {{UseCaseName}}UseCase({required this.repository});

  final {{Repository}} repository;

  Future<{{ReturnType}}> execute({{params}}) =>
      repository.{{method}}({{paramNames}});
}
```

Rules:
- Class name is `{{UseCaseName}}UseCase` (PascalCase + "UseCase" suffix)
- Constructor uses `required` named parameter for the repository
- `execute` is the single public method — no other public methods
- Body is a single expression (`=>`) when possible
- If `REFERENCE_USE_CASE` was provided, follow its exact naming and style conventions

---

## Step 3: Register Riverpod Provider

Add to `lib/core/di/providers.dart`:

```dart
@riverpod
{{UseCaseName}}UseCase {{useCaseCamel}}UseCase({{UseCaseName}}UseCaseRef ref) =>
    {{UseCaseName}}UseCase(
      repository: ref.watch({{featureCamel}}RepositoryProvider),
    );
```

Rules:
- Provider name is `{{useCaseCamel}}UseCaseProvider` (camelCase + "Provider")
- Reads from the feature's repository provider (not datasource provider directly)

---

## Step 4: Add Method to Notifier

In the feature's Notifier at `lib/features/{{feature}}/presentation/notifiers/`, add the appropriate variant:

**Variant A — `replace_state`** (result replaces current state):
```dart
Future<void> {{methodName}}({{params}}) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(
    () => ref.read({{useCaseCamel}}UseCaseProvider).execute({{paramNames}}),
  );
}
```

**Variant B — `invalidate_self`** (reload from repository after action):
```dart
Future<void> {{methodName}}({{params}}) async {
  await AsyncValue.guard(
    () => ref.read({{useCaseCamel}}UseCaseProvider).execute({{paramNames}}),
  );
  ref.invalidateSelf();
}
```

Select the variant based on `RETURN_BEHAVIOR` input (see `pa-handle-usecase` for full variant guide).

---

## Step 5: Wire UI Callsite (if needed)

In the relevant Widget, call via `ref.read`:

```dart
onTap: () => ref
    .read({{featureCamel}}NotifierProvider.notifier)
    .{{methodName}}({{args}});
```

---

## Step 6: Regenerate Code and Verify

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze lib/
flutter test
```

All must pass before closing this task.
