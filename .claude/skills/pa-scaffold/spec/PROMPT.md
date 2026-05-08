# Execution Workflow — Scaffold

## Step 1: Verify File Doesn't Already Exist

```bash
find lib/ -name "<name_snake>_<type>.dart"
```

If the file already exists, stop and notify the user. Do not overwrite.

## Step 2: Resolve Template Variables

From the input, derive:

| Variable | Derivation | Example |
|---|---|---|
| `{{Name}}` | PascalCase from `NAME` | `PatternSelector` |
| `{{name_snake}}` | snake_case from `NAME` | `pattern_selector` |
| `{{nameCamel}}` | camelCase from `NAME` | `patternSelector` |
| `{{feature}}` | `FEATURE` field as-is | `transformer` |
| `{{route}}` | kebab-case from `NAME` | `pattern-selector` |
| `{{box_name}}` | snake_case from `NAME` + feature | `pattern_selector` |

## Step 3: Select Template

Choose the template matching `FILE_TYPE`:

| FILE_TYPE | Template | Output Path |
|---|---|---|
| `Screen` | ConsumerWidget + private body widget | `lib/features/{{feature}}/presentation/screens/{{name_snake}}_screen.dart` |
| `Notifier` | AsyncNotifier with `@riverpod` | `lib/features/{{feature}}/presentation/notifiers/{{name_snake}}_notifier.dart` |
| `UseCase` | Plain Dart class with `execute()` | `lib/features/{{feature}}/domain/usecases/{{name_snake}}_use_case.dart` |
| `Repository` | Abstract interface + Impl (two files) | `lib/features/{{feature}}/domain/repositories/` and `lib/features/{{feature}}/data/repositories/` |
| `DataSource` | Hive-backed local data source | `lib/features/{{feature}}/data/datasources/{{name_snake}}_local_data_source.dart` |
| `Entity` | Freezed class | `lib/features/{{feature}}/domain/entities/{{name_snake}}.dart` |
| `Widget` | ConsumerWidget | `lib/features/{{feature}}/presentation/widgets/{{name_snake}}_widget.dart` |

## Step 4: Apply the Template

Substitute all `{{variables}}` in the selected template. See `spec/OUTPUT_SCHEMA.md` for all templates.

## Step 5: Register Provider in DI

After scaffolding any UseCase, Repository, or DataSource, add the corresponding `@riverpod` provider to `lib/core/di/providers.dart`:

```dart
@riverpod
{{Name}}UseCase {{nameCamel}}UseCase({{Name}}UseCaseRef ref) =>
    {{Name}}UseCase(
      repository: ref.watch({{nameCamel}}RepositoryProvider),
    );
```

## Step 6: Register Route (Screen only)

If `FILE_TYPE` is `Screen`, add a `GoRoute` to `lib/core/router/app_router.dart`:

```dart
GoRoute(
  path: {{Name}}Screen.routePath,
  builder: (_, __) => const {{Name}}Screen(),
),
```

## Step 7: Naming Convention Reminder

| Type | Convention | Example |
|---|---|---|
| File | snake_case | `pattern_selector_screen.dart` |
| Class | PascalCase | `PatternSelectorScreen` |
| Provider | camelCase + Provider suffix | `patternSelectorNotifierProvider` |
| Route path | kebab-case | `/pattern-selector` |
| Hive box name | snake_case string | `'prompt_history'` |
