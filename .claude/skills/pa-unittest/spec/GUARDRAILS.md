# Guardrails — pa-unittest

## Anti-Hallucination Rules

- **Read the source file before writing tests.** Never assume class names, method names, constructor signatures, or dependencies.
- **Do not invent method names.** If you have not read the source file and confirmed a method exists, do not stub it.
- **Do not assume constructor parameters.** Read the `late` fields and `setUp` requirements from the actual source.
- **Verify imports.** Only import packages that are in `pubspec.yaml`. The project uses `mocktail`, not `mockito`.

## Prohibited Patterns

```dart
// PROHIBITED: Using mockito
import 'package:mockito/mockito.dart'; // wrong package

// PROHIBITED: Real Hive box in tests
final box = await Hive.openBox('history'); // opens real storage

// PROHIBITED: Global provider mutation
myProvider.state = ...; // cannot mutate providers globally

// PROHIBITED: ref.watch in test setup (not a build context)
container.read(someProvider.notifier).ref.watch(...); // invalid

// PROHIBITED: Missing tearDown in Notifier tests
// ProviderContainer must be disposed to prevent memory leaks
```

## Correct Mocktail Patterns

```dart
// Correct: stub a method
when(() => mockRepo.getById(any())).thenAnswer((_) async => result);

// Correct: stub a void method
when(() => mockRepo.save(any())).thenAnswer((_) async {});

// Correct: stub a throwing method
when(() => mockRepo.getById(any())).thenThrow(Exception('not found'));

// Correct: verify called
verify(() => mockRepo.save(any())).called(1);

// Correct: verify never called
verifyNever(() => mockRepo.save(any()));
```

## Correct ProviderScope for Widget Tests

```dart
// Correct: override at widget test scope
await tester.pumpWidget(
  ProviderScope(
    overrides: [
      myProvider.overrideWith(() => MockNotifier()),
    ],
    child: const MaterialApp(home: MyScreen()),
  ),
);

// WRONG: ProviderContainer in widget test body (use ProviderScope instead)
final container = ProviderContainer(); // don't do this in widget tests
```

## Naming Conventions

- Mock class name: `Mock` + interface name (PascalCase), e.g. `MockPatternRepository`
- Test file: `<source_name_snake>_test.dart`
- Test group: class name exactly as in source
- Test description: plain English behavior statement, e.g. `'returns result when repository succeeds'`
