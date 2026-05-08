# Post-Execution Steps — pa-unittest

## After Writing the Test File

### Step 1: Run the Tests

```bash
flutter test test/features/<feature>/<layer>/<name_snake>_test.dart
```

### Step 2: If Tests Fail

Common failure causes and fixes:

| Failure | Cause | Fix |
|---|---|---|
| `MissingStubError` | A method was called that wasn't stubbed | Add `when(...)` stub for that method |
| `type '...' is not a subtype` | Mock class does not implement the correct interface | Verify the interface name in source and fix the `implements` clause |
| `ProviderNotFound` | Provider not overridden in container/scope | Add override in `ProviderContainer` overrides or `ProviderScope` |
| `HiveError` | Real Hive box opened | Replace with in-memory fake or mock |
| `NoSuchMethodError` | Method name in stub doesn't match source | Re-read source and correct method name |

### Step 3: Check Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

Target: the class under test should be at 80%+ line coverage after generated tests.

### Step 4: Suggested Follow-Up

| Situation | Action |
|---|---|
| Tests pass but coverage is low | Add edge case tests for null inputs, empty lists, boundary values |
| Test file needs review | Run `pa-review-code` with `SCOPE: Tests` |
| Need tests for more classes in the feature | Re-invoke with a different `TARGET`/`NAME` |
| Widget tests need interaction (tapping, typing) | Add `tester.tap()`, `tester.enterText()` calls and pump after |
