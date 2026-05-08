# Post-Execution Steps — pa-module-context

## 1. Hand Off to Implementation

After the caller has the module map, they should proceed to the appropriate skill:

| Next action | Skill |
|---|---|
| Implement a new feature end-to-end | `pa-feature-pipeline` |
| Generate a new module scaffold | `pa-module` or `pa-scaffold` |
| Add a UseCase to an existing Notifier | `pa-handle-usecase` |
| Generate a new UseCase and wire it | `pa-generate-usecase` |
| Generate a new Repository | `pa-repository` |
| Review existing code for issues | `pa-review-code` |

## 2. Verify Before Implementing

Before writing any code based on the module map, run the anti-hallucination check:

```bash
# Verify entity exists
find lib/features/<feature>/domain/entities -name "*.dart"

# Verify Notifier exists
find lib/features/<feature>/presentation/notifiers -name "*.dart"

# Verify providers exist
grep -n "Provider" lib/core/di/providers.dart
```

## 3. Update Map If Stale

If the module map reveals files that have been renamed or deleted since the skill was last run, note the discrepancy and rerun the `find` commands to get the current state before proceeding.
