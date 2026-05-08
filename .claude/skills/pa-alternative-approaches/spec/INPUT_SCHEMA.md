# Input Schema — pa-alternative-approaches

## Input Block

```
PROBLEM: <what decision needs to be made>
CONTEXT: <feature or layer involved, e.g. "history feature, data layer">
COMPLEXITY: <Simple | Medium | Complex>
CONSTRAINTS: <hard requirements that rule out some options>
```

## Field Definitions

| Field | Type | Required | Description |
|---|---|---|---|
| `PROBLEM` | `String` | Yes | The architectural or implementation decision to evaluate |
| `CONTEXT` | `String` | Yes | Feature folder, layer, or component involved |
| `COMPLEXITY` | `Enum` | Yes | Controls how many options to generate |
| `CONSTRAINTS` | `String` | No | Hard limits that eliminate certain options (e.g. "offline-first", "no SQL", "must use Riverpod") |

## COMPLEXITY → Options Count

| Complexity | Options generated |
|---|---|
| `Simple` | 3 options |
| `Medium` | 3–4 options |
| `Complex` | 4–5 options |

## Common Decision Areas in Prompt App

| Decision | Typical CONTEXT |
|---|---|
| State management approach | `any feature, presentation layer` |
| Pattern storage strategy | `pattern_library, data layer` |
| AI API integration | `transformer, service layer` |
| Template engine design | `transformer, domain layer` |
| Local persistence | `history or pattern_library, data layer` |
| Navigation approach | `app-level, router` |
