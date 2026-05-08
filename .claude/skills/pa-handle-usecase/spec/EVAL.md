# Quality Checklist — Handle UseCase

Run through every item before marking the task complete.

## Architecture
- [ ] 1. Method is added to an `AsyncNotifier` or `Notifier`, never to a Widget
- [ ] 2. `RETURN_BEHAVIOR` matches the actual state type of the Notifier
- [ ] 3. No business logic inside the Notifier method — delegate entirely to the UseCase
- [ ] 4. UseCase provider is read with `ref.read()`, not `ref.watch()`

## AsyncValue Handling
- [ ] 5. Loading state set with `state = const AsyncLoading()` before any async call
- [ ] 6. `AsyncValue.guard()` wraps the async operation (no manual try/catch)
- [ ] 7. `append_to_list` variant captures `state.valueOrNull` before setting loading
- [ ] 8. `invalidate_self` variant calls `ref.invalidateSelf()` after the guard, not inside it

## Provider Verification
- [ ] 9. `USE_CASE_PROVIDER` confirmed to exist in `lib/core/di/providers.dart` before use
- [ ] 10. UseCase class name confirmed to exist before referencing
- [ ] 11. No new providers created by this skill — only consumes existing ones

## Dart / Flutter
- [ ] 12. Method signature uses correct param types as specified in `PARAMS`
- [ ] 13. `async` keyword present on the method
- [ ] 14. Return type is `Future<void>` for all variants
- [ ] 15. No `await` outside `AsyncValue.guard` call

## Code Quality
- [ ] 16. `dart format` passes with zero diff
- [ ] 17. `flutter analyze` on the Notifier file passes with zero warnings
- [ ] 18. Method is placed at the bottom of the class, after existing methods
- [ ] 19. No duplicate method names in the Notifier class
- [ ] 20. `reset()` helper only added when explicitly requested
