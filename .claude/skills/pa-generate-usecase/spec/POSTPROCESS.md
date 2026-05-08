# Post-Process — Generate UseCase

## After Wiring the UseCase

### 1. Regenerate Code

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Required after adding a new `@riverpod` provider to `providers.dart`.

### 2. Analyze

```bash
flutter analyze lib/
```

Zero warnings required.

### 3. Format

```bash
dart format lib/features/{{feature}}/ lib/core/di/providers.dart
```

No changes needed after formatting means the code is already clean.

### 4. Run Tests

```bash
flutter test
```

All tests must pass. If new tests were written, confirm they appear in the output.

### 5. Verify Provider Resolves

Add a temporary debug assert or check in the Notifier to confirm the UseCase provider resolves correctly at runtime. Remove after confirming.

### 6. Run the Full Checklist

Work through all 21 items in `EVAL.md` before marking done.

### 7. Consider UI Callsite

If a UI callsite was not yet wired, open `pa-handle-usecase` to add the Notifier method and connect it to the widget.
