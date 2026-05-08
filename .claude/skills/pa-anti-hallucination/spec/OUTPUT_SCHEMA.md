# Output Schema — Anti-Hallucination

This skill produces a verification report before code generation proceeds.

## Output Format

### Verification Report (inline, before any code)

```
## Symbol Verification

| Symbol | Type | Status | Source |
|---|---|---|---|
| flutter_riverpod | package | VERIFIED | pubspec.yaml line 12 |
| patternRepositoryProvider | provider | VERIFIED | lib/core/di/providers.dart |
| PromptPattern.template | field | VERIFIED | lib/features/transformer/domain/entities/prompt_pattern.dart |
| historyRepository.save | method | VERIFIED | lib/features/history/domain/repositories/history_repository.dart |
```

### Status Values

| Status | Meaning |
|---|---|
| `VERIFIED` | Found in codebase via grep/find |
| `NOT FOUND` | Could not locate — do not use |
| `NEEDS SCAFFOLD` | Does not exist yet — scaffold first |
| `FLAGGED` | Exists but signature differs from assumption |

## Blocked Output

If any symbol is `NOT FOUND` or `NEEDS SCAFFOLD`, the skill blocks code generation and outputs:

```
[BLOCKED] Cannot generate code: <symbol> could not be verified.
Action required: <scaffold it | confirm correct name | add to pubspec.yaml>
```
