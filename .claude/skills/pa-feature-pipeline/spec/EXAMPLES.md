# Examples — Feature Pipeline

## Example 1: Add a New Prompt Pattern

```
FEATURE: Add RISEN pattern to the library
SCOPE: domain + data
PATTERN_INVOLVED: yes
ACCEPTANCE_CRITERIA:
  - Pattern appears in the pattern selector
  - Applying it produces a RISEN-structured prompt
  - Example pairs shown in pattern preview screen
```

**Phase 0 plan:**
```
Files to create:
  - (no new files — RISEN added to seed data only)
Files to modify:
  - lib/features/pattern/data/datasources/pattern_local_data_source.dart
Providers needed: none new
Pattern work needed: yes
```

**Phase 1:** Invoke `pa-prompt-pattern-design` → confirm `risen` id is not already in seeds → define template + 3 examples.

**Phase 2:** Add `PromptPattern` seed entry in `PatternLocalDataSource`. No new screen needed.

**Phase 3:** Unit test that the `risen` pattern transforms a raw input correctly.

---

## Example 2: History Screen (Full-Stack)

```
FEATURE: Show a list of past transformations (before/after)
SCOPE: full-stack
PATTERN_INVOLVED: no
ACCEPTANCE_CRITERIA:
  - Each entry shows original prompt + enhanced prompt + pattern name
  - Tapping an entry copies the enhanced prompt
  - List sorted by most recent first
```

**Phase 0 plan:**
```
Files to create:
  - lib/features/history/domain/entities/history_entry.dart
  - lib/features/history/domain/repositories/history_repository.dart
  - lib/features/history/domain/usecases/get_history_use_case.dart
  - lib/features/history/data/repositories/history_repository_impl.dart
  - lib/features/history/data/datasources/history_local_data_source.dart
  - lib/features/history/presentation/notifiers/history_notifier.dart
  - lib/features/history/presentation/screens/history_screen.dart
  - lib/features/history/presentation/widgets/history_entry_tile.dart
Files to modify:
  - lib/core/di/providers.dart
  - lib/core/router/app_router.dart
Providers needed: historyRepositoryProvider, getHistoryUseCaseProvider, historyNotifierProvider
Pattern work needed: no
```

**Phase 1:**
- `HistoryEntry` entity (id, rawPrompt, enhancedPrompt, patternName, createdAt)
- `HistoryRepository` abstract interface (getAll, save, clear)
- `GetHistoryUseCase` skeleton

**Phase 2:**
- `HistoryRepositoryImpl` (Hive storage)
- `historyNotifierProvider` (AsyncNotifier)
- `HistoryScreen` with `ListView.builder`
- `HistoryEntryTile` widget
- Route added to `app_router.dart`

**Phase 3:**
- Widget test for `HistoryScreen` (shows entries, tap copies)
- Unit test for `GetHistoryUseCase` (happy path + empty list)
