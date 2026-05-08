# Examples — pa-module-context

## Example 1: Add UseCase to Transformer

**Input:**
```
FEATURE: transformer
TASK: Add a SuggestPatternUseCase — need to understand existing providers and datasources
```

**Output excerpt:**
```
## Transformer — Key Files for Your Task

For "Add a SuggestPatternUseCase", start by reading:
1. lib/features/transformer/domain/repositories/transformer_repository.dart
   — to understand the data contract you'll need to add a suggestPattern() method to
2. lib/features/transformer/presentation/notifiers/transformer_notifier.dart
   — to understand the existing state shape before wiring the new UseCase
3. lib/core/di/providers.dart
   — to see how existing UseCases are registered

Naming for your new UseCase:
- Class: SuggestPatternUseCase
- File: lib/features/transformer/domain/usecases/suggest_pattern_use_case.dart
- Provider: suggestPatternUseCaseProvider
```

---

## Example 2: Build History Delete Feature

**Input:**
```
FEATURE: history
TASK: Implement delete a single history entry from the list screen
```

**Output excerpt:**
```
## History — Key Files for Your Task

For "Implement delete a single history entry", start by reading:
1. lib/features/history/domain/entities/history_entry.dart — entity shape
2. lib/features/history/domain/repositories/history_repository.dart
   — check if delete(String id) already exists
3. lib/features/history/presentation/notifiers/history_notifier.dart
   — understand current state type (AsyncValue<List<HistoryEntry>>)
4. lib/features/history/presentation/screens/history_screen.dart
   — where you'll add the swipe-to-delete or button

Naming for your UseCase:
- Class: DeleteHistoryEntryUseCase
- File: lib/features/history/domain/usecases/delete_history_entry_use_case.dart
- Notifier method: deleteEntry(String id) — use invalidate_self behavior
```

---

## Example 3: Full Codebase Map (new session)

**Input:**
```
FEATURE: all
TASK: Orientation — first time touching this codebase
```

**Output:** Full feature map for all 3 features with key providers, entities, and naming convention table. No task-specific highlighting.
