---
name: pa-handle-usecase
description: Add a UseCase execution method to an existing Notifier in Prompt App with proper AsyncValue.guard, loading state, and error propagation.
---

# Handle UseCase — Wire to Existing Notifier

Add a new action method to an existing Notifier that executes a UseCase. Use when a UseCase already exists but is not yet wired to a Notifier. Generates the execute method with correct variant (replace state, append to list, or invalidate self).


> **Project context:** See [README.md](../../../README.md) for app overview and core concept.
## Files

| File | Purpose |
|---|---|
| [spec/PROMPT.md](spec/PROMPT.md) | Step-by-step execution |
| [spec/INPUT_SCHEMA.md](spec/INPUT_SCHEMA.md) | Input parameters |
| [spec/OUTPUT_SCHEMA.md](spec/OUTPUT_SCHEMA.md) | Expected outputs |
| [spec/EXAMPLES.md](spec/EXAMPLES.md) | Worked examples |
| [spec/EVAL.md](spec/EVAL.md) | Quality checklist |
| [spec/GUARDRAILS.md](spec/GUARDRAILS.md) | Anti-hallucination rules |
| [spec/POSTPROCESS.md](spec/POSTPROCESS.md) | Post-execution steps |

## Quick Start

```
NOTIFIER: TransformerNotifier
NOTIFIER_FILE: lib/features/transformer/presentation/notifiers/transformer_notifier.dart
USE_CASE: SuggestPatternUseCase
USE_CASE_PROVIDER: suggestPatternUseCaseProvider
METHOD_NAME: suggestPattern
PARAMS: [{name: rawPrompt, type: String}]
RETURN_BEHAVIOR: replace_state
```
