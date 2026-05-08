# Input Schema — Handle UseCase

## Input Block

```
NOTIFIER: <existing Notifier class name, e.g. "TransformerNotifier">
NOTIFIER_FILE: <path, e.g. "lib/features/transformer/presentation/notifiers/transformer_notifier.dart">
USE_CASE: <UseCase class name, e.g. "SuggestPatternUseCase">
USE_CASE_PROVIDER: <provider name, e.g. "suggestPatternUseCaseProvider">
METHOD_NAME: <name for the new Notifier method, e.g. "suggestPattern">
PARAMS: [{name: rawPrompt, type: String}]
RETURN_BEHAVIOR: <replace_state | append_to_list | invalidate_self>
```

## Field Definitions

| Field | Type | Required | Description |
|---|---|---|---|
| `NOTIFIER` | `String` (PascalCase) | Yes | Class name of the existing Notifier to modify |
| `NOTIFIER_FILE` | `String` (file path) | Yes | Full path to the Notifier's `.dart` file |
| `USE_CASE` | `String` (PascalCase) | Yes | UseCase class name (already exists) |
| `USE_CASE_PROVIDER` | `String` (camelCase) | Yes | Riverpod provider name for the UseCase |
| `METHOD_NAME` | `String` (camelCase) | Yes | Name of the new method to add to the Notifier |
| `PARAMS` | `List<{name, type}>` | Yes | Parameters the Notifier method accepts; use `[]` for none |
| `RETURN_BEHAVIOR` | `Enum` | Yes | Controls how state is updated after execution |

## RETURN_BEHAVIOR Values

| Value | When to use |
|---|---|
| `replace_state` | UseCase returns a value that replaces the current Notifier state |
| `append_to_list` | UseCase returns a new item to add to the existing list state |
| `invalidate_self` | UseCase performs a mutation (delete/clear/save), then reload from repository |

## State Type Reference

| Notifier state type | Recommended variant |
|---|---|
| `AsyncValue<T?>` | `replace_state` |
| `AsyncValue<List<T>>` (add item) | `append_to_list` |
| `AsyncValue<List<T>>` (mutate) | `invalidate_self` |
| `AsyncValue<void>` | `replace_state` or `invalidate_self` |
