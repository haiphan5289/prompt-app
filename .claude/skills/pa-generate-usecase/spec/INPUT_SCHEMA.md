# Input Schema — Generate UseCase

## Input Block

```
USE_CASE_NAME: <PascalCase, e.g. "DeleteHistory">
FEATURE: <feature folder name, e.g. "history">
REPOSITORY: <existing repository interface name, e.g. "HistoryRepository">
METHOD:
  name: <method name, e.g. "delete">
  params: [{name: id, type: String}]
  returns: <Future<void> | Future<T> | Stream<T>>
REFERENCE_USE_CASE: <existing UseCase class name to follow pattern of — optional>
```

## Field Definitions

| Field | Type | Required | Description |
|---|---|---|---|
| `USE_CASE_NAME` | `String` (PascalCase) | Yes | Name without "UseCase" suffix — it will be added |
| `FEATURE` | `String` (snake_case folder) | Yes | Feature folder name under `lib/features/` |
| `REPOSITORY` | `String` (PascalCase) | Yes | Existing abstract repository interface class name |
| `METHOD.name` | `String` (camelCase) | Yes | Repository method to call from the UseCase |
| `METHOD.params` | `List<{name, type}>` | Yes | Parameter list; use empty list `[]` for no params |
| `METHOD.returns` | `String` (Dart type) | Yes | Return type of the repository method |
| `REFERENCE_USE_CASE` | `String` (PascalCase) | No | Existing UseCase to copy naming/style conventions from |

## Common Return Types

| Pattern | Return type |
|---|---|
| Load list | `Future<List<T>>` |
| Save item | `Future<void>` |
| Delete item | `Future<void>` |
| Transform prompt | `Future<TransformResult>` |
| Suggest pattern | `Future<PromptPattern?>` |
| Clear all | `Future<void>` |

## Notifier Variant Selection

| `RETURN_BEHAVIOR` | Use when |
|---|---|
| `replace_state` | UseCase returns a value that becomes the new state |
| `invalidate_self` | UseCase performs a side effect (delete/save/clear) then reload |
| `append_to_list` | UseCase returns a single item to append to an existing list |
