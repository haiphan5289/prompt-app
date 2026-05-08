# Execution Workflow — Full Module Generator

## Step 1: Verify Feature Doesn't Already Exist

```bash
find lib/features/<feature_name> -maxdepth 0
```

If the directory exists, stop and notify the user. Use `pa-scaffold` for individual files instead.

## Step 2: Resolve Template Variables

| Variable | Derivation | Example |
|---|---|---|
| `{{feature_name}}` | `FEATURE_NAME` as-is (snake_case) | `bookmark` |
| `{{DisplayName}}` | `DISPLAY_NAME` (PascalCase) | `Bookmark` |
| `{{feature_name_camel}}` | camelCase from `FEATURE_NAME` | `bookmark` / `promptHistory` |
| `{{feature_route}}` | kebab-case from `FEATURE_NAME` | `bookmark` |

## Step 3: Generate All 9 Components in Order

Generate files in dependency order (domain first, data second, presentation last):

1. **Entity** — `lib/features/{{feature_name}}/domain/entities/{{feature_name}}.dart`
2. **Repository Interface** — `lib/features/{{feature_name}}/domain/repositories/{{feature_name}}_repository.dart`
3. **GetUseCase** — `lib/features/{{feature_name}}/domain/usecases/get_{{feature_name}}_use_case.dart`
4. **SaveUseCase** — `lib/features/{{feature_name}}/domain/usecases/save_{{feature_name}}_use_case.dart`
5. **Repository Impl** — `lib/features/{{feature_name}}/data/repositories/{{feature_name}}_repository_impl.dart`
6. **DataSource** — `lib/features/{{feature_name}}/data/datasources/{{feature_name}}_local_data_source.dart`
7. **Notifier** — `lib/features/{{feature_name}}/presentation/notifiers/{{feature_name}}_notifier.dart`
8. **Screen** — `lib/features/{{feature_name}}/presentation/screens/{{feature_name}}_screen.dart`
9. **Card Widget** — `lib/features/{{feature_name}}/presentation/widgets/{{feature_name}}_card.dart`

## Step 4: Register Providers

Add all four providers to `lib/core/di/providers.dart`:
- `{{feature_name_camel}}LocalDataSourceProvider`
- `{{feature_name_camel}}RepositoryProvider`
- `get{{DisplayName}}UseCaseProvider`
- `save{{DisplayName}}UseCaseProvider`

## Step 5: Register Route

Add to `lib/core/router/app_router.dart`:
```dart
GoRoute(
  path: {{DisplayName}}Screen.routePath,
  builder: (_, __) => const {{DisplayName}}Screen(),
),
```

## Step 6: Generate Test Stubs

Create in `test/features/{{feature_name}}/`:
- `domain/usecases/get_{{feature_name}}_use_case_test.dart`
- `presentation/notifiers/{{feature_name}}_notifier_test.dart`

## Step 7: Apply Entity Fields

Replace the `// TODO: add feature-specific fields` placeholder in the entity with the fields from `ENTITY_FIELDS`.

## Step 8: Verify

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze lib/
flutter test
```
