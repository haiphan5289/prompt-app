# Output Schema — Generate UseCase

## Files Created

| File | Description |
|---|---|
| `lib/features/{{feature}}/domain/usecases/{{use_case_snake}}_use_case.dart` | New UseCase class |

## Files Modified

| File | Change |
|---|---|
| `lib/core/di/providers.dart` | New `@riverpod` provider added |
| `lib/features/{{feature}}/presentation/notifiers/{{feature}}_notifier.dart` | New method added |
| `lib/features/{{feature}}/domain/repositories/{{name}}_repository.dart` | Method added (only if it didn't exist) |
| `lib/features/{{feature}}/data/repositories/{{name}}_repository_impl.dart` | Method implemented (only if new) |

## UseCase File Template

```dart
// lib/features/{{feature}}/domain/usecases/{{use_case_snake}}_use_case.dart

class {{UseCaseName}}UseCase {
  const {{UseCaseName}}UseCase({required this.repository});

  final {{Repository}} repository;

  Future<{{ReturnType}}> execute({{params}}) =>
      repository.{{method}}({{paramNames}});
}
```

## Provider Snippet

```dart
// In lib/core/di/providers.dart
@riverpod
{{UseCaseName}}UseCase {{useCaseCamel}}UseCase({{UseCaseName}}UseCaseRef ref) =>
    {{UseCaseName}}UseCase(
      repository: ref.watch({{featureCamel}}RepositoryProvider),
    );
```

## Notifier Method Snippet

One of three variants depending on `RETURN_BEHAVIOR` — see `PROMPT.md` for all variants.

## Generated Test File

```dart
// test/features/{{feature}}/domain/usecases/{{use_case_snake}}_use_case_test.dart

void main() {
  group('{{UseCaseName}}UseCase', () {
    test('happy path: calls repository and returns success', () async { ... });
    test('error path: repository throws, UseCase propagates exception', () async { ... });
  });
}
```
