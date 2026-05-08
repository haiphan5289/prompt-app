# Quality Checklist — Full Module Generator

## Pre-Generation
- [ ] 1. Feature folder confirmed absent via `find lib/features/<feature_name> -maxdepth 0`
- [ ] 2. All four input fields provided: `FEATURE_NAME`, `DISPLAY_NAME`, `PURPOSE`, `ENTITY_FIELDS`
- [ ] 3. `FEATURE_NAME` is snake_case
- [ ] 4. `DISPLAY_NAME` is PascalCase and matches `FEATURE_NAME` semantically

## File Count
- [ ] 5. Exactly 9 source files generated (entity, repo interface, 2 usecases, repo impl, datasource, notifier, screen, card widget)
- [ ] 6. Exactly 2 test stub files generated (usecase test, notifier test)

## Domain Layer
- [ ] 7. Entity uses `@freezed` annotation
- [ ] 8. All `ENTITY_FIELDS` appear as `required` fields in entity (between `id` and `createdAt`)
- [ ] 9. Repository interface uses `abstract interface class` syntax
- [ ] 10. Both `Get` and `Save` usecases generated with correct naming

## Data Layer
- [ ] 11. Repository impl delegates all methods to DataSource
- [ ] 12. DataSource `_boxName` is the snake_case `FEATURE_NAME`
- [ ] 13. DataSource `fetchAll()` sorts by `createdAt` descending

## Presentation Layer
- [ ] 14. Notifier's `build()` calls `Get{{DisplayName}}UseCase.execute()`
- [ ] 15. Notifier's `save()` calls `Save{{DisplayName}}UseCase.execute()` then `ref.invalidateSelf()`
- [ ] 16. Screen uses `ref.watch({{feature_name_camel}}NotifierProvider)` with full `.when()` handling
- [ ] 17. Screen has `static const routePath` constant
- [ ] 18. All three `AsyncValue` cases handled: `data`, `loading`, `error`

## DI & Router
- [ ] 19. Four providers added to `lib/core/di/providers.dart`
- [ ] 20. Route added to `lib/core/router/app_router.dart`
- [ ] 21. `Hive.openBox('{{feature_name}}')` reminder provided for `main.dart`

## Code Quality
- [ ] 22. Layer boundaries respected — no cross-layer imports
- [ ] 23. All `const` constructors present
- [ ] 24. `build()` methods under 50 lines
- [ ] 25. Zero `flutter analyze` warnings after `build_runner build`
- [ ] 26. `flutter test` passes (stubs compile without errors)
