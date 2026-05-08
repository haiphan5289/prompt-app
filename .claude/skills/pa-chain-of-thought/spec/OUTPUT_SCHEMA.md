# Output Schema — Chain-of-Thought Analysis

## Output Format

The analysis is delivered as a single structured document in this exact order:

```
## Problem
[One paragraph restatement of the problem in the analyst's own words]

## Architecture Impact
- Entities:      [new | modified | none] — [class name if applicable]
- Repositories:  [new | modified | none] — [interface + impl if applicable]
- Providers:     [new | modified | none] — [provider name if applicable]
- Screens:       [new | modified | none] — [screen name if applicable]

## Data Flow
[Annotated flow diagram using the canonical pattern:
  Widget → Notifier → UseCase → Repository → DataSource → back up]

## Edge Cases
1. [Edge case] → [handling strategy]
2. [Edge case] → [handling strategy]
...

## Test Plan
1. [Test name] — [layer] — [priority: critical / high / medium]
2. ...

## Implementation Order
1. [Step] — complexity: [low | medium | high]
2. ...

## Open Questions
Q1. [Question] — blocks [Phase N]
Q2. ...
```

## Constraints

- Every section must be present, even if the answer is "none" or "N/A".
- Open Questions must always be the last section.
- The data flow diagram must use actual class names from the codebase (or clearly mark them as `[NEW]`).
- Do not include code snippets in the analysis output — that is for the implementation phase.
