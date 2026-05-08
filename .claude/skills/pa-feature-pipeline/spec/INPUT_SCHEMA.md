# Input Schema — Feature Pipeline

## Required Input Block

```
FEATURE: [Feature name and one-sentence description]
SCOPE: [Which layer(s) — see valid values below]
PATTERN_INVOLVED: [yes | no]
ACCEPTANCE_CRITERIA:
  - [criterion 1]
  - [criterion 2]
  - [criterion 3]
```

## Field Definitions

| Field | Type | Required | Description |
|---|---|---|---|
| `FEATURE` | `String` | Yes | Feature name followed by a one-sentence description |
| `SCOPE` | `Enum` | Yes | Which architectural layer(s) this feature touches |
| `PATTERN_INVOLVED` | `yes \| no` | Yes | Whether this feature adds or modifies a prompt pattern |
| `ACCEPTANCE_CRITERIA` | `List<String>` (min 2) | Yes | Testable conditions that define "done" |

## SCOPE Valid Values

| Value | Meaning |
|---|---|
| `UI only` | Only presentation layer changes — no new domain or data files |
| `domain only` | Only domain entities, repository interfaces, and UseCases |
| `data only` | Only data layer — repository impl, datasource |
| `full-stack` | All layers: domain + data + presentation |

## PATTERN_INVOLVED Behavior

| Value | Effect |
|---|---|
| `yes` | Phase 1 begins by invoking `pa-prompt-pattern-design` before domain design |
| `no` | Phase 1 goes directly to domain entity/repository/UseCase design |
