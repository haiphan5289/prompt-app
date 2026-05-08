---
name: pa-alternative-approaches
description: Generate 3–5 alternative implementation strategies for Prompt App problems with pros/cons, code examples, comparison matrix, and a decision framework.
model: sonnet
effort: high
---

# Alternative Approaches — Prompt App

Evaluates trade-offs between architectural or implementation choices before committing. Produces 3–5 concrete options with code sketches, a comparison matrix, and a decision framework. Use when you need to pick the right approach rather than the first approach.

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
PROBLEM: How should we store prompt history?
CONTEXT: history feature, data layer
COMPLEXITY: Medium
CONSTRAINTS: offline-first, no SQL
```
