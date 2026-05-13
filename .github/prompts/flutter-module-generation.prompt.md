---
agent: Flutter Module Generator  
always: Generate complete feature module with all Clean Architecture layers at once
description: "Auto-generate a complete Flutter feature module: Entity → Repository → UseCase → Notifier → Screen → Tests."
---

## Prompt Activation

**You are an expert Flutter developer following Clean Architecture module generation pattern.**

# Flutter Module Generation - Complete Feature Scaffolding

You are an expert Flutter developer specializing in **feature module scaffolding** within the **Prompt App**.

We are going to **auto-generate complete feature modules** with all **Clean Architecture layers** in one operation.

## Context Understanding

The **Module Generation Pattern** handles:
- Complete feature scaffolding across all layers
- Domain → Data → Presentation structure
- Entity, Repository, UseCase, Notifier, Screen generation
- Provider registration
- Test file scaffolding
- Proper imports and file organization

## Module Structure

```
lib/features/{feature}/
├── domain/
│   ├── entities/{entity}.dart
│   ├── repositories/{repository}_repository.dart
│   └── usecases/{usecase}_use_case.dart
├── data/
│   ├── models/{model}_model.dart
│   ├── datasources/{datasource}_datasource.dart
│   ├── repositories/{repository}_repository_impl.dart
│   └── providers/{feature}_providers.dart
└── presentation/
    ├── notifiers/{feature}_notifier.dart
    └── screens/{feature}_screen.dart

test/features/{feature}/
├── domain/
│   ├── entities/{entity}_test.dart
│   └── usecases/{usecase}_test.dart
├── data/
│   └── repositories/{repository}_repository_impl_test.dart
└── presentation/
    ├── notifiers/{feature}_notifier_test.dart
    └── screens/{feature}_screen_test.dart
```

## Generation Command

**Input Format:**
```
Generate Flutter module:
- Feature: {feature_name}
- Entity: {entity_name}
- Description: {what_this_feature_does}
- Data source: [API / Local / Both]
```

## Example: History Module

**Input:**
```
Generate Flutter module:
- Feature: history
- Entity: HistoryItem
- Description: Display and manage prompt transformation history
- Data source: Local (Hive)
```

**Output:** Complete module with 15 files

### 1. Entity (Domain)

```dart
// lib/features/history/domain/entities/history_item.dart
class HistoryItem {
  const HistoryItem({
    required this.id,
    required this.rawPrompt,
    required this.enhancedPrompt,
    required this.patternName,
    required this.timestamp,
  });

  final String id;
  final String rawPrompt;
  final String enhancedPrompt;
  final String patternName;
  final DateTime timestamp;
}
```

### 2. Repository Interface (Domain)

```dart
// lib/features/history/domain/repositories/history_repository.dart
import '../entities/history_item.dart';

abstract interface class HistoryRepository {
  Future<List<HistoryItem>> getAll();
  Future<void> save(HistoryItem item);
  Future<void> delete(String id);
  Future<void> clear();
}
```

### 3. UseCase (Domain)

```dart
// lib/features/history/domain/usecases/get_history_use_case.dart
import '../entities/history_item.dart';
import '../repositories/history_repository.dart';

class GetHistoryUseCase {
  const GetHistoryUseCase(this._repository);

  final HistoryRepository _repository;

  Future<List<HistoryItem>> execute() => _repository.getAll();
}

// lib/features/history/domain/usecases/save_history_use_case.dart
import '../entities/history_item.dart';
import '../repositories/history_repository.dart';

class SaveHistoryUseCase {
  const SaveHistoryUseCase(this._repository);

  final HistoryRepository _repository;

  Future<void> execute(HistoryItem item) => _repository.save(item);
}

// lib/features/history/domain/usecases/clear_history_use_case.dart
import '../repositories/history_repository.dart';

class ClearHistoryUseCase {
  const ClearHistoryUseCase(this._repository);

  final HistoryRepository _repository;

  Future<void> execute() => _repository.clear();
}
```

### 4. Data Model

```dart
// lib/features/history/data/models/history_item_model.dart
import 'package:hive/hive.dart';
import '../../domain/entities/history_item.dart';

part 'history_item_model.g.dart';

@HiveType(typeId: 0)
class HistoryItemModel extends HiveObject {
  HistoryItemModel({
    required this.id,
    required this.rawPrompt,
    required this.enhancedPrompt,
    required this.patternName,
    required this.timestamp,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String rawPrompt;

  @HiveField(2)
  final String enhancedPrompt;

  @HiveField(3)
  final String patternName;

  @HiveField(4)
  final DateTime timestamp;

  HistoryItem toEntity() => HistoryItem(
        id: id,
        rawPrompt: rawPrompt,
        enhancedPrompt: enhancedPrompt,
        patternName: patternName,
        timestamp: timestamp,
      );

  factory HistoryItemModel.fromEntity(HistoryItem entity) => HistoryItemModel(
        id: entity.id,
        rawPrompt: entity.rawPrompt,
        enhancedPrompt: entity.enhancedPrompt,
        patternName: entity.patternName,
        timestamp: entity.timestamp,
      );
}
```

### 5. Data Source

```dart
// lib/features/history/data/datasources/history_local_datasource.dart
import 'package:hive_flutter/hive_flutter.dart';
import '../models/history_item_model.dart';

class HistoryLocalDatasource {
  const HistoryLocalDatasource(this._box);

  final Box<HistoryItemModel> _box;

  Future<List<HistoryItemModel>> getAll() async {
    return _box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> save(HistoryItemModel model) async {
    await _box.put(model.id, model);

    // Keep only last 50 items
    if (_box.length > 50) {
      final oldest = _box.values.reduce((a, b) =>
          a.timestamp.isBefore(b.timestamp) ? a : b);
      await _box.delete(oldest.id);
    }
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
```

### 6. Repository Implementation

```dart
// lib/features/history/data/repositories/history_repository_impl.dart
import '../../domain/entities/history_item.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_local_datasource.dart';
import '../models/history_item_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  const HistoryRepositoryImpl(this._datasource);

  final HistoryLocalDatasource _datasource;

  @override
  Future<List<HistoryItem>> getAll() async {
    final models = await _datasource.getAll();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> save(HistoryItem item) async {
    final model = HistoryItemModel.fromEntity(item);
    await _datasource.save(model);
  }

  @override
  Future<void> delete(String id) async {
    await _datasource.delete(id);
  }

  @override
  Future<void> clear() async {
    await _datasource.clear();
  }
}
```

### 7. Providers

```dart
// lib/features/history/data/providers/history_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/repositories/history_repository.dart';
import '../../domain/usecases/get_history_use_case.dart';
import '../../domain/usecases/save_history_use_case.dart';
import '../../domain/usecases/clear_history_use_case.dart';
import '../datasources/history_local_datasource.dart';
import '../models/history_item_model.dart';
import '../repositories/history_repository_impl.dart';

// Hive box
final historyBoxProvider = Provider<Box<HistoryItemModel>>((ref) {
  return Hive.box<HistoryItemModel>('historyBox');
});

// Datasource
final historyLocalDatasourceProvider = Provider<HistoryLocalDatasource>((ref) {
  return HistoryLocalDatasource(ref.watch(historyBoxProvider));
});

// Repository
final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(ref.watch(historyLocalDatasourceProvider));
});

// UseCases
final getHistoryUseCaseProvider = Provider<GetHistoryUseCase>((ref) {
  return GetHistoryUseCase(ref.watch(historyRepositoryProvider));
});

final saveHistoryUseCaseProvider = Provider<SaveHistoryUseCase>((ref) {
  return SaveHistoryUseCase(ref.watch(historyRepositoryProvider));
});

final clearHistoryUseCaseProvider = Provider<ClearHistoryUseCase>((ref) {
  return ClearHistoryUseCase(ref.watch(historyRepositoryProvider));
});
```

### 8. Notifier

```dart
// lib/features/history/presentation/notifiers/history_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/history_providers.dart';
import '../../domain/entities/history_item.dart';

class HistoryNotifier extends AsyncNotifier<List<HistoryItem>> {
  @override
  Future<List<HistoryItem>> build() async {
    return await _loadHistory();
  }

  Future<List<HistoryItem>> _loadHistory() async {
    final useCase = ref.read(getHistoryUseCaseProvider);
    return await useCase.execute();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _loadHistory();
    });
  }

  Future<void> deleteItem(String id) async {
    // Optimistic update
    final currentList = state.value ?? [];
    state = AsyncValue.data(
      currentList.where((item) => item.id != id).toList(),
    );

    // TODO: Call delete use case
  }

  Future<void> clearAll() async {
    state = const AsyncValue.loading();
    final useCase = ref.read(clearHistoryUseCaseProvider);
    
    state = await AsyncValue.guard(() async {
      await useCase.execute();
      return <HistoryItem>[];
    });
  }
}

final historyProvider =
    AsyncNotifierProvider<HistoryNotifier, List<HistoryItem>>(
  HistoryNotifier.new,
);
```

### 9. Screen

```dart
// lib/features/history/presentation/screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../notifiers/history_notifier.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => _showClearConfirmation(context, ref),
          ),
        ],
      ),
      body: state.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No history yet'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  title: Text(item.rawPrompt),
                  subtitle: Text('${item.patternName} • ${_formatDate(item.timestamp)}'),
                  onTap: () => _showDetail(context, item),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _showClearConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to clear all history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(historyProvider.notifier).clearAll();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showDetail(BuildContext context, item) {
    // TODO: Navigate to detail screen
  }

  String _formatDate(DateTime date) {
    // TODO: Format timestamp
    return date.toString();
  }
}
```

### 10. Tests (Scaffolded)

```dart
// test/features/history/domain/usecases/get_history_use_case_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// TODO: Implement tests
@GenerateMocks([HistoryRepository])
void main() {
  group('GetHistoryUseCase', () {
    test('should get history from repository', () async {
      // TODO: Implement test
    });
  });
}
```

## Module Generation Checklist

After generating a module:
- [ ] Run `flutter pub get`
- [ ] Run `flutter pub run build_runner build` (if using Hive/Freezed)
- [ ] Update main.dart to initialize Hive box
- [ ] Add navigation route for the screen
- [ ] Implement TODO comments in generated files
- [ ] Write unit tests for UseCases
- [ ] Write widget tests for Screen
- [ ] Run `flutter analyze` to check for errors
- [ ] Run `flutter test` to verify tests pass

## Quick Command

```bash
# After generating files:
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

---

**Use this pattern when:**
- Starting a new feature from scratch
- Need complete Clean Architecture scaffolding
- Want consistent structure across features
- Onboarding new developers (shows full pattern)
