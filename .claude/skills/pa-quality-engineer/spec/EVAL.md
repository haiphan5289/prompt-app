# Quality Checklist — pa-quality-engineer

Use this checklist to verify the QE report output is complete and correct.

## Business Requirements Dimension (4 items)

- [ ] 1. Every acceptance criterion in the PRD is individually checked
- [ ] 2. Each criterion is marked as: met / partially met / not met
- [ ] 3. Edge cases explicitly mentioned in the PRD are verified
- [ ] 4. Behavior differences between spec and implementation are described with Expected vs Actual

## Architecture Dimension (4 items)

- [ ] 5. Cross-layer import check was run (`grep` or file inspection)
- [ ] 6. Verified no direct repository calls from Notifiers (UseCase must be intermediary)
- [ ] 7. Verified new providers are registered in `lib/core/di/providers.dart`
- [ ] 8. Domain layer import check run for Flutter/Riverpod package imports

## Riverpod Dimension (6 items)

- [ ] 9. `ref.watch` in callbacks flagged as MAJOR
- [ ] 10. `setState` for business state flagged as MAJOR
- [ ] 11. Missing `AsyncValue.guard()` in Notifiers flagged
- [ ] 12. Direct state mutation flagged
- [ ] 13. Missing `error:` case in `.when()` flagged
- [ ] 14. Missing `part '*.g.dart'` on `@riverpod` providers flagged

## Transformer Logic Dimension (6 items — only if applicable)

- [ ] 15. Unsubstituted `{{variable}}` placeholders checked
- [ ] 16. `rawPrompt.trim()` call verified before injection
- [ ] 17. New pattern completeness checked: id, name, category, template, examples (≥3)
- [ ] 18. Duplicate pattern `id` check performed
- [ ] 19. `TransformResult` history save verified
- [ ] 20. Empty/whitespace input handling verified

## UI Consistency Dimension (6 items)

- [ ] 21. Hardcoded color values (`Colors.blue`, `Color(0x...)`) flagged
- [ ] 22. Hardcoded font sizes flagged
- [ ] 23. Hardcoded EdgeInsets with numeric literals flagged
- [ ] 24. All colors verified against `Theme.of(context).colorScheme.*` or `AppColors.*`
- [ ] 25. All typography verified against `Theme.of(context).textTheme.*`
- [ ] 26. All spacing verified against `AppSpacing.*`

## Test Coverage Dimension (5 items)

- [ ] 27. Every new UseCase has a unit test file
- [ ] 28. Happy path AND error path tested in UseCase tests
- [ ] 29. Every new Screen has a widget test covering loading, data, and error states
- [ ] 30. No real Hive boxes used in tests
- [ ] 31. `flutter test` result checked (zero failures required)

## Report Quality (4 items)

- [ ] 32. Severity summary counts are accurate (CRITICAL/MAJOR/MINOR totals)
- [ ] 33. Every CRITICAL and MAJOR issue has: Problem, Expected, Actual, Fix
- [ ] 34. Passing dimensions listed with brief confirmation note
- [ ] 35. Final recommendation is one of: BLOCK release / Ship with fixes / Ship as-is
