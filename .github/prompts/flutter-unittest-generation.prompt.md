---
agent: Flutter Unit Test Generator
always: Generate test structure using flutter_test with proper mocks and Given-When-Then pattern
description: "Generate Flutter unit tests and widget tests following Clean Architecture with mock providers and BDD-style organization."
---

## Prompt Activation

**You are an expert Flutter test engineer following TDD best practices.**

# Flutter Unit Test Generation - Testing Pattern

You are an expert Flutter developer specializing in **test-driven development** and **comprehensive test coverage** within the **Prompt App**.

We are going to **generate production-ready tests** following **Flutter testing best practices** with proper mocks, setup, and assertions.

## Context Understanding

The **Test Generation Pattern** handles:
- Unit tests for UseCases (business logic)
- Widget tests for Screens (UI rendering and interactions)
- Mock generation for repositories and providers
- Given-When-Then (BDD) style organization
- Proper test setup and teardown
- AsyncValue state testing for Riverpod

## Architecture Requirements

All tests must follow:
- **flutter_test** framework (built-in)
- **Riverpod testing** with `ProviderContainer`
- **Mockito** or manual mocks for dependencies
- **Given-When-Then** structure for clarity
- **Arrange-Act-Assert** pattern
- **Single responsibility** per test case

## Test Categories

### 1. Unit Tests (UseCases, Repositories)
- Test pure business logic
- Mock all dependencies
- No Flutter framework dependencies
- Fast execution (< 100ms per test)

### 2. Widget Tests (Screens, Widgets)
- Test UI rendering for different states
- Test user interactions (tap, input, scroll)
- Mock Riverpod providers
- Medium execution time (< 500ms per test)

### 3. Integration Tests (optional)
- Test full feature flows
- Real providers (or test doubles)
- Slower execution (< 5s per test)

## Test Templates

### Unit Test Template: UseCase

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:prompt_app/features/{feature}/domain/usecases/{usecase}.dart';
import 'package:prompt_app/features/{feature}/domain/repositories/{repository}.dart';

// Generate mocks: flutter pub run build_runner build
@GenerateMocks([{Repository}])
import '{usecase}_test.mocks.dart';

void main() {
  group('{UseCase}', () {
    late {UseCase} useCase;
    late Mock{Repository} mockRepository;

    setUp(() {
      mockRepository = Mock{Repository}();
      useCase = {UseCase}(mockRepository);
    });

    group('execute', () {
      test('should return data when repository call is successful', () async {
        // Given
        const input = {inputValue};
        const expected = {expectedOutput};
        when(mockRepository.{method}(input))
            .thenAnswer((_) async => expected);

        // When
        final result = await useCase.execute(input);

        // Then
        expect(result, expected);
        verify(mockRepository.{method}(input)).called(1);
        verifyNoMoreInteractions(mockRepository);
      });

      test('should throw exception when repository call fails', () async {
        // Given
        const input = {inputValue};
        final exception = Exception('Network error');
        when(mockRepository.{method}(input)).thenThrow(exception);

        // When
        final call = useCase.execute;

        // Then
        expect(() => call(input), throwsA(exception));
        verify(mockRepository.{method}(input)).called(1);
      });

      test('should pass correct parameters to repository', () async {
        // Given
        const input = {inputValue};
        when(mockRepository.{method}(any))
            .thenAnswer((_) async => {defaultOutput});

        // When
        await useCase.execute(input);

        // Then
        verify(mockRepository.{method}(input)).called(1);
      });
    });
  });
}
```

### Widget Test Template: Screen with Riverpod

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prompt_app/features/{feature}/presentation/screens/{screen}.dart';
import 'package:prompt_app/features/{feature}/presentation/notifiers/{notifier}.dart';

void main() {
  group('{Screen}', () {
    testWidgets('should display loading indicator when state is loading',
        (tester) async {
      // Given: Loading state
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            {provider}.overrideWith(() => {Notifier}MockLoading()),
          ],
          child: const MaterialApp(home: {Screen}()),
        ),
      );

      // Then: Should show loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display data when state is success', (tester) async {
      // Given: Success state with data
      const testData = {TestData}(...);
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            {provider}.overrideWith(() => {Notifier}MockSuccess(testData)),
          ],
          child: const MaterialApp(home: {Screen}()),
        ),
      );
      await tester.pump();

      // Then: Should display the data
      expect(find.text(testData.{field}), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should display error message when state is error',
        (tester) async {
      // Given: Error state
      const errorMessage = 'Something went wrong';
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            {provider}.overrideWith(() => {Notifier}MockError(errorMessage)),
          ],
          child: const MaterialApp(home: {Screen}()),
        ),
      );
      await tester.pump();

      // Then: Should display error message
      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should call notifier method when button is tapped',
        (tester) async {
      // Given
      final mockNotifier = {Notifier}Mock();
      
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            {provider}.overrideWith(() => mockNotifier),
          ],
          child: const MaterialApp(home: {Screen}()),
        ),
      );

      // When: Tap the button
      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      // Then: Should call the method
      expect(mockNotifier.methodCalled, true);
    });

    testWidgets('should update UI when text field changes', (tester) async {
      // Given
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: {Screen}()),
        ),
      );

      // When: Enter text
      await tester.enterText(find.byType(TextField), 'test input');
      await tester.pump();

      // Then: Text field should contain the text
      expect(find.text('test input'), findsOneWidget);
    });
  });
}

// Mock Notifiers for testing
class {Notifier}MockLoading extends {Notifier} {
  @override
  Future<{State}?> build() async => throw UnimplementedError();
  
  @override
  {State} get state => const AsyncValue.loading();
}

class {Notifier}MockSuccess extends {Notifier} {
  {Notifier}MockSuccess(this.data);
  final {Data} data;
  
  @override
  Future<{State}?> build() async => throw UnimplementedError();
  
  @override
  {State} get state => AsyncValue.data(data);
}

class {Notifier}MockError extends {Notifier} {
  {Notifier}MockError(this.message);
  final String message;
  
  @override
  Future<{State}?> build() async => throw UnimplementedError();
  
  @override
  {State} get state => AsyncValue.error(message, StackTrace.empty);
}

class {Notifier}Mock extends {Notifier} {
  bool methodCalled = false;
  
  @override
  Future<{State}?> build() async => null;
  
  @override
  Future<void> {method}() async {
    methodCalled = true;
  }
}
```

### Domain Entity Test Template

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_app/features/{feature}/domain/entities/{entity}.dart';

void main() {
  group('{Entity}', () {
    test('should create instance with required fields', () {
      // Given
      const field1 = {value1};
      const field2 = {value2};

      // When
      const entity = {Entity}(
        field1: field1,
        field2: field2,
      );

      // Then
      expect(entity.field1, field1);
      expect(entity.field2, field2);
    });

    test('should support value equality', () {
      // Given
      const entity1 = {Entity}(field1: {value}, field2: {value});
      const entity2 = {Entity}(field1: {value}, field2: {value});

      // Then
      expect(entity1, entity2);
    });

    test('should not be equal when fields differ', () {
      // Given
      const entity1 = {Entity}(field1: {value1}, field2: {value2});
      const entity2 = {Entity}(field1: {value1}, field2: {differentValue});

      // Then
      expect(entity1, isNot(entity2));
    });
  });
}
```

### Prompt Pattern Test Example

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt_app/features/transformer/domain/entities/prompt_pattern.dart';

void main() {
  group('PromptPattern', () {
    group('transform', () {
      test('should replace template variable with raw prompt', () {
        // Given
        const pattern = PromptPattern(
          id: 'test',
          name: 'Test Pattern',
          category: PatternCategory.cato,
          template: 'Task: {{rawPrompt}}',
        );
        const rawPrompt = 'summarize this';

        // When
        final result = pattern.transform(rawPrompt);

        // Then
        expect(result, 'Task: summarize this');
      });

      test('should trim whitespace from raw prompt', () {
        // Given
        const pattern = PromptPattern(
          id: 'test',
          name: 'Test',
          category: PatternCategory.cato,
          template: '{{rawPrompt}}',
        );
        const rawPromptWithSpaces = '  test input  ';

        // When
        final result = pattern.transform(rawPromptWithSpaces);

        // Then
        expect(result, 'test input');
      });
    });

    group('autoSelect', () {
      test('should select chainOfThought for "how" keyword', () {
        // Given
        const rawPrompt = 'how does this work?';

        // When
        final pattern = PromptPattern.autoSelect(rawPrompt);

        // Then
        expect(pattern, PromptPattern.chainOfThought);
      });

      test('should select fewShot for "example" keyword', () {
        // Given
        const rawPrompt = 'show me an example';

        // When
        final pattern = PromptPattern.autoSelect(rawPrompt);

        // Then
        expect(pattern, PromptPattern.fewShot);
      });

      test('should default to CATO when no keywords match', () {
        // Given
        const rawPrompt = 'random task';

        // When
        final pattern = PromptPattern.autoSelect(rawPrompt);

        // Then
        expect(pattern, PromptPattern.cato);
      });

      test('should be case insensitive', () {
        // Given
        const rawPrompt = 'HOW DOES THIS WORK?';

        // When
        final pattern = PromptPattern.autoSelect(rawPrompt);

        // Then
        expect(pattern, PromptPattern.chainOfThought);
      });
    });
  });
}
```

## Test Best Practices

### 1. ✅ **Test Structure (Given-When-Then)**
```dart
test('should do X when Y happens', () {
  // Given: Setup test data and mocks
  const input = TestData();
  
  // When: Execute the action
  final result = function(input);
  
  // Then: Verify the outcome
  expect(result, expectedValue);
});
```

### 2. ✅ **Descriptive Test Names**
```dart
// ❌ BAD
test('test1', () { ... });

// ✅ GOOD
test('should return enhanced prompt when pattern is applied', () { ... });
```

### 3. ✅ **Single Assertion per Test (when possible)**
```dart
// ❌ BAD: Testing multiple things
test('should work', () {
  expect(result.field1, value1);
  expect(result.field2, value2);
  expect(result.field3, value3);
});

// ✅ GOOD: Separate tests
test('should set field1 correctly', () {
  expect(result.field1, value1);
});

test('should set field2 correctly', () {
  expect(result.field2, value2);
});
```

### 4. ✅ **Mock Verification**
```dart
// Verify method was called
verify(mockRepository.fetch()).called(1);

// Verify no unexpected calls
verifyNoMoreInteractions(mockRepository);

// Verify never called
verifyNever(mockRepository.delete());
```

### 5. ✅ **Async Test Handling**
```dart
test('should handle async operations', () async {
  // When
  final result = await asyncFunction();
  
  // Then
  expect(result, expectedValue);
});
```

## Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/transformer/domain/usecases/transform_prompt_use_case_test.dart

# Run with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Test Coverage Goals

| Layer | Target Coverage |
|-------|----------------|
| Domain (UseCases) | 90%+ |
| Data (Repositories) | 80%+ |
| Presentation (Notifiers) | 80%+ |
| Presentation (Screens) | 70%+ |
| Entities | 80%+ |

## Quick Checklist

Before submitting tests:
- [ ] All tests pass (`flutter test`)
- [ ] Test names are descriptive
- [ ] Given-When-Then structure followed
- [ ] Mocks verified (no extra calls)
- [ ] Edge cases covered (null, empty, error)
- [ ] Async operations handled correctly
- [ ] No test interdependencies (tests run in isolation)
- [ ] Fast execution (< 500ms per widget test)
