# Post-Execution Steps — pa-review-code

## After Delivering the Review

### If FAIL Issues Found

1. Do not suggest merging. State clearly: `Recommendation: BLOCK merge`.
2. List every FAIL issue with its fix. Offer to implement fixes if the user requests.
3. After fixes are applied, re-run the review on the changed files to confirm resolution.

### If Only WARN Issues Found

1. State: `Recommendation: merge with fixes noted`.
2. Offer to fix WARNs before merge.
3. If the user accepts and fixes are applied, verify the specific lines changed.

### If All PASS

1. State: `Recommendation: safe to merge`.
2. No further action required.

## Suggested Follow-Up Skills

| Situation | Skill to Run |
|---|---|
| FAIL on Architecture | `pa-flutter-expert-skill` — refactor layer violations |
| FAIL on Tests | `pa-unittest` — generate missing tests |
| WARN on Performance | `pa-review-code` again after const/builder fixes |
| Pre-PR comprehensive scan | `pa-issue-detection` — catches runtime patterns flutter analyze misses |

## Verification Commands

```bash
# After architecture fixes, verify no cross-layer imports remain
grep -r "import.*data/" lib/features/*/presentation/
grep -r "import.*presentation/" lib/features/*/domain/

# After test fixes, run the suite
flutter test

# After Riverpod fixes, check for ref.watch in callbacks
grep -rn "onTap.*ref\.watch\|onPressed.*ref\.watch" lib/
```
