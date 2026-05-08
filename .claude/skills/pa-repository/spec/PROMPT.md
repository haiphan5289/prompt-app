# Execution Workflow — pa-repository

Generate a Repository interface + implementation for Prompt App following Clean Architecture.

---

## Step 1: Verify Entity Exists

```bash
find lib/features/{{feature}}/domain/entities -name "{{entity_snake}}.dart"
```

If missing, stop and create the entity first using `pa-scaffold`.

---

## Step 2: Generate Domain Interface

Create `lib/features/{{feature}}/domain/repositories/{{name_snake}}_repository.dart`:

```dart
abstract interface class {{Name}}Repository {
  Future<List<{{Entity}}>> getAll();
  Future<{{Entity}}?> getById(String id);
  Future<void> save({{Entity}} item);
  Future<void> delete(String id);
  Future<void> clear();
}
```

Include only the operations listed in `OPERATIONS`. Do not add methods that aren't requested.

---

## Step 3: Generate Data Implementation

Create `lib/features/{{feature}}/data/repositories/{{name_snake}}_repository_impl.dart`:

```dart
import '../../domain/entities/{{entity_snake}}.dart';
import '../../domain/repositories/{{name_snake}}_repository.dart';
import '../datasources/{{name_snake}}_local_data_source.dart';

class {{Name}}RepositoryImpl implements {{Name}}Repository {
  const {{Name}}RepositoryImpl({required this.dataSource});

  final {{Name}}LocalDataSource dataSource;

  @override
  Future<List<{{Entity}}>> getAll() => dataSource.fetchAll();

  @override
  Future<{{Entity}}?> getById(String id) => dataSource.fetchById(id);

  @override
  Future<void> save({{Entity}} item) => dataSource.save(item);

  @override
  Future<void> delete(String id) => dataSource.delete(id);

  @override
  Future<void> clear() => dataSource.clear();
}
```

Only implement the methods in `OPERATIONS`.

---

## Step 4: Register Riverpod Provider

Add to `lib/core/di/providers.dart`:

```dart
@riverpod
{{Name}}Repository {{nameCamel}}Repository({{Name}}RepositoryRef ref) =>
    {{Name}}RepositoryImpl(
      dataSource: ref.watch({{nameCamel}}LocalDataSourceProvider),
    );
```

---

## Step 5: Verify DataSource Provider Exists

```bash
grep -n "{{nameCamel}}LocalDataSourceProvider" lib/core/di/providers.dart
```

If the DataSource provider is missing, create it or use `pa-scaffold` to generate the DataSource class first.

---

## Step 6: Format and Analyze

```bash
dart format lib/features/{{feature}}/domain/repositories/ lib/features/{{feature}}/data/repositories/
flutter analyze lib/features/{{feature}}/
```

Zero warnings required.
