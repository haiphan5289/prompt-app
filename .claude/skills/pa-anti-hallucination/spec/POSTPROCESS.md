# Post-Execution Steps — Anti-Hallucination

After completing verification and generating code:

## 1. Run Static Analysis

```bash
flutter analyze lib/
```

Expected: zero warnings or errors. Treat warnings as errors — do not ignore them.

## 2. Check Formatting

```bash
dart format --output=none --set-exit-if-changed lib/
```

Expected: no formatting changes needed.

## 3. Re-read Generated Imports

Read back every `import` statement in the generated file and confirm:
- Each `package:` import corresponds to a confirmed `pubspec.yaml` entry.
- Each relative import path maps to a file confirmed via `find lib/`.

## 4. Re-check Provider Usage in Build Methods

Scan every `build()` method in generated code:
- `ref.watch` used for all state reads → correct.
- `ref.read` inside `build()` → fix immediately.

## 5. Confirm No Unsubstituted Symbols

Scan generated code for placeholder patterns:
- No `// TODO: implement` left without a follow-up task.
- No `{{variable}}` or `<placeholder>` text remaining.
- No `UnimplementedError()` silently left in production paths.

## 6. Document Any Unresolved Gaps

If any symbol remains unverified after all steps, document:
- Symbol name
- Why it could not be verified
- What the user must do before the code can compile
