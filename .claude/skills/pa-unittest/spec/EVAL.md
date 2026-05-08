# Quality Checklist — pa-unittest

Use this checklist to verify the generated test file is correct and complete.

## Pre-Generation Checks (3 items)

- [ ] 1. Source file was read before generating tests
- [ ] 2. All constructor parameters and their types were verified from source
- [ ] 3. All public method signatures were verified from source (names, params, return types)

## File Structure (5 items)

- [ ] 4. Test file path mirrors source path: `test/features/<feature>/<layer>/<name>_test.dart`
- [ ] 5. Path comment at top of file matches actual file location
- [ ] 6. Mock classes are defined for each injected dependency
- [ ] 7. `setUp()` initializes all mocks and the class under test
- [ ] 8. `tearDown(() => container.dispose())` present in Notifier tests

## Mock and Import Quality (4 items)

- [ ] 9. `mocktail` used for mocking — not `mockito`
- [ ] 10. No real Hive boxes opened in test setup
- [ ] 11. All imported class names exist in the actual source (no invented names)
- [ ] 12. All stubbed method names match actual interface method names

## Test Case Coverage (6 items)

- [ ] 13. Happy path (success case) tested
- [ ] 14. Error/failure case tested
- [ ] 15. For Notifier: initial state, loading, success, error all covered (≥4 tests)
- [ ] 16. For Transformer UseCase: pattern substitution, trim, history save, error (≥4 tests)
- [ ] 17. For Screen: loading state, data state, error state (≥3 widget tests)
- [ ] 18. Edge case for empty/null input included where relevant

## Test Case Style (4 items)

- [ ] 19. Every test case follows Given-When-Then structure (with comments)
- [ ] 20. Test descriptions are plain English — describe behavior, not implementation
- [ ] 21. No `print()` statements in test files
- [ ] 22. `group()` nesting is used to organize tests by method/behavior

## Widget Test Specifics (3 items — only for Screen/Widget tests)

- [ ] 23. `ProviderScope(overrides: [...])` used to inject mock providers
- [ ] 24. No global provider mutation — all overrides are scoped to the test widget
- [ ] 25. `await tester.pump()` called after state changes before assertions

## Riverpod Notifier Test Specifics (3 items — only for Notifier tests)

- [ ] 26. `ProviderContainer` created in `setUp` with dependency overrides
- [ ] 27. `container.dispose()` called in `tearDown`
- [ ] 28. Loading state verified by NOT awaiting the notifier call before reading state
