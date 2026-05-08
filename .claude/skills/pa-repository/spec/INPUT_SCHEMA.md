# Input Schema — pa-repository

## Input Block

```
NAME: <PascalCase base name, e.g. "Bookmark">
ENTITY: <entity class name, e.g. "Bookmark">
FEATURE: <feature folder, e.g. "bookmark">
OPERATIONS: [getAll, getById, save, delete, clear]
```

## Field Definitions

| Field | Type | Required | Description |
|---|---|---|---|
| `NAME` | `String` (PascalCase) | Yes | Base name used for class names and file names |
| `ENTITY` | `String` (PascalCase) | Yes | Domain entity class that this repository handles |
| `FEATURE` | `String` (snake_case) | Yes | Feature folder under `lib/features/` |
| `OPERATIONS` | `List<String>` | Yes | Subset of: `getAll`, `getById`, `save`, `delete`, `clear` |

## OPERATIONS Reference

| Operation | Interface method | DataSource delegate |
|---|---|---|
| `getAll` | `Future<List<Entity>> getAll()` | `dataSource.fetchAll()` |
| `getById` | `Future<Entity?> getById(String id)` | `dataSource.fetchById(id)` |
| `save` | `Future<void> save(Entity item)` | `dataSource.save(item)` |
| `delete` | `Future<void> delete(String id)` | `dataSource.delete(id)` |
| `clear` | `Future<void> clear()` | `dataSource.clear()` |

## Generated File Paths

| Template | Resolved path |
|---|---|
| `lib/features/{{feature}}/domain/repositories/{{name_snake}}_repository.dart` | e.g. `lib/features/bookmark/domain/repositories/bookmark_repository.dart` |
| `lib/features/{{feature}}/data/repositories/{{name_snake}}_repository_impl.dart` | e.g. `lib/features/bookmark/data/repositories/bookmark_repository_impl.dart` |
