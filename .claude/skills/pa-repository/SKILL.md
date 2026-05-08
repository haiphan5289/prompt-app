---
name: pa-repository
description: Generate a Repository interface + implementation for Prompt App following Clean Architecture. Use when adding data access for a new entity or extending an existing repository. Produces the abstract interface in domain/ and the concrete implementation in data/.
---

# Repository Generator — Prompt App

Generate a Clean Architecture repository: domain interface + data implementation + Riverpod provider. Verify the entity class exists before generating.


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
NAME: History
ENTITY: HistoryEntry
FEATURE: history
OPERATIONS: [getAll, save, delete, clear]
```
