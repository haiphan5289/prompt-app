# Quality Checklist — Flutter Expert

## Architecture
- [ ] 1. Presentation layer imports Domain only — no `data/` imports in screens or notifiers
- [ ] 2. Domain layer has zero external package imports (no Flutter, Riverpod, Hive)
- [ ] 3. Data layer imports Domain only — no `presentation/` imports
- [ ] 4. Every new UseCase, Repository, DataSource is registered in `lib/core/di/providers.dart`
- [ ] 5. Every new Screen has a `routePath` constant and is registered in `app_router.dart`

## Riverpod
- [ ] 6. All providers use `@riverpod` annotation — no manual `StateNotifierProvider` or `Provider()`
- [ ] 7. `ref.watch` used in `build()` — never `ref.read` for state subscriptions
- [ ] 8. `ref.read` used in callbacks and action methods — never in `build()`
- [ ] 9. Async operations use `AsyncValue.guard()` in Notifier — never raw try/catch that forgets to set error state
- [ ] 10. All `AsyncValue` results handled with `.when(data:, loading:, error:)` — all three cases

## Widget Quality
- [ ] 11. `build()` method is under 50 lines — private widgets extracted by role
- [ ] 12. Every widget that can be `const` uses `const` constructor
- [ ] 13. No business logic inside layout-only widgets
- [ ] 14. `ConsumerStatefulWidget` used only when local state (controller, animation) is needed
- [ ] 15. No `StatefulWidget` used for business logic — that belongs in Notifier

## Async Safety
- [ ] 16. No `BuildContext` used after `await` without `if (!context.mounted) return;`
- [ ] 17. All async `void` methods in Notifier properly set `AsyncLoading` before the operation

## Navigation
- [ ] 18. Navigation uses `context.go()` or `context.push()` — never `Navigator.push` directly

## Storage
- [ ] 19. Hive box opened in `main.dart` before first use
- [ ] 20. `Hive.box()` called on a type-safe box — `Box<T>`, not `Box`

## Code Quality
- [ ] 21. Zero `flutter analyze` warnings
- [ ] 22. `dart format` passes without changes
- [ ] 23. No `print()` calls — `debugPrint()` or logger used
- [ ] 24. No hardcoded colors or font sizes — `Theme.of(context)` tokens used
- [ ] 25. `flutter test` passes

## Domain Model
- [ ] 26. `PromptPattern.template` uses `{{userInput}}` placeholder (not `{userInput}` or `%s`)
- [ ] 27. `TransformResult` contains `originalPrompt`, `enhancedPrompt`, `appliedPattern`, `createdAt`
- [ ] 28. `ExamplePair` contains `input` and `output` fields
