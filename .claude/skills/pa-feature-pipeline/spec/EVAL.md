# Eval — Feature Pipeline Quality Checklist

Run this checklist at the end of Phase 3 before marking a feature complete.

## Analysis and Format (3 items)

- [ ] 1. `flutter analyze lib/` → zero warnings, zero errors
- [ ] 2. `dart format lib/ test/` → no changes needed (output: "Unchanged X files")
- [ ] 3. No `// ignore:` suppression comments added to work around analysis errors

## Tests (4 items)

- [ ] 4. `flutter test` → all tests pass (zero failures, zero errors)
- [ ] 5. Unit tests written for every new UseCase (happy path + error path)
- [ ] 6. Widget test written for every new Screen
- [ ] 7. No tests skipped with `skip:` or `markTestSkipped`

## Navigation and Reachability (2 items)

- [ ] 8. New screen is reachable via GoRouter — route added to `app_router.dart`
- [ ] 9. Happy path works end-to-end: user can navigate to and use the new feature

## Code Hygiene (4 items)

- [ ] 10. No `print()` statements left in any file
- [ ] 11. No `TODO` comments left unresolved
- [ ] 12. No dead code (unused variables, unused imports, unused methods)
- [ ] 13. No hardcoded strings that should be constants or localized

## Architecture Compliance (5 items)

- [ ] 14. Domain entities have no Flutter imports
- [ ] 15. Repository interface lives in `domain/`, implementation lives in `data/`
- [ ] 16. Notifier does not contain business logic — delegates to UseCases only
- [ ] 17. Widgets do not call UseCases directly — always go through Notifier
- [ ] 18. All new Riverpod providers registered in `lib/core/di/providers.dart`

## Feature Acceptance (3 items)

- [ ] 19. All acceptance criteria from the FEATURE input are met
- [ ] 20. Feature tested manually on at least one simulator/device
- [ ] 21. If PATTERN_INVOLVED = yes: pattern appears in UI and transforms correctly
