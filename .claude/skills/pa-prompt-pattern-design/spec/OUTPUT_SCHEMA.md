# Output Schema — Prompt Pattern Design

## For ADD_PATTERN Action

The primary output is a fully-specified pattern definition ready for insertion into `PatternLocalDataSource`.

### Pattern Data Structure

```dart
PromptPattern(
  id: 'snake_case_id',
  name: 'Human-Readable Name',
  category: PatternCategory.roleBased, // (enum value)
  description: 'One sentence describing what this pattern adds.',
  template: '''
    [Template text with {{userInput}} and optional {{variables}}]
  ''',
  whenToUse: [
    'Trigger condition 1',
    'Trigger condition 2',
    'Trigger condition 3',
  ],
  examples: [
    PatternExample(
      input: 'raw user prompt 1',
      output: 'transformed prompt 1',
    ),
    PatternExample(
      input: 'raw user prompt 2',
      output: 'transformed prompt 2',
    ),
    PatternExample(
      input: 'raw user prompt 3',
      output: 'transformed prompt 3',
    ),
  ],
)
```

### Seed Data Entry

A Dart snippet ready to paste into `PatternLocalDataSource._seeds`:

```dart
// --- ADD AFTER LAST ENTRY ---
PromptPattern(
  id: '...',
  // ... full definition
),
```

## For REFINE_PATTERN Action

Outputs a diff of the changed fields only — not the full pattern unless the template was restructured.

## For EVALUATE_PATTERN Action

Outputs a scored evaluation table:

| Criterion | Score (1–5) | Notes |
|---|---|---|
| Improvement delta | X | |
| Generality | X | |
| Predictability | X | |
| Simplicity | X | |
| Composability | X | |
| **Total** | X/25 | Pass if all ≥ 3/5 |

## For AUDIT_LIBRARY Action

Outputs a gap analysis table:

| Category | Count | Missing domains |
|---|---|---|
| Role-Based | N | [domains not covered] |
| Chain-of-Thought | N | [domains not covered] |
| ... | | |
