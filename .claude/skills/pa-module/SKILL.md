---
name: pa-module
description: Generate a complete Flutter feature module for Prompt App — all 5 layers at once (Entity, Repository interface + impl, UseCase, Notifier, Screen).
---

# Full Module Generator — Prompt App

Generate all files for a new Flutter feature module in one pass: Entity, Repository interface and implementation, UseCases, DataSource, Notifier, Screen, Card widget, provider registrations, route registration, and test stubs.

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
FEATURE_NAME: bookmark
DISPLAY_NAME: Bookmark
PURPOSE: Save and revisit favourite enhanced prompts
ENTITY_FIELDS:
  - promptId: String
  - note: String
```
