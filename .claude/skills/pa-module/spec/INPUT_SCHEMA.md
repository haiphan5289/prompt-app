# Input Schema — Full Module Generator

## Required Fields

| Field | Type | Description |
|---|---|---|
| `FEATURE_NAME` | snake_case string | Feature folder name, e.g. `bookmark` |
| `DISPLAY_NAME` | PascalCase string | Class name prefix, e.g. `Bookmark` |
| `PURPOSE` | string | One sentence: what this feature does |
| `ENTITY_FIELDS` | list of `fieldName: Type` | Fields for the domain entity (beyond `id` and `createdAt`) |

## ENTITY_FIELDS Format

```
ENTITY_FIELDS:
  - fieldName: Type
  - fieldName: Type
```

Each entry maps to a `required FieldType fieldName` in the Freezed entity.

Supported types: `String`, `int`, `double`, `bool`, `DateTime`, `List<T>`, or any domain entity type already in the project.

## Constraints

- `FEATURE_NAME` must not already exist as a folder under `lib/features/`
- Use `pa-scaffold` instead if the folder already exists
- `DISPLAY_NAME` must be PascalCase and match `FEATURE_NAME` semantically

## Example Input

```
FEATURE_NAME: bookmark
DISPLAY_NAME: Bookmark
PURPOSE: Save and revisit favourite enhanced prompts
ENTITY_FIELDS:
  - promptId: String
  - note: String
  - savedAt: DateTime
```

```
FEATURE_NAME: prompt_history
DISPLAY_NAME: PromptHistory
PURPOSE: Store before/after transform results persistently
ENTITY_FIELDS:
  - originalPrompt: String
  - enhancedPrompt: String
  - patternId: String
```
