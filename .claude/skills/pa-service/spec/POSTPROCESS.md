# Post-Execution Steps — pa-service

After generating all service files, complete these steps in order.

## 1. Run Code Generation

If using `@riverpod` annotations, run build_runner:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Verify the `.g.dart` file was generated alongside the providers file.

## 2. Run Static Analysis

```bash
flutter analyze lib/features/{{feature}}/
```

Fix any errors before proceeding. Common issues:
- Missing `part` directive for `.g.dart` file
- Wrong import paths (check relative vs package imports)
- `Ref` type name mismatch in generated code

## 3. Register the Feature (if new)

If this is a new feature folder, ensure the feature is registered:
- Add the provider to the app's dependency graph (if needed)
- Confirm `lib/features/{{feature}}/` is not excluded from analysis

## 4. Wire to Notifier

In the feature Notifier, add the service call:

```dart
// In your Notifier method
Future<void> transform(String prompt) async {
  state = const AsyncValue.loading();
  state = await AsyncValue.guard(
    () => ref.read(patternSuggestionServiceProvider).suggestPattern(
      SuggestPatternRequest(prompt: prompt),
    ).then((response) => /* map to domain model */),
  );
}
```

## 5. Environment Variable Setup

Confirm the API key environment variable is configured:

- For local development: `flutter run --dart-define=API_KEY=your_key_here`
- For CI/CD: add `API_KEY` to the secrets store
- For release builds: confirm `--dart-define` is passed in the build script

## 6. Integration Test (manual)

Run the app and trigger the feature:
- Confirm the network call is made (check with a proxy or logs)
- Confirm the response is parsed correctly
- Confirm the UI updates with the result

## 7. Link to Issue / PR

Reference the Jira/Linear ticket in the PR description so the change is traceable.
