# Post-Process — Prompt Pattern Design

## After Adding a New Pattern

### 1. Verify Seed Data Integrity

```bash
grep -n "id:" lib/features/pattern/data/datasources/pattern_local_data_source.dart
```

Confirm the new pattern `id` appears exactly once in the seed list.

### 2. Check No Duplicate IDs

```bash
grep -n "id:" lib/features/pattern/data/datasources/pattern_local_data_source.dart | sort | uniq -d
```

Output must be empty — no duplicates.

### 3. Run Analysis

```bash
flutter analyze lib/features/pattern/
```

Zero warnings. Fix all issues before proceeding.

### 4. Run Format

```bash
dart format lib/features/pattern/
```

No changes needed means the file is already properly formatted.

### 5. Run Existing Tests

```bash
flutter test test/features/pattern/
```

All existing tests must still pass — adding a pattern must not break existing behavior.

### 6. Write a Test for the New Pattern

Add a unit test that:
- Calls `TransformUseCase.execute(rawPrompt, newPatternId)`
- Asserts the transformed output contains the expected template structure
- Tests at least 2 different raw inputs

### 7. Update Pattern Count Documentation

If a pattern count is referenced in the app's README or onboarding copy, update it.

### 8. Mark Pattern as Reviewed

Confirm all 25 items in `EVAL.md` are checked before closing the task.
