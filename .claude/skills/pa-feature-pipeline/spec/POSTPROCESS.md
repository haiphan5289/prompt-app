# Post-Process — Feature Pipeline

## After Phase 3 Completes

### 1. Final Analysis Run

```bash
flutter analyze lib/
```

Expected output: `No issues found!`

### 2. Final Format Run

```bash
dart format lib/ test/
```

Expected output: `Unchanged X files.`

### 3. Full Test Suite

```bash
flutter test
```

All tests must pass. Zero failures. Zero errors.

### 4. Build Runner (if code generation was used)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Run if any `.g.dart` files need regeneration after adding Riverpod providers.

### 5. Manual Smoke Test

- Launch the app on a simulator
- Navigate to the new feature
- Complete the happy path end-to-end
- Confirm no runtime errors in the console

### 6. EVAL Checklist

Work through all 21 items in `EVAL.md`. All must be checked before closing the feature.

### 7. Cross-Feature Regression Check

For full-stack features, verify:
```bash
flutter test test/features/
```

Confirm that existing feature tests still pass (new code did not break existing behavior).

### 8. Update CLAUDE.md (if architecture changed)

If the new feature introduces a new pattern, convention, or architectural rule, add a note to `CLAUDE.md` so future agents follow it.
