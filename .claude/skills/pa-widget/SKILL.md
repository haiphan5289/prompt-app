---
name: pa-widget
description: Generate a reusable Flutter widget for Prompt App — pattern cards, prompt input fields, result cards, copy buttons, history entries, category chips. Produces correctly structured ConsumerWidget or StatelessWidget with const constructor.
---

# Widget Generator — Prompt App

Use when extracting a repeated UI element or building a new standalone widget.


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
WIDGET_TYPE: Card
NAME: PatternCard
FEATURE: pattern_library
READS_PROVIDER: no
PROPS:
  - pattern: PromptPattern
  - onTap: VoidCallback?
```
