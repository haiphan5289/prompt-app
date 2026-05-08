# Guardrails — pa-quality-engineer

## Anti-Hallucination Rules

- **Read files before evaluating.** Never assume what code does without reading it.
- **Run grep commands before flagging issues.** Do not guess whether a pattern exists — check.
- **Do not invent acceptance criteria.** Only validate against what the PRD actually states.
- **Do not assume tests exist.** Run `find test/` to verify test file presence before marking dimension as PASS.
- **Do not mark Transformer dimension as applicable** unless the TARGET explicitly includes `transformer/` or `pattern_library/` code.

## Prohibited Behaviors

- Marking a dimension PASS without having inspected the relevant files
- Classifying a MINOR issue as CRITICAL to justify a BLOCK recommendation
- Reporting "no issues" without running the prescribed grep commands
- Inventing file paths or line numbers not observed from actual file reads
- Flagging violations in files outside the TARGET scope

## Severity Classification Rules

Use these rules to avoid mis-classifying issues:

| Issue Type | Correct Severity |
|---|---|
| Unmet acceptance criterion | CRITICAL |
| Crash-risk code (null bang, context after await) | CRITICAL |
| Cross-layer import | MAJOR |
| Missing UseCase for business logic | MAJOR |
| Missing unit or widget test | MAJOR |
| `ref.watch` in callback | MAJOR |
| Missing `const` constructor | MINOR |
| `build()` method slightly over 50 lines | MINOR |
| Hardcoded color | MINOR |
| Missing `AppSpacing.*` constant | MINOR |

## Verified Command Patterns

These grep commands are safe to run for this project:

```bash
# Architecture — cross-layer imports
grep -r "import.*data/" lib/features/*/presentation/
grep -r "import.*presentation/" lib/features/*/domain/

# Riverpod — ref misuse
grep -n "ref\.watch" lib/features/*/presentation/
grep -n "setState" lib/features/*/presentation/

# UI — hardcoded values
grep -n "Color(0x\|Colors\." lib/features/*/presentation/
grep -n "fontSize:\|EdgeInsets.all([0-9]" lib/features/*/presentation/

# Transformer — unsubstituted placeholders
grep -n "{{" lib/features/transformer/
grep -n "replaceAll" lib/features/transformer/domain/usecases/

# Tests — find test files
find test/features/ -name "*_test.dart" | sort
```
