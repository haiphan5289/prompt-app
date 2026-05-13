---
agent: Add UseCase execution method to existing Notifier
always: Follow Clean Architecture + Riverpod, proper AsyncValue.guard, loading state, error propagation
description: "Add a UseCase execution method to an existing Notifier in Prompt App with proper AsyncValue.guard, loading state, and error handling."
---

## Prompt Activation

**You are an expert Flutter developer following the Handle UseCase Pattern.**

# Flutter Handle UseCase - Add Execution Method to Notifier

You are an expert Flutter developer specializing in **Riverpod state management** and **Clean Architecture** within the **Prompt App**.

We are going to **add UseCase execution methods to existing Notifiers** following **AsyncNotifier + AsyncValue.guard** patterns with proper error handling and loading states.

## Context Understanding

The **Handle UseCase Pattern** handles:
- Adding new UseCase execution methods to existing Notifiers
- Proper AsyncValue.guard for error handling
- Loading state management during async operations
- Error propagation to UI layer
- Memory safety with proper state updates

## Architecture Requirements

All implementations must follow:
- **Clean Architecture** (Domain → Data → Presentation layers)
- **Riverpod 2** AsyncNotifier patterns
- **AsyncValue.guard** for automatic error handling
- **Loading state** management with AsyncValue.loading
- **Proper provider dependencies** via ref.read()

## Required Parameters

When generating a Notifier UseCase execution method, you need:

- `{NOTIFIER_CLASS}`: The Notifier class name (e.g., TransformerNotifier, HistoryNotifier)
- `{USECASE_NAME}`: The UseCase class name (e.g., TransformPromptUseCase, GetHistoryUseCase)
- `{INPUT_PARAM}`: The input parameter type (e.g., String, HistoryQuery)
- `{RETURN_TYPE}`: The return type from UseCase (e.g., TransformResult, List<HistoryItem>)
- `{PROVIDER_NAME}`: The UseCase provider name (e.g., transformPromptUseCaseProvider)

## Add Notifier UseCase Execution Method

Add the following UseCase execution method to {NOTIFIER_CLASS} file:

```dart
// ⚠️ ADD THIS METHOD TO EXISTING {NOTIFIER_CLASS} CLASS ⚠️
class {NOTIFIER_CLASS} extends AsyncNotifier<{State}> {
  // ... existing build() method ...

  /// Executes [{USECASE_NAME}] with the provided input.
  /// 
  /// Sets loading state, executes the UseCase via AsyncValue.guard,
  /// and updates state with result or error.
  Future<void> execute{MethodName}({InputParams}) async {
    // 🔒 MANDATORY: Set loading state
    state = const AsyncValue.loading();
    
    // 🔍 Get UseCase from provider
    final useCase = ref.read({PROVIDER_NAME});
    
    // 🔒 MANDATORY: Use AsyncValue.guard for automatic error handling
    state = await AsyncValue.guard(() async {
      // Execute UseCase and return result
      final result = await useCase.execute({params});
      
      // 🔒 MANDATORY: Transform result if needed
      // Example: Update existing state with new data
      // return state.value?.copyWith(newField: result) ?? {State}(newField: result);
      
      // Or return directly if result is the state type:
      return result;
    });
  }
}
```

## Complete Example: TransformerNotifier

```dart
// lib/features/transformer/presentation/notifiers/transformer_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/transformer_providers.dart';
import '../../domain/entities/transform_result.dart';

/// Notifier for transformer state management.
class TransformerNotifier extends AsyncNotifier<TransformResult?> {
  @override
  Future<TransformResult?> build() async {
    return null; // Initial state
  }

  /// Executes prompt transformation with the selected pattern.
  Future<void> executeTransform({
    required String rawPrompt,
    required String patternName,
  }) async {
    // Set loading state
    state = const AsyncValue.loading();
    
    // Get UseCase from provider
    final useCase = ref.read(transformPromptUseCaseProvider);
    
    // Execute with AsyncValue.guard for automatic error handling
    state = await AsyncValue.guard(() async {
      return await useCase.execute(
        rawPrompt: rawPrompt,
        patternName: patternName,
      );
    });
  }

  /// Clears the transformation result.
  void clear() {
    state = const AsyncValue.data(null);
  }
}

/// Provider for TransformerNotifier.
final transformerProvider =
    AsyncNotifierProvider<TransformerNotifier, TransformResult?>(
  TransformerNotifier.new,
);
```

## Architecture Compliance

This Notifier UseCase execution implementation follows Clean Architecture by:
- Creating UseCase dependency through provider injection via ref.read()
- Using AsyncValue.guard for automatic error handling and state updates
- Proper loading state management with AsyncValue.loading
- Separation of concerns between Notifier and UseCase layers
- Type-safe state updates with AsyncValue<T>

## Important Implementation Rules

### ❌ DO NOT DO THESE:
1. **NEVER call repository directly from Notifier** - always go through UseCase
2. **NEVER catch errors manually** - let AsyncValue.guard handle it
3. **NEVER update state without AsyncValue** - always wrap in AsyncValue
4. **NEVER use setState or notifyListeners** - Riverpod handles it automatically
5. **NEVER forget to set loading state** before async operations

### ✅ CORRECT PATTERNS:

#### **Pattern 1: Simple transformation**
```dart
Future<void> executeGetHistory() async {
  state = const AsyncValue.loading();
  
  final useCase = ref.read(getHistoryUseCaseProvider);
  
  state = await AsyncValue.guard(() async {
    return await useCase.execute();
  });
}
```

#### **Pattern 2: With parameters**
```dart
Future<void> executeSavePattern({
  required String patternId,
  required String content,
}) async {
  state = const AsyncValue.loading();
  
  final useCase = ref.read(savePatternUseCaseProvider);
  
  state = await AsyncValue.guard(() async {
    await useCase.execute(
      patternId: patternId,
      content: content,
    );
    
    // Return updated state
    return state.value?.copyWith(isSaved: true);
  });
}
```

#### **Pattern 3: Updating existing state**
```dart
Future<void> executeAddToFavorites(String patternId) async {
  state = const AsyncValue.loading();
  
  final useCase = ref.read(addToFavoritesUseCaseProvider);
  
  state = await AsyncValue.guard(() async {
    await useCase.execute(patternId);
    
    // Update existing state by adding to favorites list
    final currentState = state.value;
    if (currentState == null) return null;
    
    return currentState.copyWith(
      favoriteIds: [...currentState.favoriteIds, patternId],
    );
  });
}
```

#### **Pattern 4: Multiple UseCase calls (sequential)**
```dart
Future<void> executeTransformAndSave({
  required String rawPrompt,
  required String patternName,
}) async {
  state = const AsyncValue.loading();
  
  final transformUseCase = ref.read(transformPromptUseCaseProvider);
  final saveUseCase = ref.read(saveHistoryUseCaseProvider);
  
  state = await AsyncValue.guard(() async {
    // Execute transformation
    final result = await transformUseCase.execute(
      rawPrompt: rawPrompt,
      patternName: patternName,
    );
    
    // Save to history
    await saveUseCase.execute(result);
    
    return result;
  });
}
```

## Error Handling

AsyncValue.guard automatically catches errors and wraps them in AsyncValue.error:

```dart
// In UI layer:
state.when(
  data: (data) => Text('Success: $data'),
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => Text('Error: $error'),
)
```

No need for try-catch in Notifier - AsyncValue.guard handles it!

## Testing Pattern

```dart
void main() {
  test('executeTransform sets loading then data', () async {
    // Arrange
    final container = ProviderContainer(
      overrides: [
        transformPromptUseCaseProvider.overrideWithValue(mockUseCase),
      ],
    );
    final notifier = container.read(transformerProvider.notifier);
    
    when(() => mockUseCase.execute(any())).thenAnswer(
      (_) async => TransformResult(enhancedPrompt: 'result'),
    );
    
    // Act
    final future = notifier.executeTransform(
      rawPrompt: 'test',
      patternName: 'pattern',
    );
    
    // Assert - loading state
    expect(
      container.read(transformerProvider),
      const AsyncValue<TransformResult>.loading(),
    );
    
    await future;
    
    // Assert - data state
    expect(
      container.read(transformerProvider).value?.enhancedPrompt,
      'result',
    );
  });
}
```

---

**Use this pattern when:**
- Adding new UseCase execution to existing Notifier
- Need proper loading/error state management
- Want automatic error handling with AsyncValue.guard
- Following Clean Architecture with Riverpod
- Building features in Prompt App

**Key Benefits:**
- ✅ Automatic error handling - no try-catch needed
- ✅ Type-safe state management with AsyncValue
- ✅ Clean separation of concerns
- ✅ Testable with Riverpod mocking
- ✅ Consistent pattern across all Notifiers
