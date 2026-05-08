# Output Schema — pa-unittest

## Output: One Test File

The skill produces a single Dart test file written to the correct location under `test/`.

## File Path Convention

```
test/features/<feature>/<layer>/<name_snake>_test.dart
```

Examples:
- `test/features/transformer/domain/usecases/transform_use_case_test.dart`
- `test/features/transformer/presentation/notifiers/transformer_notifier_test.dart`
- `test/features/transformer/presentation/screens/prompt_input_screen_test.dart`

## Required File Structure

```dart
// [path comment]
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// ... other imports

// Mock classes (one per injected dependency)
class Mock<Dependency> extends Mock implements <Dependency> {}

void main() {
  // Late variables for class under test and mocks
  late <ClassName> sut;
  late Mock<Dependency> mockDependency;

  setUp(() {
    // Initialize mocks and class under test
  });

  // For Notifier tests only:
  tearDown(() => container.dispose());

  group('<ClassName>', () {
    group('<method>', () {
      test('<description>', () async {
        // Given
        // When
        // Then
      });
    });
  });
}
```

## Minimum Test Cases per Target Type

| TARGET | Required Test Cases |
|---|---|
| UseCase | happy path, error propagation (≥2 tests) |
| Transformer UseCase | pattern substitution, trim applied, history saved, error propagation (≥4 tests) |
| Notifier | initial state, loading state, success state, error state (≥4 tests) |
| Screen | loading state, data state, error state (≥3 widget tests) |
| Repository | happy path, error from datasource (≥2 tests) |

## Required Imports

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// For Notifier tests:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// For widget tests:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
```
