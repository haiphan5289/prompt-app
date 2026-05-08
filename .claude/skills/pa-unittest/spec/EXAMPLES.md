# Examples — pa-unittest

## Template 1: UseCase Unit Test

```dart
// test/features/{{feature}}/domain/usecases/{{name_snake}}_use_case_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class Mock{{Repository}} extends Mock implements {{Repository}} {}

void main() {
  late {{Name}}UseCase useCase;
  late Mock{{Repository}} mockRepository;

  setUp(() {
    mockRepository = Mock{{Repository}}();
    useCase = {{Name}}UseCase(repository: mockRepository);
  });

  group('{{Name}}UseCase', () {
    group('execute', () {
      test('returns result when repository succeeds', () async {
        // Given
        final expected = {{ResultFactory.create()}};
        when(() => mockRepository.{{method}}(any()))
            .thenAnswer((_) async => expected);

        // When
        final result = await useCase.execute(/* params */);

        // Then
        expect(result, equals(expected));
        verify(() => mockRepository.{{method}}(any())).called(1);
      });

      test('propagates exception when repository throws', () async {
        // Given
        when(() => mockRepository.{{method}}(any()))
            .thenThrow(Exception('Storage error'));

        // When / Then
        expect(
          () => useCase.execute(/* params */),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
```

---

## Template 2: Transformer UseCase Test (domain-specific)

```dart
// test/features/transformer/domain/usecases/transform_use_case_test.dart
void main() {
  late TransformUseCase useCase;
  late MockPatternRepository mockPatternRepo;
  late MockHistoryRepository mockHistoryRepo;

  setUp(() {
    mockPatternRepo = MockPatternRepository();
    mockHistoryRepo = MockHistoryRepository();
    useCase = TransformUseCase(
      patternRepository: mockPatternRepo,
      historyRepository: mockHistoryRepo,
    );
  });

  group('TransformUseCase.execute', () {
    test('applies pattern template to raw prompt', () async {
      // Given
      const rawPrompt = 'explain recursion';
      const pattern = PromptPattern(
        id: 'role_expert',
        name: 'Expert Role',
        category: 'role_based',
        description: 'Assign expert role',
        template: 'You are an expert. {{userInput}}',
        useCases: [],
        examples: [],
      );
      when(() => mockPatternRepo.getById('role_expert'))
          .thenAnswer((_) async => pattern);
      when(() => mockHistoryRepo.save(any())).thenAnswer((_) async {});

      // When
      final result = await useCase.execute('explain recursion', 'role_expert');

      // Then
      expect(result.enhancedPrompt, contains('You are an expert.'));
      expect(result.enhancedPrompt, contains('explain recursion'));
      expect(result.originalPrompt, equals(rawPrompt));
      expect(result.appliedPattern.id, equals('role_expert'));
    });

    test('trims whitespace from raw prompt before injection', () async {
      // Given
      when(() => mockPatternRepo.getById(any()))
          .thenAnswer((_) async => _testPattern);
      when(() => mockHistoryRepo.save(any())).thenAnswer((_) async {});

      // When
      final result = await useCase.execute('  explain recursion  ', 'role_expert');

      // Then
      expect(result.originalPrompt, equals('  explain recursion  '));
      expect(result.enhancedPrompt, isNot(contains('  explain'))); // trimmed
    });

    test('saves result to history after transformation', () async {
      // Given
      when(() => mockPatternRepo.getById(any()))
          .thenAnswer((_) async => _testPattern);
      when(() => mockHistoryRepo.save(any())).thenAnswer((_) async {});

      // When
      await useCase.execute('test prompt', 'role_expert');

      // Then
      verify(() => mockHistoryRepo.save(any())).called(1);
    });

    test('propagates exception when pattern not found', () async {
      // Given
      when(() => mockPatternRepo.getById(any()))
          .thenThrow(Exception('Pattern not found'));

      // When / Then
      expect(
        () => useCase.execute('test', 'nonexistent_id'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
```

---

## Template 3: Notifier Test (Riverpod)

```dart
// test/features/{{feature}}/presentation/notifiers/{{name_snake}}_notifier_test.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late ProviderContainer container;
  late Mock{{UseCase}} mockUseCase;

  setUp(() {
    mockUseCase = Mock{{UseCase}}();
    container = ProviderContainer(
      overrides: [
        {{useCaseProvider}}.overrideWithValue(mockUseCase),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('{{Name}}Notifier', () {
    test('initial state is AsyncData(null)', () {
      // Given / When
      final state = container.read({{name}}NotifierProvider);

      // Then
      expect(state, equals(const AsyncData(null)));
    });

    test('state is AsyncLoading during execute', () async {
      // Given
      when(() => mockUseCase.execute(any()))
          .thenAnswer((_) => Future.delayed(const Duration(seconds: 1)));

      // When
      container.read({{name}}NotifierProvider.notifier).execute('input');

      // Then
      expect(
        container.read({{name}}NotifierProvider),
        isA<AsyncLoading>(),
      );
    });

    test('state is AsyncData with result on success', () async {
      // Given
      final expected = {{ResultFactory.create()}};
      when(() => mockUseCase.execute(any()))
          .thenAnswer((_) async => expected);

      // When
      await container.read({{name}}NotifierProvider.notifier).execute('input');

      // Then
      expect(
        container.read({{name}}NotifierProvider).value,
        equals(expected),
      );
    });

    test('state is AsyncError on failure', () async {
      // Given
      when(() => mockUseCase.execute(any()))
          .thenThrow(Exception('Network error'));

      // When
      await container.read({{name}}NotifierProvider.notifier).execute('input');

      // Then
      expect(
        container.read({{name}}NotifierProvider),
        isA<AsyncError>(),
      );
    });
  });
}
```

---

## Template 4: Widget Test

```dart
// test/features/{{feature}}/presentation/screens/{{name_snake}}_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows loading indicator while transforming', (tester) async {
    // Given / When
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transformerNotifierProvider.overrideWith(
            () => _LoadingTransformerNotifier(),
          ),
        ],
        child: const MaterialApp(home: PromptInputScreen()),
      ),
    );

    // Then
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows enhanced prompt on success', (tester) async {
    // Given
    const enhanced = 'You are an expert. Test prompt.';

    // When
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transformerNotifierProvider.overrideWith(
            () => _SuccessTransformerNotifier(enhanced),
          ),
        ],
        child: const MaterialApp(home: PromptInputScreen()),
      ),
    );
    await tester.pump();

    // Then
    expect(find.text(enhanced), findsOneWidget);
  });

  testWidgets('shows error banner on failure', (tester) async {
    // Given / When
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transformerNotifierProvider.overrideWith(
            () => _ErrorTransformerNotifier(),
          ),
        ],
        child: const MaterialApp(home: PromptInputScreen()),
      ),
    );
    await tester.pump();

    // Then
    expect(find.byType(ErrorBanner), findsOneWidget);
  });
}
```
