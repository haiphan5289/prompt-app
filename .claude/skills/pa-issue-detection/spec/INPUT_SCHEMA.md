# Input Schema — pa-issue-detection

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `BRANCH` | string | no | Branch to diff against main. Defaults to `HEAD` (current branch) |
| `BASE` | string | no | Base branch to diff from. Defaults to `main` |
| `FILES` | list | no | Explicit list of files to scan instead of git diff. Useful for scanning uncommitted changes. |
| `PATTERNS` | list | no | Subset of pattern IDs to run (e.g. `P01,P03`). Defaults to all 12. |

## Input Formats

```
# Default — scan current branch vs main
(no input needed)

# Scan a specific branch
BRANCH: feature/history-screen

# Scan against a different base
BRANCH: feature/history-screen
BASE: develop

# Scan specific files only
FILES:
  - lib/features/transformer/domain/usecases/transform_use_case.dart
  - lib/features/transformer/presentation/notifiers/transformer_notifier.dart

# Run only high-risk patterns
PATTERNS: P01,P02,P03,P04,P06,P09,P10
```

## Notes

- Files in `test/` directory are excluded from P08 (print check) but still scanned for other patterns
- If no Dart files changed on the branch, the skill reports "no changed Dart files — nothing to scan"
- Binary files and generated `*.g.dart` files are excluded from scanning
