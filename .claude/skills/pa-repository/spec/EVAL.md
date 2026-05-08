# Quality Checklist — pa-repository

## Architecture
- [ ] 1. Domain interface lives in `domain/repositories/`, implementation in `data/repositories/`
- [ ] 2. Interface uses `abstract interface class`, not `abstract class`
- [ ] 3. Only the requested `OPERATIONS` are generated — no extra methods added
- [ ] 4. No business logic in the implementation — all methods are thin delegates
- [ ] 5. Implementation delegates to DataSource only, not to other Repositories

## Domain Purity
- [ ] 6. Domain interface file has no Flutter or external package imports
- [ ] 7. Entity class is imported from `domain/entities/`, not from `data/`
- [ ] 8. No `Hive`, `Dio`, `http`, or other infrastructure imports in the interface file

## Data Layer
- [ ] 9. `RepositoryImpl` class name follows `{{Name}}RepositoryImpl` convention
- [ ] 10. `const` constructor used in `RepositoryImpl`
- [ ] 11. DataSource field uses the correct type name (`{{Name}}LocalDataSource`)
- [ ] 12. All delegated method names match the DataSource contract

## Riverpod
- [ ] 13. Provider is decorated with `@riverpod`
- [ ] 14. Provider uses `ref.watch` (not `ref.read`) for the DataSource dependency
- [ ] 15. Provider function name follows `{{nameCamel}}Repository` convention
- [ ] 16. Provider return type matches the abstract interface, not the impl

## Code Quality
- [ ] 17. `dart format` passes with zero changes
- [ ] 18. `flutter analyze` passes with zero warnings
- [ ] 19. Entity verified to exist before file creation
- [ ] 20. DataSource provider confirmed to exist in `providers.dart`
