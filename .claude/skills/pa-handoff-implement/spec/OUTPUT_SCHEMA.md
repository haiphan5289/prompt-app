# Output Schema — Handoff Implement

## Deliverables

A complete implementation consisting of:

| Deliverable | Description |
|---|---|
| Changed/created source files | All `.dart` files needed to fulfill the spec |
| `flutter analyze` passing | Zero warnings across all changed files |
| At least one test | Covers the main new behavior introduced |
| Spec validation report | Confirms each spec requirement is met |

## Spec Validation Report Format

After implementation, produce:

```
## Spec Validation

| Requirement | Implemented | Notes |
|---|---|---|
| [req 1 from handoff] | yes / no | [file or reason] |
| [req 2 from handoff] | yes / no | [file or reason] |
...
```

## File Change Summary Format

```
## Files Changed
- lib/features/[feature]/domain/entities/[file].dart — [new | modified]: [reason]
- lib/features/[feature]/data/datasources/[file].dart — [new | modified]: [reason]
- lib/core/di/providers.dart — modified: registered [ProviderName]
- lib/features/[feature]/presentation/notifiers/[file].dart — [new | modified]: [reason]
- lib/features/[feature]/presentation/screens/[file].dart — [new | modified]: [reason]
- lib/features/[feature]/presentation/widgets/[file].dart — [new | modified]: [reason]
- test/[path]/[file]_test.dart — new: [what it tests]
```

## Constraints

- Every file path must be a real path that exists (or will exist after creation) in the project.
- No files outside `lib/` or `test/` should be modified unless explicitly required.
- The implementation must not break existing tests.
