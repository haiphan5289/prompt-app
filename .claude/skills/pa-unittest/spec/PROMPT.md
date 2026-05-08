# Execution Workflow — pa-unittest

## Step 1: Read the Target Class

Read the actual source file of the class being tested. Never assume method signatures, constructor parameters, or dependencies.

```bash
# Locate the source file
find lib/features/<FEATURE>/ -name "<name_snake>*.dart"
```

Read the file in full. Note:
- Constructor parameters and required dependencies
- Public method names and their signatures
- Return types (especially `Future<T>` vs `T`)
- Which repository/usecase interfaces are injected

## Step 2: Determine Test Type

| TARGET Value | Test Type | Output Location |
|---|---|---|
| `UseCase` | Unit test | `test/features/<feature>/domain/usecases/<name_snake>_test.dart` |
| `Notifier` | Riverpod container test | `test/features/<feature>/presentation/notifiers/<name_snake>_test.dart` |
| `Repository` | Unit test with fake datasource | `test/features/<feature>/data/repositories/<name_snake>_test.dart` |
| `Screen` or `Widget` | Widget test | `test/features/<feature>/presentation/screens/<name_snake>_test.dart` |

## Step 3: Generate Mock Classes

For each dependency injected into the class under test, create a `Mock` class:

```dart
class Mock<DependencyName> extends Mock implements <DependencyName> {}
```

Use `mocktail` — never `mockito`.

## Step 4: Write Test File

Use the appropriate template from [EXAMPLES.md](EXAMPLES.md):

- **UseCase template** — covers happy path + error propagation
- **Transformer UseCase template** — covers pattern substitution, trim, history save
- **Notifier template** — covers initial state, loading state, success state, error state
- **Widget template** — covers loading state, data state, error state

Structure every test case with:
```
// Given  — set up mocks and preconditions
// When   — call the method under test
// Then   — assert expected outcome
```

## Step 5: Verify Generated Tests

Before writing the file:
1. Confirm all imported class names match what was read from source
2. Confirm all mock method stubs use actual method names from the interface
3. Confirm the test file path mirrors the source file path under `test/`
4. Confirm `mocktail` is in `dev_dependencies` (check `pubspec.yaml` if unsure)

## Step 6: Write the Test File

Write the complete test file to the correct location.
