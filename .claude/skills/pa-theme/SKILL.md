---
name: pa-theme
description: Flutter theming patterns for Prompt App. Covers ThemeData setup, color tokens, typography tokens, dark/light mode, and how to apply theme consistently across widgets. Use before adding any color, font, or spacing value.
---

# Theme System — Prompt App

Reference for consistent theming using Material 3 tokens. Never hardcode values — always use theme tokens.

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
TASK: add_color_token
TOKEN: colorScheme.primary
USAGE: FilledButton background
```
