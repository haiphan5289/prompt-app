# Eval — Generate UseCase Quality Checklist

Run this checklist after generating and wiring the UseCase.

## UseCase Class (6 items)

- [ ] 1. File is located in `lib/features/{{feature}}/domain/usecases/`
- [ ] 2. Class name is `{{UseCaseName}}UseCase` (PascalCase + "UseCase" suffix)
- [ ] 3. Constructor uses a `required` named parameter for the repository
- [ ] 4. The single public method is named `execute`
- [ ] 5. No business logic — body delegates directly to repository method
- [ ] 6. No Flutter imports — domain layer only uses Dart core

## Provider Registration (3 items)

- [ ] 7. Provider added to `lib/core/di/providers.dart`
- [ ] 8. Provider name is `{{useCaseCamel}}UseCaseProvider`
- [ ] 9. Provider reads the repository via `ref.watch({{featureCamel}}RepositoryProvider)`

## Notifier Method (4 items)

- [ ] 10. Method added to the correct Notifier class
- [ ] 11. `AsyncValue.guard()` wraps the async call
- [ ] 12. Correct variant used (`replace_state` / `invalidate_self` / `append_to_list`)
- [ ] 13. `ref.read` used for the UseCase provider (not `ref.watch`)

## Repository (2 items)

- [ ] 14. If the repository method was missing: it is now in both interface and implementation
- [ ] 15. Repository method signature matches the `METHOD` input exactly

## Build and Analysis (4 items)

- [ ] 16. `flutter pub run build_runner build` completes without errors
- [ ] 17. `flutter analyze lib/` → zero warnings
- [ ] 18. `dart format` → no changes needed
- [ ] 19. `flutter test` → all tests pass

## Tests (2 items)

- [ ] 20. Unit test written for the happy path (repository returns success)
- [ ] 21. Unit test written for the error path (repository throws, UseCase propagates)
