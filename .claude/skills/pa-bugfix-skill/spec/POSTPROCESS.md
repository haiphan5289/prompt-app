# Post-Execution Steps — Bug Fix

After applying the fix:

## 1. Static Analysis

```bash
flutter analyze lib/
```

Expected: zero warnings. Treat every warning as an error — do not ignore.

## 2. Format Check

```bash
dart format --output=none --set-exit-if-changed lib/
```

Expected: no formatting changes needed. If changes are needed, run `dart format lib/`.

## 3. Run Tests

```bash
flutter test test/
```

Expected: all tests pass. If a test fails, check whether the fix changed a contract the test relied on.

## 4. Manual Verification

Follow the "How to verify" steps from the fix summary:
- Hot restart (not hot reload) to clear any stale state
- Reproduce the original bug scenario
- Confirm the symptom no longer occurs
- Confirm no new symptoms appear (regression check)

## 5. Check Nearby Code

After fixing, briefly scan the same file for the same pattern:
- If `ref.read` was wrong in one place, check if it appears elsewhere in the same `build()` method
- If `mounted` was missing after one `await`, check other `await` calls in the same method
- Do not refactor — just note any additional issues for a separate task

## 6. Update Summary

Confirm the fix summary contains all four fields:
- **What was broken**
- **Why**
- **Fix** (with code diff)
- **How to verify**
