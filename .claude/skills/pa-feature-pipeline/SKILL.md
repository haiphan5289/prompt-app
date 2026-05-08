---
name: pa-feature-pipeline
description: End-to-end feature pipeline for Prompt App — single input auto-runs Domain Design, Implementation, and Verification phases in sequence.
---

# Feature Pipeline — Prompt App

Single-entry orchestrator that accepts one feature description and produces a complete implementation: domain model, Riverpod providers, screens, and tests. Orchestrates `pa-prompt-pattern-design` (if pattern work is needed), `pa-flutter-expert-skill` (implementation), and `pa-unittest` (test generation).

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
FEATURE: Show a list of past transformations (before/after)
SCOPE: full-stack
PATTERN_INVOLVED: no
ACCEPTANCE_CRITERIA:
  - Each entry shows original + enhanced prompt + pattern name
  - Tapping an entry copies the enhanced prompt
  - List sorted by most recent first
```
