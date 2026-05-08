# Guardrails — pa-alternative-approaches

## Never Invent Packages

```
// PROHIBITED — package doesn't exist or isn't in pubspec.yaml
Option 3: Use flutter_prompt_engine package
  ```dart
  import 'package:flutter_prompt_engine/engine.dart'; // invented
  ```

// CORRECT — only use packages confirmed in pubspec.yaml
grep "dependencies:" pubspec.yaml  # verify first
```

## Never Propose Broken Architecture

Reject any option that:
- Puts business logic in the presentation layer (Widget/Notifier)
- Imports infrastructure packages (`hive`, `dio`) in the domain layer
- Bypasses Riverpod for state management in a Flutter widget tree
- Uses `Navigator.push` instead of GoRouter `context.go/push`

## Never Give a Non-Recommendation

```
// PROHIBITED
"Each option has trade-offs — it depends on your use case."

// CORRECT
"Recommendation: Option 1 (Hive typed box) because Prompt App already 
uses Hive for pattern storage, it's offline-first, and no additional 
dependency is needed."
```

## Verify Before Citing Code

Before writing any code sketch, confirm the API exists:
```bash
# Verify class exists in installed package
grep -rn "class AsyncNotifier" ~/.pub-cache/hosted/

# Verify method name
grep -rn "def execute\|Future execute" lib/
```

## Architecture Evaluation Checklist (mandatory for all options)

For every option, explicitly answer:
1. Does it respect Clean Architecture? (domain layer has no external deps)
2. Is it unit-testable without Flutter?
3. Does it support offline use?
4. Is it appropriately complex for current Prompt App MVP scale?

If any option fails questions 1–3, mark it ❌ in the matrix and explain why.

## Prohibited Output Patterns

| Pattern | Why |
|---|---|
| Options without code sketches | Not actionable — reader can't evaluate concretely |
| Recommending 3rd-party packages without pubspec verification | Hallucination risk |
| "It depends" as the recommendation | Not a decision — defeats the purpose |
| Presenting >5 options | Decision paralysis |
| Omitting the comparison matrix | Core deliverable |
