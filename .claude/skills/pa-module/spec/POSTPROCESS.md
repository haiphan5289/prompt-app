# Post-Execution Steps — Full Module Generator

After generating all module files:

## 1. Open Hive Box in main.dart

Add before `runApp(...)`:

```dart
await Hive.openBox('{{feature_name}}');
```

Also register the Hive type adapter if the entity uses `@HiveType`:

```dart
Hive.registerAdapter({{DisplayName}}Adapter());
```

## 2. Run Code Generation

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Generates:
- `{{feature_name}}.freezed.dart` (from `@freezed` entity)
- `{{feature_name}}_notifier.g.dart` (from `@riverpod` notifier)

## 3. Static Analysis

```bash
flutter analyze lib/
```

Expected: zero warnings across all generated files and no regressions in existing files.

## 4. Format

```bash
dart format lib/ test/
```

## 5. Run Tests

```bash
flutter test
```

The generated test stubs should compile. Fill in actual test logic using `pa-unittest`.

## 6. Fill in Card Widget

The `{{feature_name}}_card.dart` widget is generated with a `// TODO: implement` stub. Use `pa-scaffold` or `pa-flutter-expert-skill` to implement the card UI.

## 7. Verify All Registrations

```bash
grep -n "{{feature_name_camel}}" lib/core/di/providers.dart
grep -n "{{DisplayName}}Screen" lib/core/router/app_router.dart
grep -n "{{feature_name}}" main.dart
```

All three should return at least one match.

## 8. Navigation Entry Point

Decide where in the app a user can navigate to the new screen and add the navigation call:

```dart
context.go({{DisplayName}}Screen.routePath);
// or
context.push({{DisplayName}}Screen.routePath);
```
