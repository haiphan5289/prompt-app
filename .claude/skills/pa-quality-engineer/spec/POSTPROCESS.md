# Post-Execution Steps — pa-quality-engineer

## After Delivering the QE Report

### If CRITICAL Issues Found

1. Recommend `BLOCK release`.
2. Offer to fix CRITICAL issues if the user requests.
3. After fixes: re-run the specific failing dimension(s) to confirm resolution.
4. Only change recommendation to `Ship with fixes` or `Ship as-is` after re-validation.

### If Only MAJOR/MINOR Issues Found

1. Recommend `Ship with fixes` and list what to fix.
2. Offer to address each MAJOR issue.
3. After fixes: re-run affected dimensions.

### If All Dimensions Pass

1. Recommend `Ship as-is`.
2. No further action required.

## Suggested Follow-Up Skills

| Situation | Follow-Up |
|---|---|
| Architecture CRITICAL | `pa-review-code` — detailed layer refactor |
| Tests MAJOR | `pa-unittest` — generate missing test files |
| Riverpod MAJOR | `pa-review-code` — Riverpod-focused review |
| Business Requirements gap | Clarify PRD with user, then re-validate |
| Pre-merge runtime scan | `pa-issue-detection` — catches patterns flutter analyze misses |

## Re-Validation Command

After fixes are applied, re-run only the affected dimensions:

```
PRD: <same PRD>
TARGET: <same TARGET>
DIMENSIONS: <only the dimensions that had issues>
```

This avoids re-running clean dimensions and keeps the feedback loop fast.
