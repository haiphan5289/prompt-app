# Output Schema — pa-issue-detection

## Scan Report Format

```
## Pre-Merge Scan: [branch] → [base]

### HIGH RISK (must fix before merge)
- [file:line] P0X: [description] → [fix]

### MEDIUM RISK (should fix)
- [file:line] P0X: [description] → [fix]

### LOW RISK (consider fixing)
- [file:line] P0X: [description] → [fix]

### CLEAN
- [files with no issues listed here]

---
Total issues: HIGH N | MEDIUM N | LOW N
Recommendation: [BLOCK merge | merge with caution | safe to merge]
```

## Risk Levels

| Level | Patterns | Action |
|---|---|---|
| HIGH | P01, P02, P03, P04, P06, P09, P10 | Must fix before merge |
| MEDIUM | P05, P07, P11 | Should fix |
| LOW | P08, P12 | Consider fixing |

## Recommendation Values

- `BLOCK merge` — one or more HIGH RISK issues found
- `merge with caution` — only MEDIUM or LOW issues found
- `safe to merge` — no issues found across all scanned files

## Issue Entry Format

Each issue entry must include:
1. File path and line number: `lib/features/transformer/notifier.dart:34`
2. Pattern ID: `P03`
3. Description: what the problem is in plain language
4. Fix: the specific code change needed

Example:
```
- lib/features/transformer/presentation/notifiers/transformer_notifier.dart:34 P03: ref.watch inside onPressed callback → replace with ref.read(transformerNotifierProvider.notifier).transform(input)
```
