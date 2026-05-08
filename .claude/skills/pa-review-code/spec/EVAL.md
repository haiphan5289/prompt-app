# Quality Checklist — pa-review-code

Use this checklist to verify the review output is complete and correct.

## Architecture (7 items)

- [ ] 1. Checked that presentation does not import from `data/` layer
- [ ] 2. Checked that domain has zero external package imports (no Flutter, no Riverpod)
- [ ] 3. Verified data layer only implements domain interfaces — no new contracts defined there
- [ ] 4. Verified UseCases contain business logic — not Notifiers, not Repositories
- [ ] 5. Verified Repositories are behind abstract interfaces (`abstract interface class`)
- [ ] 6. Verified files placed in correct feature folder (`transformer/`, `pattern_library/`, `history/`)
- [ ] 7. Flagged any Notifier that calls repository directly (bypassing UseCase)

## Riverpod (8 items)

- [ ] 8. Verified `ref.watch` used only in `build()`, `ref.read` used only in callbacks
- [ ] 9. No `ref.watch` inside callbacks (`onTap`, button handlers, etc.)
- [ ] 10. `AsyncNotifier` used for async operations, `Notifier` for sync state
- [ ] 11. `state = state.copyWith(...)` used — never direct mutation (`state.field = ...`)
- [ ] 12. `AsyncValue.guard()` wraps all async calls in Notifiers
- [ ] 13. `.when(data:, loading:, error:)` handles all three cases in UI
- [ ] 14. Providers annotated with `@riverpod` and `part '*.g.dart'` declared
- [ ] 15. No `ProviderContainer` created manually in widgets

## Null Safety (5 items)

- [ ] 16. No `!` (bang operator) without a `// safe: [reason]` comment
- [ ] 17. No `late` without initialization guarantee
- [ ] 18. `BuildContext` after `await` always guarded with `if (!mounted) return` or `if (!context.mounted) return`
- [ ] 19. `AsyncValue.value` not accessed without `.hasValue` check
- [ ] 20. Nullable parameters have defaults or explicit handling

## Widget (6 items)

- [ ] 21. `build()` method under 50 lines — extractable sections identified if over limit
- [ ] 22. All extractable widgets use `const` constructor
- [ ] 23. `ConsumerWidget` used (not `StatelessWidget`) when reading providers
- [ ] 24. `ConsumerStatefulWidget` used only when local state AND provider state are both needed
- [ ] 25. No `StatefulWidget` for business/app state
- [ ] 26. Widget tree depth is reasonable — unnecessary nesting flagged

## Performance (5 items)

- [ ] 27. `const` constructor on every qualifying widget
- [ ] 28. `ListView.builder` used for dynamic lists (not `ListView` with `.map`)
- [ ] 29. No `MediaQuery.of(context)` deep in widget trees
- [ ] 30. No expensive computation inside `build()` — pre-computed in Notifier

## Domain Logic / Transformer (6 items — only if transformer code changed)

- [ ] 31. All `{{variable}}` placeholders in pattern templates are substituted in `_applyPattern()`
- [ ] 32. `rawPrompt.trim()` called before injection (no leading/trailing whitespace)
- [ ] 33. New patterns have `id`, `name`, `category`, `template`, `examples` all populated
- [ ] 34. Pattern `id` is unique (checked for duplicate ids in `PatternLocalDataSource`)
- [ ] 35. At least 3 example pairs per new pattern
- [ ] 36. `TransformResult` is saved to history after every successful transformation

## Tests (5 items)

- [ ] 37. Every new UseCase has a unit test
- [ ] 38. Main Screen has a widget test
- [ ] 39. Transformer logic has input/output tests for each pattern
- [ ] 40. Tests do not depend on real Hive boxes (use mocks or in-memory fakes)
- [ ] 41. No `print()` in test files

## Review Output Quality (4 items)

- [ ] 42. Each issue includes file path and line number
- [ ] 43. Each issue includes a specific, actionable fix — not vague advice
- [ ] 44. Dimension ratings (PASS/WARN/FAIL) are assigned for every applicable dimension
- [ ] 45. Final recommendation is one of: BLOCK merge / merge with fixes noted / safe to merge
