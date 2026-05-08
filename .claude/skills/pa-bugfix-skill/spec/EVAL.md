# Quality Checklist — Bug Fix

Run before marking a fix complete.

## Scope
- [ ] 1. Read no more than 3–4 files directly involved in the bug
- [ ] 2. Did not explore entire feature folders or unrelated providers
- [ ] 3. Did not read third-party package source

## Root Cause
- [ ] 4. Root cause stated in exactly one sentence before any code was proposed
- [ ] 5. Root cause identifies the specific mechanism (not just "state not updating")
- [ ] 6. Root cause is supported by evidence from the files read

## Fix Quality
- [ ] 7. Fix targets only the root cause — no unrelated refactoring
- [ ] 8. Fix is the minimal change needed (single line or a few lines)
- [ ] 9. Did not rewrite the entire Notifier or surrounding code
- [ ] 10. Did not change architecture patterns as part of the fix
- [ ] 11. Did not upgrade packages as a "fix"

## Riverpod Correctness
- [ ] 12. No `ref.read` inside `build()` — uses `ref.watch` for all state reads
- [ ] 13. No direct state mutation — always `state = state.copyWith(...)`
- [ ] 14. `AsyncValue` handled with `.when(data:, loading:, error:)` — all three cases

## Async Safety
- [ ] 15. No `BuildContext` used after `await` without an `if (!context.mounted) return;` guard
- [ ] 16. All async calls have `await` — no fire-and-forget on async operations that affect state

## Transformer Correctness
- [ ] 17. Pattern template uses `replaceAll('{{userInput}}', rawInput.trim())` — no literal placeholders in output
- [ ] 18. Pattern ID is validated before `getById` is called

## Verification
- [ ] 19. `flutter analyze lib/` passes with zero warnings
- [ ] 20. `dart format --output=none --set-exit-if-changed lib/` passes
- [ ] 21. Relevant tests pass (`flutter test`)
- [ ] 22. Data flow traced end-to-end — each arrow in the flow confirmed

## Summary
- [ ] 23. "What was broken" provided in one sentence
- [ ] 24. "Why" mechanism explained
- [ ] 25. "Fix" described with code diff
- [ ] 26. "How to verify" steps listed
