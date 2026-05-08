# Examples — pa-repository

## Example 1: History Repository (read + delete)

**Input:**
```
NAME: History
ENTITY: HistoryEntry
FEATURE: history
OPERATIONS: [getAll, save, delete, clear]
```

**Domain interface** (`lib/features/history/domain/repositories/history_repository.dart`):
```dart
abstract interface class HistoryRepository {
  Future<List<HistoryEntry>> getAll();
  Future<void> save(HistoryEntry item);
  Future<void> delete(String id);
  Future<void> clear();
}
```

**Data implementation** (`lib/features/history/data/repositories/history_repository_impl.dart`):
```dart
class HistoryRepositoryImpl implements HistoryRepository {
  const HistoryRepositoryImpl({required this.dataSource});
  final HistoryLocalDataSource dataSource;

  @override
  Future<List<HistoryEntry>> getAll() => dataSource.fetchAll();

  @override
  Future<void> save(HistoryEntry item) => dataSource.save(item);

  @override
  Future<void> delete(String id) => dataSource.delete(id);

  @override
  Future<void> clear() => dataSource.clear();
}
```

**Provider** (added to `lib/core/di/providers.dart`):
```dart
@riverpod
HistoryRepository historyRepository(HistoryRepositoryRef ref) =>
    HistoryRepositoryImpl(
      dataSource: ref.watch(historyLocalDataSourceProvider),
    );
```

---

## Example 2: Pattern Repository (read-only)

**Input:**
```
NAME: Pattern
ENTITY: PromptPattern
FEATURE: pattern_library
OPERATIONS: [getAll, getById]
```

**Domain interface:**
```dart
abstract interface class PatternRepository {
  Future<List<PromptPattern>> getAll();
  Future<PromptPattern?> getById(String id);
}
```

**Data implementation:**
```dart
class PatternRepositoryImpl implements PatternRepository {
  const PatternRepositoryImpl({required this.dataSource});
  final PatternLocalDataSource dataSource;

  @override
  Future<List<PromptPattern>> getAll() => dataSource.fetchAll();

  @override
  Future<PromptPattern?> getById(String id) => dataSource.fetchById(id);
}
```
