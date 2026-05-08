# Output Schema — Full Module Generator

## Generated File Tree

```
lib/features/{{feature_name}}/
├── domain/
│   ├── entities/{{feature_name}}.dart
│   ├── repositories/{{feature_name}}_repository.dart
│   └── usecases/
│       ├── get_{{feature_name}}_use_case.dart
│       └── save_{{feature_name}}_use_case.dart
├── data/
│   ├── repositories/{{feature_name}}_repository_impl.dart
│   └── datasources/{{feature_name}}_local_data_source.dart
└── presentation/
    ├── screens/{{feature_name}}_screen.dart
    ├── notifiers/{{feature_name}}_notifier.dart
    └── widgets/
        └── {{feature_name}}_card.dart

test/features/{{feature_name}}/
├── domain/usecases/get_{{feature_name}}_use_case_test.dart
└── presentation/notifiers/{{feature_name}}_notifier_test.dart
```

## Modified Files

| File | Change |
|---|---|
| `lib/core/di/providers.dart` | 4 new `@riverpod` provider functions appended |
| `lib/core/router/app_router.dart` | 1 new `GoRoute` added |
| `main.dart` | 1 new `await Hive.openBox('{{feature_name}}')` |

## File Templates

### Entity
```dart
// lib/features/{{feature_name}}/domain/entities/{{feature_name}}.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature_name}}.freezed.dart';

@freezed
class {{DisplayName}} with _${{DisplayName}} {
  const factory {{DisplayName}}({
    required String id,
    // ENTITY_FIELDS inserted here
    required DateTime createdAt,
  }) = _{{DisplayName}};
}
```

### Repository Interface
```dart
abstract interface class {{DisplayName}}Repository {
  Future<List<{{DisplayName}}>> getAll();
  Future<{{DisplayName}}?> getById(String id);
  Future<void> save({{DisplayName}} item);
  Future<void> delete(String id);
}
```

### UseCases
```dart
class Get{{DisplayName}}UseCase {
  const Get{{DisplayName}}UseCase({required this.repository});
  final {{DisplayName}}Repository repository;
  Future<List<{{DisplayName}}>> execute() => repository.getAll();
}

class Save{{DisplayName}}UseCase {
  const Save{{DisplayName}}UseCase({required this.repository});
  final {{DisplayName}}Repository repository;
  Future<void> execute({{DisplayName}} item) => repository.save(item);
}
```

### Repository Impl
```dart
class {{DisplayName}}RepositoryImpl implements {{DisplayName}}Repository {
  const {{DisplayName}}RepositoryImpl({required this.dataSource});
  final {{DisplayName}}LocalDataSource dataSource;

  @override Future<List<{{DisplayName}}>> getAll() => dataSource.fetchAll();
  @override Future<{{DisplayName}}?> getById(String id) => dataSource.fetchById(id);
  @override Future<void> save({{DisplayName}} item) => dataSource.save(item);
  @override Future<void> delete(String id) => dataSource.delete(id);
}
```

### DataSource
```dart
import 'package:hive_flutter/hive_flutter.dart';

class {{DisplayName}}LocalDataSource {
  static const _boxName = '{{feature_name}}';
  Box get _box => Hive.box(_boxName);

  Future<List<{{DisplayName}}>> fetchAll() async =>
      _box.values.cast<{{DisplayName}}>().toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  Future<{{DisplayName}}?> fetchById(String id) async =>
      _box.get(id) as {{DisplayName}}?;

  Future<void> save({{DisplayName}} item) => _box.put(item.id, item);
  Future<void> delete(String id) => _box.delete(id);
}
```

### Notifier
```dart
@riverpod
class {{DisplayName}}Notifier extends _${{DisplayName}}Notifier {
  @override
  FutureOr<List<{{DisplayName}}>> build() =>
      ref.read(get{{DisplayName}}UseCaseProvider).execute();

  Future<void> refresh() =>
      ref.refresh({{feature_name_camel}}NotifierProvider.future);

  Future<void> save({{DisplayName}} item) async {
    await ref.read(save{{DisplayName}}UseCaseProvider).execute(item);
    ref.invalidateSelf();
  }
}
```

### Screen
```dart
class {{DisplayName}}Screen extends ConsumerWidget {
  const {{DisplayName}}Screen({super.key});
  static const routePath = '/{{feature_route}}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch({{feature_name_camel}}NotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('{{DisplayName}}')),
      body: state.when(
        data: (items) => items.isEmpty
            ? const Center(child: Text('Nothing here yet.'))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) => {{DisplayName}}Card(item: items[i]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
```
