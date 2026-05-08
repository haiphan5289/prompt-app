# Post-Execution Steps — Scaffold

After generating the scaffolded file(s):

## 1. Run Code Generation (if applicable)

For Notifier or Entity files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates the `.g.dart` (Riverpod) and `.freezed.dart` (Freezed) files.

## 2. Static Analysis

```bash
flutter analyze lib/
```

Expected: zero warnings on the new file and no regressions in existing files.

## 3. Fill in TODOs

The scaffolded file contains `// TODO:` markers. Prompt the user (or use `pa-flutter-expert-skill`) to fill in:
- Provider watch in Screen's `build()`
- Body implementation in Screen's private widget
- UseCase `execute()` method body
- Entity fields beyond `id` and `createdAt`
- Widget `build()` implementation

## 4. Confirm DI Registration

Open `lib/core/di/providers.dart` and confirm the new provider(s) were added:

```bash
grep -n "{{nameCamel}}" lib/core/di/providers.dart
```

## 5. Confirm Route Registration (Screen only)

```bash
grep -n "{{Name}}Screen" lib/core/router/app_router.dart
```

## 6. Open Hive Box in main.dart (DataSource only)

If a new DataSource was scaffolded, remind the user to open the box in `main.dart`:

```dart
await Hive.openBox('{{box_name}}');
```

## 7. Run Tests

```bash
flutter test
```

All existing tests must still pass after scaffolding.
