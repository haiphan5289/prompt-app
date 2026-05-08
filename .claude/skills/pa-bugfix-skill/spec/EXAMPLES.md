# Examples — Bug Fix

## Example 1: `ref.read` in `build()` — No Rebuild

**Input:**
```
BUG: Widget not rebuilding
SYMPTOM: Transform button tapped but result card stays empty
FILES: lib/features/transformer/presentation/screens/home_screen.dart
```

**Root cause:** `ref.read(transformerNotifierProvider)` inside `build()` gives a snapshot with no subscription — the widget never rebuilds.

**Fix:**
```dart
// Bad — no reactivity
final state = ref.read(promptNotifierProvider);

// Good
final state = ref.watch(promptNotifierProvider);
```

**Verification:** Hot restart → tap Transform → loading indicator appears → result populates.

---

## Example 2: `BuildContext` After `await`

**Input:**
```
BUG: Async error
SYMPTOM: App crashes after transform completes with "Looking up a deactivated widget's ancestor is unsafe"
ERROR: FlutterError: Looking up a deactivated widget's ancestor is unsafe.
FILES: lib/features/transformer/presentation/notifiers/transformer_notifier.dart
```

**Root cause:** `Navigator.of(context)` is called after an `await` without checking `context.mounted`, so context may be invalid if the widget was disposed during the async gap.

**Fix:**
```dart
// Bad
await someAsyncCall();
Navigator.of(context).push(...);

// Good
await someAsyncCall();
if (!context.mounted) return;
Navigator.of(context).push(...);
```

**Verification:** Navigate away mid-transform → no crash.

---

## Example 3: Pattern Template with Unsubstituted Variables

**Input:**
```
BUG: Transformer wrong output
SYMPTOM: Enhanced prompt still contains "{{userInput}}" literally in the output
FILES: lib/features/transformer/domain/usecases/transform_use_case.dart
```

**Root cause:** `_applyPattern` returns `pattern.template` directly without calling `replaceAll`, so the placeholder is never substituted.

**Fix:**
```dart
// Bad — {{userInput}} left in output
final result = pattern.template;

// Good
final result = pattern.template.replaceAll('{{userInput}}', rawInput.trim());
```

**Verification:** Enter "write me an email" → result contains actual prompt text, not `{{userInput}}`.
