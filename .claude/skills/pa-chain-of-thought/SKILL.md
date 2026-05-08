---
name: pa-chain-of-thought
description: Systematic step-by-step technical analysis for complex Prompt App decisions. Use before implementing anything non-trivial.
model: sonnet
effort: high
---

# Chain-of-Thought Analysis — Prompt App

Breaks down complex problems into six structured phases before writing a single line of code. Produces an implementation roadmap that identifies architecture impact, edge cases, and a prioritised test plan.


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
PROBLEM: Designing auto-pattern selection for the transformer screen.
CONTEXT: User types a raw prompt; app must suggest the best PromptPattern automatically.
CONSTRAINT: Must work offline, response < 200 ms.
```
