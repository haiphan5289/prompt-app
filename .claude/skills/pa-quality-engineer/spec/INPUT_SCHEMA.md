# Input Schema — pa-quality-engineer

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `PRD` | string | yes | Inline feature spec text OR path to PRD/spec file |
| `TARGET` | string | yes | Feature folder or file path to validate (e.g. `lib/features/transformer/`) |
| `DIMENSIONS` | list | no | Specific dimensions to run. Defaults to all 6. Options: `Business`, `Architecture`, `Riverpod`, `Transformer`, `UI`, `Tests` |

## Input Format

```
PRD: <inline feature spec OR file path>
TARGET: <feature folder or file path>
```

## PRD Format Support

The PRD field accepts any of the following:

1. **Inline text** — paste acceptance criteria directly
2. **File path** — `lib/features/transformer/PRD.md`
3. **Minimal spec** — a bulleted list of requirements is sufficient

## Example Inputs

```
# Minimal — inline PRD
PRD: |
  - User can select a prompt pattern from a list
  - Tapping a pattern applies it to the current input
  - Selected pattern is highlighted in the list
  - Empty input shows validation error instead of transforming
TARGET: lib/features/transformer/

# File-based PRD
PRD: docs/features/history-feature-prd.md
TARGET: lib/features/history/

# Specific dimensions only
PRD: <inline>
TARGET: lib/features/pattern_library/
DIMENSIONS: Architecture, Riverpod, Tests
```
