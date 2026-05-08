# Input Schema — pa-module-context

## Input Block

```
FEATURE: <transformer | pattern_library | history | all>
TASK: <what you are about to implement, e.g. "Add a SuggestPatternUseCase">
```

## Field Definitions

| Field | Type | Required | Description |
|---|---|---|---|
| `FEATURE` | `Enum` | Yes | Which feature module to map |
| `TASK` | `String` | No | Used to highlight the most relevant files for the caller's work |

## FEATURE Values

| Value | Folder | Description |
|---|---|---|
| `transformer` | `lib/features/transformer/` | Core prompt transformation engine |
| `pattern_library` | `lib/features/pattern_library/` | Curated prompt pattern catalog |
| `history` | `lib/features/history/` | Saved transformation history |
| `all` | `lib/features/` | Full codebase map across all three features |

## When to Use Each Value

| Situation | FEATURE value |
|---|---|
| Implementing a new UseCase for the transformer | `transformer` |
| Adding a new prompt pattern | `pattern_library` |
| Building history list or delete | `history` |
| Cross-feature integration (e.g. save transformed result to history) | `all` |
| New session — unfamiliar with the codebase | `all` |
