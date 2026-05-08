# Guardrails — pa-issue-detection

## Anti-Hallucination Rules

- **Only scan files that are actually changed on the branch.** Do not scan the entire codebase.
- **Read each file before reporting issues in it.** Do not guess what a file contains from its name.
- **Only report line numbers you observed.** Do not estimate or approximate line numbers.
- **Do not flag `// safe:` annotated bang operators as P01.** The comment is the documented exception.
- **Do not flag generated files** (`*.g.dart`, `*.freezed.dart`). These are machine-generated and not author-owned.

## Pattern Boundary Rules

### P01 — Bang Operator
- ONLY flag if no `// safe:` comment on the same line
- Do NOT flag: `context.mounted!` (not a valid Dart pattern, just example)
- DO flag: `state.value!`, `list[0]!`, `nullableString!`

### P02 — BuildContext After Await
- ONLY flag if `context.` appears AFTER an `await` with NO `if (!context.mounted) return;` or `if (!mounted) return;` between them
- Correct pattern that should NOT be flagged:
  ```dart
  await someOp();
  if (!context.mounted) return;
  Navigator.of(context).push(...); // safe
  ```

### P03 — ref.watch in Callback
- ONLY flag `ref.watch` inside closures/callbacks, NOT in `build()` method body
- The `build()` method is the correct place for `ref.watch`

### P04 — Direct State Mutation
- ONLY flag mutation of Riverpod Notifier `state` object
- Do NOT flag mutation of local variables or plain Dart classes unrelated to Riverpod state

### P11 — StatefulWidget for Business Logic
- UI-local state that is ALLOWED in `setState`: TextEditingController, FocusNode, AnimationController, scroll position, keyboard visibility
- Business state that must be in Notifier: data from API, user selections persisted across screens, loading/error states

## Scope Constraint

Only scan Dart files returned by:
```bash
git diff main...HEAD --name-only | grep '\.dart$'
```

Never expand scope to the full codebase unless explicitly instructed.
