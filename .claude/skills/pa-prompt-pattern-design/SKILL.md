---
name: pa-prompt-pattern-design
description: Design, evaluate, and expand the prompt pattern library that powers Prompt App's transformation engine.
model: sonnet
effort: high
---

# Prompt Pattern Design Skill

Design, evaluate, and expand the prompt pattern library that powers Prompt App's transformation engine. Use when adding a new pattern, refining an existing one, defining the transformer logic for a pattern, or deciding which patterns should be in the core library.

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
ADD_PATTERN:
  id: explain_like_five
  category: Constraint-Based
  description: Explain the topic as if the reader is 5 years old
  examples: [3 input/output pairs]
```
