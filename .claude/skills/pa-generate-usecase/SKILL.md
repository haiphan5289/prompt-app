---
name: pa-generate-usecase
description: Auto-generate and wire a UseCase across all layers of Prompt App by modifying only existing files.
---

# Generate UseCase — Prompt App

Takes a UseCase name, feature, and repository method, then generates the UseCase class, Riverpod provider, and Notifier binding in one pass. Use when adding a new operation to an existing feature.


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
USE_CASE_NAME: DeleteHistory
FEATURE: history
REPOSITORY: HistoryRepository
METHOD:
  name: delete
  params: [{name: id, type: String}]
  returns: Future<void>
```
