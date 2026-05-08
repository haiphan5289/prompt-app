# Output Schema — pa-review-code

## Review Report Format

```
## Review: [Feature/File Name]

### Architecture  [PASS / WARN / FAIL]
### Riverpod      [PASS / WARN / FAIL]
### Null Safety   [PASS / WARN / FAIL]
### Widget        [PASS / WARN / FAIL]
### Performance   [PASS / WARN / FAIL]
### Domain Logic  [PASS / WARN / FAIL]  (only if transformer/pattern code)
### Tests         [PASS / WARN / FAIL]

---
[Issues with line references and fix suggestions]
```

## Issue Block Format

Each issue entry:

```
**[FAIL|WARN]** `lib/features/.../file.dart:42`
Problem: ref.watch used inside onTap callback
Fix: Replace with ref.read(someProvider)
```

## Severity Key

| Rating | Meaning |
|---|---|
| FAIL | Breaks architecture, crashes, or wrong behavior — must fix before merge |
| WARN | Works but violates conventions or is fragile — should fix, can merge with note |
| PASS | Clean, correct, follows all conventions — no action needed |

## Required Sections

- Summary header with dimension ratings
- Issue list (grouped by FAIL then WARN)
- Final recommendation: `BLOCK merge`, `merge with fixes noted`, or `safe to merge`
