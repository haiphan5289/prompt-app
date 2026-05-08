# Quality Checklist — Anti-Hallucination

Run after producing any verification report or generated code.

## Package Verification
- [ ] 1. Every `import 'package:...'` statement has been checked against `pubspec.yaml`
- [ ] 2. No package is imported that is absent from `pubspec.yaml`
- [ ] 3. If a package is missing, it is flagged with a suggested `pubspec.yaml` addition

## Provider Verification
- [ ] 4. Every Riverpod provider name referenced has been confirmed via `grep -r "<name>" lib/`
- [ ] 5. No provider name is assumed or invented without grep confirmation
- [ ] 6. If a provider is missing, it is either scaffolded first or the user is asked to confirm

## Domain Model Verification
- [ ] 7. Every class name used in generated code has been confirmed to exist via `grep -r "class <Name>" lib/`
- [ ] 8. Every field name accessed has been confirmed by reading the actual model file
- [ ] 9. No field is assumed based on "reasonable guessing" — only verified fields are used

## File Path Verification
- [ ] 10. Every import path has been verified via `find lib/ -name "<filename>.dart"`
- [ ] 11. No `package:` import path is constructed without confirming the file exists

## Method Signature Verification
- [ ] 12. Every repository or use case method call has been verified against its actual signature
- [ ] 13. Parameter names, types, and return types match the actual method declaration

## Riverpod Usage Correctness
- [ ] 14. `ref.watch` is used inside `build()`, never `ref.read`
- [ ] 15. `ref.read` is used inside callbacks and action methods, never inside `build()`
- [ ] 16. `AsyncValue` is always handled with `.when(data:, loading:, error:)`
- [ ] 17. `BuildContext` is never used after `await` without a `mounted` check

## Report Quality
- [ ] 18. Verification report is produced before any code is emitted
- [ ] 19. Every symbol appears in the report with its status (VERIFIED / NOT FOUND / NEEDS SCAFFOLD / FLAGGED)
- [ ] 20. Any blocked symbol results in a clear `[BLOCKED]` message with an action required
