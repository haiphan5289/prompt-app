# Eval — pa-git-diff

Quality checklist for diff analysis output. Every item must be evaluated against actual diff content. Mark `[x]` for pass, `[ ]` for fail or not applicable.

## Architecture

- [ ] 1. No cross-layer imports detected (Presentation→Data is forbidden)
- [ ] 2. Domain layer has no external package imports (only dart core + equatable/freezed)
- [ ] 3. New UseCases are injected via Riverpod providers, not instantiated directly
- [ ] 4. Repository interfaces are defined in domain, implementations live in data

## Patterns (apply only if pattern files changed)

- [ ] 5. Every new pattern has all required fields: `id`, `name`, `category`, `template`, `examples`
- [ ] 6. `{{userInput}}` placeholder is present in every pattern template
- [ ] 7. No duplicate pattern `id` values in seed data
- [ ] 8. Pattern category is one of the defined enum values (not a free string)

## Riverpod

- [ ] 9. New providers are annotated with `@riverpod` and have matching `part '*.g.dart'`
- [ ] 10. `ref.watch` is used only inside `build()` methods
- [ ] 11. `ref.read` is used only inside callbacks and event handlers
- [ ] 12. No `StateNotifier` used (project uses code-gen Notifier)

## Code Quality

- [ ] 13. `flutter analyze` would pass (no obvious lint violations visible in diff)
- [ ] 14. Dart formatting appears correct (consistent indentation, trailing commas)
- [ ] 15. No commented-out code blocks left in diff
- [ ] 16. No hardcoded strings in UI — all user-facing text uses localisation or constants

## Tests

- [ ] 17. New screens added in presentation have corresponding widget tests
- [ ] 18. New UseCases have unit tests
- [ ] 19. New repositories have unit tests with mocked datasources
- [ ] 20. Test files follow naming convention `*_test.dart`

## PR Description Quality

- [ ] 21. "What" section clearly states what changed (not just file names)
- [ ] 22. "Why" section references the feature or ticket motivation
- [ ] 23. "Test Plan" contains at least one manual step and `flutter test`
- [ ] 24. PR description is free of sensitive business data (revenue, OKRs, competitor names)

## Completeness

- [ ] 25. All changed files appear in at least one layer section
- [ ] 26. Summary insertion/deletion counts match git stat output
- [ ] 27. Suggested Next Steps lists every `// TODO` found in the diff
- [ ] 28. If `--focus` flag was used, only the requested layer is shown
