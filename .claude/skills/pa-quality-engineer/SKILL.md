---
name: pa-quality-engineer
description: Multi-dimension QE validation for Prompt App features — validates against PRD/acceptance criteria and technical standards across Business Requirements, Architecture, Riverpod, Transformer Logic, UI consistency, and Test Coverage.
model: sonnet
effort: high
---

# Quality Engineer — Prompt App

Validates a completed feature across 6 dimensions simultaneously against a PRD and technical standards. Produces a structured bug report with severity classification and a ship/block recommendation.


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
PRD: lib/features/transformer/PRD.md
TARGET: lib/features/transformer/
```
