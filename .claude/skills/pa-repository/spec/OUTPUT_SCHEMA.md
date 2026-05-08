# Output Schema — pa-repository

## Generated Files

| File | Layer | Description |
|---|---|---|
| `lib/features/{{feature}}/domain/repositories/{{name_snake}}_repository.dart` | Domain | Abstract interface |
| `lib/features/{{feature}}/data/repositories/{{name_snake}}_repository_impl.dart` | Data | Concrete implementation |

## Modified Files

| File | Change |
|---|---|
| `lib/core/di/providers.dart` | New `@riverpod` provider added for the repository |

## Domain Interface Shape

```dart
abstract interface class {{Name}}Repository {
  // Only methods listed in OPERATIONS are generated
  Future<List<{{Entity}}>> getAll();
  Future<{{Entity}}?> getById(String id);
  Future<void> save({{Entity}} item);
  Future<void> delete(String id);
  Future<void> clear();
}
```

## Data Implementation Shape

```dart
class {{Name}}RepositoryImpl implements {{Name}}Repository {
  const {{Name}}RepositoryImpl({required this.dataSource});
  final {{Name}}LocalDataSource dataSource;
  // Thin delegates only — no logic
}
```

## Provider Shape

```dart
@riverpod
{{Name}}Repository {{nameCamel}}Repository({{Name}}RepositoryRef ref) =>
    {{Name}}RepositoryImpl(
      dataSource: ref.watch({{nameCamel}}LocalDataSourceProvider),
    );
```
