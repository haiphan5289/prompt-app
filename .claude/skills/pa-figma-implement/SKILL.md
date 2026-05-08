---
name: pa-figma-implement
description: Translate Figma designs into production-ready Flutter widgets and screens for Prompt App. Analyzes design specs, maps to Material 3 + AppTheme tokens, and generates Flutter code with 1:1 visual fidelity.
---

# Figma to Flutter Implementation — Prompt App

Use when a designer hands off a Figma frame for a screen or component. Only use `Theme.of(context)` tokens and existing widget classes — never invent new ones.


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
| [theme/TOKENS.md](theme/TOKENS.md) | Design system tokens |

## Quick Start

```
FIGMA_URL: https://www.figma.com/file/xxx/frame/yyy
TARGET: Screen
NAME: TransformerScreen
FEATURE: transformer
```
