# Execution Workflow — pa-issue-detection

## Step 1: Get Changed Files

```bash
# Get all changed Dart files on this branch vs main
git diff main...HEAD --name-only | grep '\.dart$'
```

If no branch is specified, default to `main...HEAD`.

## Step 2: Read Every Changed File

Read each Dart file from the list. Do not skip any file — every changed file must be scanned.

## Step 3: Scan for All 12 Risk Patterns

For each file, check all 12 patterns defined below:

### P01 — Unguarded Bang Operator (HIGH)
```dart
// Crashes at runtime
final result = state.value!;
final item = list[index]!;
```
Flag any `!` not followed by a `// safe:` comment on the same line.

### P02 — BuildContext After Await (HIGH)
```dart
// Context may be invalid after async gap
await someOperation();
Navigator.of(context).push(...);
```
Flag any `await` followed by `context.` without `if (!context.mounted) return;` between them.

### P03 — ref.watch in Callback (HIGH)
```dart
// Causes provider rebuild loop
onTap: () {
  final val = ref.watch(someProvider); // wrong
}
```
Flag `ref.watch` inside any callback/closure that is not a `build()` method.

### P04 — Direct State Mutation (HIGH)
```dart
// Riverpod won't detect this
state.items.add(newItem);
state.isLoading = true;
```
Flag `state.` followed by `.add(`, `.remove(`, `.clear(`, or `=` (direct field assignment) without going through `state = state.copyWith(...)`.

### P05 — Missing AsyncValue Error Case (MEDIUM)
```dart
// Silent error swallowing
state.when(
  data: (d) => Widget(),
  loading: () => Spinner(),
  // no error: case!
);
```
Flag `.when(` calls missing an `error:` parameter.

### P06 — Unsubstituted Template Variable (HIGH)
```dart
// Raw {{variable}} ends up in enhanced prompt
final result = pattern.template; // never substituted
```
Flag any string containing `{{` that is returned or assigned without a `.replaceAll` chain.

### P07 — Missing Trim on User Input (MEDIUM)
```dart
// Whitespace pollutes pattern output
pattern.template.replaceAll('{{userInput}}', rawPrompt); // no trim
```
Flag `replaceAll('{{userInput}}',` where the value argument does not call `.trim()`.

### P08 — print() in Production Code (LOW)
```dart
// Leaks to console in release builds
print('debug: $value');
```
Flag any `print(` outside the `test/` directory.

### P09 — Hive Box Accessed Before Open (HIGH)
```dart
// Throws HiveError
final box = Hive.box('history'); // box might not be open
```
Flag `Hive.box(` in non-main files without verifying `openBox` is called first in the app startup sequence.

### P10 — Missing Part Directive for Riverpod (HIGH — build error)
```dart
// Generated code not found
@riverpod
class MyNotifier extends _$MyNotifier { // missing: part 'my_notifier.g.dart';
```
Flag `@riverpod` annotation without a corresponding `part '*.g.dart';` in the same file.

### P11 — StatefulWidget for Business Logic (MEDIUM)
```dart
// Anti-pattern: business state in widget
void _fetchData() => setState(() { _data = ...; }); // should be in Notifier
```
Flag `setState` calls that update non-UI state. UI state = TextEditingController, FocusNode, AnimationController, scroll position. Everything else is business state.

### P12 — Navigator.push Instead of GoRouter (LOW)
```dart
// Bypasses app routing
Navigator.of(context).push(MaterialPageRoute(...));
```
Flag any `Navigator.of(context).push` — should use `context.go()` or `context.push()`.

## Step 4: Classify Issues by Risk

- **HIGH** — crash risk or build error: P01, P02, P03, P04, P06, P09, P10
- **MEDIUM** — silent bugs or anti-patterns: P05, P07, P11
- **LOW** — style/routing conventions: P08, P12

## Step 5: Output Scan Report

Emit report in the format defined in [OUTPUT_SCHEMA.md](OUTPUT_SCHEMA.md).
