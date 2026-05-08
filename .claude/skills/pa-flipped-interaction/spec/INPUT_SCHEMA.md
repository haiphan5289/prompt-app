# Input Schema — Flipped Interaction

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `REQUEST` | string | yes | The original feature request, exactly as stated by the user |
| `PRIORITY` | enum | no | `high` / `medium` / `low` — controls how many questions to ask. Inferred from vagueness if omitted. |
| `CONTEXT` | string | no | Any additional context already known (e.g., which screen, related tickets) |

## Trigger Conditions

Use this skill when the request matches any of:

- Uses vague language: "make it better", "improve the flow", "add something for patterns"
- Multiple valid architectures exist and the choice significantly affects scope
- It is unclear which layer needs to change (UI-only vs. full-stack)
- The request involves a new prompt pattern (template + examples not yet defined)
- Business logic is ambiguous (e.g., "auto-select a pattern" — how exactly?)

## Priority Inference Rules

If `PRIORITY` is not provided, infer it:

- **HIGH**: Request names a specific screen and action, but one key behavior is undefined
- **MEDIUM**: Request names a feature area but not the screen, or the data layer involvement is unclear
- **LOW**: Request is aspirational ("make it better") with no acceptance criteria at all

## Example Invocations

```
REQUEST: "Make the pattern selection better"
PRIORITY: medium
```

```
REQUEST: "Add auto-select for patterns"
CONTEXT: PatternSelectorRow exists. User currently picks manually.
```

```
REQUEST: "Add something to help users who don't know which pattern to use"
PRIORITY: low
```
