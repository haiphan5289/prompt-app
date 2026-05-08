---
name: pa-module-context
description: Quick architecture reference for Prompt App features. Covers folder structure, key providers, entities, and naming conventions for the three main features. Use before adding code to an unfamiliar module.
---

# Module Context — Prompt App Architecture Reference

Provides a complete map of the Prompt App codebase: feature folders, key files, providers, entities, and naming conventions. Use at the start of any session to understand what already exists before adding code.

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
FEATURE: transformer
TASK: Add a SuggestPatternUseCase — need to understand existing providers and datasources.
```
