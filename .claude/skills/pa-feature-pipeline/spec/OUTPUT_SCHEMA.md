# Output Schema — Feature Pipeline

## Phase 0 Output

A brief scope plan confirmed by the user before implementation begins:

```
Files to create:
  - lib/features/[feature]/domain/entities/[entity].dart
  - lib/features/[feature]/domain/repositories/[name]_repository.dart
  - lib/features/[feature]/domain/usecases/[name]_use_case.dart
  - lib/features/[feature]/data/repositories/[name]_repository_impl.dart
  - lib/features/[feature]/data/datasources/[name]_local_data_source.dart
  - lib/features/[feature]/presentation/notifiers/[name]_notifier.dart
  - lib/features/[feature]/presentation/screens/[name]_screen.dart
  - lib/features/[feature]/presentation/widgets/[name]_tile.dart
  - test/features/[feature]/domain/usecases/[name]_use_case_test.dart
  - test/features/[feature]/presentation/screens/[name]_screen_test.dart

Files to modify:
  - lib/core/di/providers.dart         (add providers)
  - lib/core/router/app_router.dart    (add route, if new screen)

Providers needed: [list provider names]
Pattern work needed: yes/no
```

## Phase 1 Output

All domain layer files (interfaces only, no implementations):
- Entity class in `domain/entities/`
- Repository abstract interface in `domain/repositories/`
- UseCase class skeleton in `domain/usecases/`

## Phase 2 Output

All implementation files per scope:

| Layer | Files Produced |
|---|---|
| Data | `[name]_repository_impl.dart`, `[name]_local_data_source.dart` |
| Domain | UseCase body implemented |
| Presentation | `[name]_notifier.dart`, `[name]_screen.dart`, widget files |
| DI | Updated `providers.dart`, updated `app_router.dart` |

## Phase 3 Output

Test files:
- `test/features/[feature]/domain/usecases/[name]_use_case_test.dart`
- `test/features/[feature]/presentation/screens/[name]_screen_test.dart`

Terminal output confirming:
```
flutter analyze: 0 warnings
flutter test: all pass
```
