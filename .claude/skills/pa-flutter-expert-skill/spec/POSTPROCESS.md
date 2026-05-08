# Post-Execution Steps — Flutter Expert

After generating any Flutter code:

## 1. Generate Code (if using annotations)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Required after creating or modifying any file with `@riverpod`, `@freezed`, or `@HiveType` annotations.

## 2. Static Analysis

```bash
flutter analyze lib/
```

Expected: zero warnings. Fix every warning before proceeding — treat warnings as errors.

## 3. Format

```bash
dart format lib/ test/
```

## 4. Run Tests

```bash
flutter test
```

All existing tests must pass. If a new feature was added, note which tests should be written (use `pa-unittest` skill).

## 5. Verify DI Registration

Confirm every new class that needs a provider has an entry in `lib/core/di/providers.dart`:
- UseCase provider
- Repository provider
- DataSource provider

## 6. Verify Route Registration

If a new Screen was created, confirm it appears in `lib/core/router/app_router.dart` as a `GoRoute`.

## 7. Verify Hive Box

If a new entity is persisted with Hive:
- Adapter registered with `Hive.registerAdapter()`
- Box opened with `await Hive.openBox(...)` in `main.dart`
- `_boxName` constant in the DataSource matches the box name in `main.dart`

## 8. Confirm Layer Boundaries

Do a final import check on each generated file:
- Presentation files: no imports from `data/`
- Domain files: no imports from Flutter, Riverpod, Hive, or `data/`
- Data files: no imports from `presentation/`
