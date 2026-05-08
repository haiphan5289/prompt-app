# Guardrails — pa-repository

## Prohibited in Domain Interface

```dart
// PROHIBITED — infrastructure import in domain
import 'package:hive/hive.dart'; // WRONG

// PROHIBITED — Flutter import in domain
import 'package:flutter/foundation.dart'; // WRONG

// PROHIBITED — abstract class without interface keyword
abstract class HistoryRepository { // WRONG — use abstract interface class
```

## Prohibited in Implementation

```dart
// PROHIBITED — business logic in repository
@override
Future<List<HistoryEntry>> getAll() async {
  final all = await dataSource.fetchAll();
  return all.where((e) => e.createdAt.isAfter(cutoff)).toList(); // WRONG — logic in repo
}

// PROHIBITED — repository calling another repository
@override
Future<void> save(HistoryEntry item) async {
  await dataSource.save(item);
  await patternRepository.markUsed(item.patternId); // WRONG — repos don't call repos
}

// PROHIBITED — ref.read inside repository
// Repositories are not Riverpod consumers — they receive deps via constructor
```

## Prohibited Provider Patterns

```dart
// PROHIBITED — concrete type as return type
@riverpod
HistoryRepositoryImpl historyRepository(HistoryRepositoryRef ref) => // WRONG — use interface type

// PROHIBITED — ref.read for dependency
@riverpod
HistoryRepository historyRepository(HistoryRepositoryRef ref) =>
    HistoryRepositoryImpl(
      dataSource: ref.read(historyLocalDataSourceProvider), // WRONG — use ref.watch
    );
```

## Verification Before Writing

```bash
# Confirm entity exists
find lib/features/{{feature}}/domain/entities -name "{{entity_snake}}.dart"

# Confirm DataSource provider exists
grep -n "{{nameCamel}}LocalDataSourceProvider" lib/core/di/providers.dart

# Check for naming collisions
grep -rn "class {{Name}}Repository" lib/
grep -rn "class {{Name}}RepositoryImpl" lib/
```

Stop if entity doesn't exist or DataSource provider is missing.

## Naming Convention Table

| Template | Example |
|---|---|
| `{{Name}}` | `History` |
| `{{name_snake}}` | `history` |
| `{{nameCamel}}` | `history` |
| `{{Entity}}` | `HistoryEntry` |
| Interface class | `HistoryRepository` |
| Implementation class | `HistoryRepositoryImpl` |
| Provider name | `historyRepositoryProvider` |
