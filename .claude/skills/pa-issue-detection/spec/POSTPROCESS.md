# Post-Execution Steps — pa-issue-detection

## After Delivering the Scan Report

### If HIGH RISK Issues Found

1. State: `Recommendation: BLOCK merge`.
2. For each HIGH issue, offer to fix it immediately.
3. After fixes are applied, re-run only the affected files:
   ```bash
   # Re-scan specific file after fix
   FILES: lib/features/transformer/presentation/notifiers/transformer_notifier.dart
   ```
4. Confirm the issue is resolved before changing recommendation.

### If Only MEDIUM/LOW Issues Found

1. State: `Recommendation: merge with caution`.
2. List the MEDIUM issues with their fixes. Offer to address them.
3. LOW issues can be addressed in a follow-up PR — note them but do not block.

### If All Files Clean

1. State: `Recommendation: safe to merge`.
2. Suggest opening the PR.

## Suggested Follow-Up Skills

| Situation | Follow-Up Skill |
|---|---|
| Many HIGH issues found | `pa-review-code` — full structural review before fixing |
| Architecture issues discovered | `pa-quality-engineer` — validate against PRD too |
| Tests are missing (noted from P10) | `pa-unittest` — generate missing test files |

## After All Issues Resolved

```bash
# Final verification — run flutter analyze
flutter analyze

# Run tests
flutter test

# Confirm branch is clean
git diff main...HEAD --name-only | grep '\.dart$'
```

Then open the PR.
