# Input Schema — Scaffold

## Required Fields

| Field | Type | Values | Description |
|---|---|---|---|
| `FILE_TYPE` | enum | See below | The type of file to generate |
| `NAME` | string | PascalCase | Base name, e.g. `PatternSelector` |
| `FEATURE` | string | snake_case | Feature folder, e.g. `transformer` |

## FILE_TYPE Values

| Value | Generates | Output Count |
|---|---|---|
| `Screen` | Screen + private body widget | 1 file |
| `Notifier` | AsyncNotifier with `@riverpod` | 1 file (+ .g.dart from build_runner) |
| `UseCase` | UseCase class | 1 file |
| `Repository` | Abstract interface + Impl | 2 files |
| `DataSource` | Hive local data source | 1 file |
| `Entity` | Freezed entity | 1 file (+ .freezed.dart from build_runner) |
| `Widget` | ConsumerWidget | 1 file |

## FEATURE Values

| Value | Description |
|---|---|
| `transformer` | Core: input → pattern → output |
| `pattern_library` | Browse and manage prompt patterns |
| `history` | Before/after prompt history |

## Optional Fields

| Field | Type | Description |
|---|---|---|
| `STATE_TYPE` | string | For Notifier: the type `FutureOr<T?>` wraps (default: inferred from NAME) |
| `ENTITY_TYPE` | string | For Repository/DataSource: the entity class name |

## Example Input

```
FILE_TYPE: Screen
NAME: PatternSelector
FEATURE: transformer
```

```
FILE_TYPE: Notifier
NAME: PromptHistory
FEATURE: history
STATE_TYPE: List<TransformResult>
```

```
FILE_TYPE: Repository
NAME: Pattern
FEATURE: pattern_library
ENTITY_TYPE: PromptPattern
```
