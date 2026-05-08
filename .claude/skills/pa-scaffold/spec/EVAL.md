# Quality Checklist — Scaffold

## Pre-Generation
- [ ] 1. Verified target file does not already exist via `find lib/`
- [ ] 2. All three input fields present: `FILE_TYPE`, `NAME`, `FEATURE`
- [ ] 3. `NAME` is PascalCase
- [ ] 4. `FEATURE` matches an existing feature folder or is clearly a new one

## Template Variables
- [ ] 5. `{{Name}}` (PascalCase) substituted correctly in all class names
- [ ] 6. `{{name_snake}}` (snake_case) substituted correctly in file name and `part` directive
- [ ] 7. `{{nameCamel}}` (camelCase) substituted correctly in provider names
- [ ] 8. `{{feature}}` substituted correctly in the file path
- [ ] 9. `{{route}}` is kebab-case and appears in `routePath` constant (Screen only)
- [ ] 10. `{{box_name}}` is snake_case string (DataSource only)

## File Structure
- [ ] 11. Output file path follows the correct layer convention for the `FILE_TYPE`
- [ ] 12. `part` directive filename matches the generated file name exactly (Notifier, Entity)
- [ ] 13. Repository scaffold produces two files: interface in `domain/` and impl in `data/`

## DI Registration
- [ ] 14. Provider registered in `lib/core/di/providers.dart` for UseCase, Repository, DataSource
- [ ] 15. Provider name follows `{{nameCamel}}UseCaseProvider` / `{{nameCamel}}RepositoryProvider` convention

## Router Registration
- [ ] 16. Screen added to `lib/core/router/app_router.dart` as a `GoRoute` (Screen only)
- [ ] 17. `routePath` constant defined on the Screen class (Screen only)

## Code Quality
- [ ] 18. All imports use correct `package:` or relative paths — verified to exist
- [ ] 19. `const` constructor present on every widget scaffold
- [ ] 20. `super.key` in constructor for all widgets
- [ ] 21. No `model` or `effort` frontmatter attributes in SKILL.md files

## Post-Scaffold
- [ ] 22. `build_runner build` command reminder provided (for Notifier, Entity)
- [ ] 23. `flutter analyze lib/` passes on generated file
