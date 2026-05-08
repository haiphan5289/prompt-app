# Post-Execution Steps — Handle UseCase

## 1. Format
```bash
dart format lib/features/{{feature}}/presentation/notifiers/{{notifier_file}}.dart
```
Zero changes expected if code was generated correctly.

## 2. Analyze
```bash
flutter analyze lib/features/{{feature}}/presentation/
```
Zero warnings required before proceeding.

## 3. Verify Provider Reference
```bash
grep -n "{{USE_CASE_PROVIDER}}" lib/core/di/providers.dart
```
Confirm the provider is found at the expected path.

## 4. Write the Unit Test

Create or update the test file at:
```
test/features/{{feature}}/presentation/notifiers/{{notifier_snake}}_test.dart
```

Minimum test cases:
- Loading state transitions correctly on method call
- Success state: correct `AsyncData` value returned
- Error state: `AsyncError` when UseCase throws

Use `ProviderContainer` with override for the UseCase provider.

## 5. Run Tests
```bash
flutter test test/features/{{feature}}/presentation/notifiers/
```
All tests must pass.

## 6. Wire to UI

If the Notifier method is called from a widget:
- Use `ref.read(notifierProvider.notifier).{{methodName}}(...)` in `onPressed`/`onTap`
- Never `ref.watch` the notifier inside a callback
- Display loading/error state using `AsyncValue.when(...)` in the widget tree

## 7. Cross-reference

If this is the last step in a feature:
- Run `pa-review-code` on the feature folder
- Run `pa-issue-detection` before merging
