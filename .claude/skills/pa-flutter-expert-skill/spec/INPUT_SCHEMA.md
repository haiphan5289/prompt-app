# Input Schema — Flutter Expert

## Fields

| Field | Type | Required | Description |
|---|---|---|---|
| `TASK` | string | Yes | What needs to be implemented |
| `LAYER` | enum | No | `Presentation`, `Domain`, `Data`, or `Full-stack` |
| `FEATURE` | string | No | Feature folder: `transformer`, `pattern_library`, `history` |
| `FILES` | list | No | Specific files to read or modify |

## LAYER Values

| Value | When to Use |
|---|---|
| `Presentation` | Screen, Widget, Notifier only |
| `Domain` | Entity, UseCase, Repository interface only |
| `Data` | Repository impl, DataSource only |
| `Full-stack` | All layers — new feature or end-to-end change |

## FEATURE Values

| Value | Description |
|---|---|
| `transformer` | Core feature: input → pattern → output |
| `pattern_library` | Browse and manage prompt patterns |
| `history` | Before/after prompt history |
| `core` | Theme, router, DI providers |
| `shared` | Reusable widgets and utilities |

## Example Inputs

```
TASK: Add a "Copy to clipboard" button on the result card
LAYER: Presentation
FEATURE: transformer
```

```
TASK: Implement a UseCase that filters patterns by category
LAYER: Domain
FEATURE: pattern_library
```

```
TASK: Add bookmarking — save a TransformResult as a favourite
LAYER: Full-stack
FEATURE: (new feature)
```
