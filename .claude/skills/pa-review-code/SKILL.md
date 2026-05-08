---
name: pa-review-code
description: Flutter code review checklist for Prompt App — checks Clean Architecture compliance, Riverpod patterns, null safety, widget composition, performance, and prompt transformer correctness.
model: sonnet
effort: high
---

# Code Review — Prompt App

Reviews Flutter code for Clean Architecture compliance, Riverpod correctness, null safety, widget composition, performance, and prompt transformer logic. Returns a structured review with PASS/WARN/FAIL per category and actionable fix suggestions.

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
Review the changes in lib/features/transformer/
```
