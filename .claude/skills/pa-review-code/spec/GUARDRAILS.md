# Guardrails — pa-review-code

## Anti-Hallucination Rules

- **Read files before reviewing.** Never assume what a file contains. If you have not read the file, you cannot review it.
- **Do not invent line numbers.** Only cite line numbers you observed from actually reading the file.
- **Do not assume class/method names.** Read the actual Dart source to find exact names before referencing them.
- **Do not assume test coverage.** Run or list test files to verify they exist — do not assume tests exist because the feature exists.

## Prohibited Patterns in Review Suggestions

Never suggest these as fixes — they are themselves anti-patterns:

```dart
// PROHIBITED: Suggest ProviderContainer in widget
ProviderContainer().read(someProvider); // manual container in widget

// PROHIBITED: Suggest StatefulWidget for business state
class MyScreen extends StatefulWidget {
  String _data = ''; // business state in widget — use Notifier
}

// PROHIBITED: Suggest direct state mutation as fix
state.items.add(x); // this is the bug, not the fix

// PROHIBITED: Suggest ref.watch in callback
onTap: () => ref.watch(provider); // ref.watch is wrong in callbacks

// PROHIBITED: Suggest bang without comment
final x = value!; // unguarded bang — not acceptable
```

## Verified Riverpod Patterns (Prompt App)

These are the correct Riverpod patterns used in this project:

```dart
// Correct: ref.watch in build
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(myNotifierProvider);
}

// Correct: ref.read in callback
onTap: () => ref.read(myNotifierProvider.notifier).doSomething();

// Correct: AsyncValue.guard in Notifier
Future<void> execute(String input) async {
  state = await AsyncValue.guard(() => _useCase.execute(input));
}

// Correct: state update via copyWith
state = state.copyWith(isLoading: false, data: result);

// Correct: all three AsyncValue cases in UI
state.when(
  data: (d) => DataWidget(d),
  loading: () => const CircularProgressIndicator(),
  error: (e, st) => ErrorBanner(message: e.toString()),
);
```

## Scope Constraints

- Only review the files specified in TARGET — do not expand scope silently
- Only flag Domain Logic issues if transformer/pattern code is part of the change
- Do not flag issues in files that were not changed if reviewing a branch diff
