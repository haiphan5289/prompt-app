---
name: pa-design-system
description: Flutter Material 3 design system reference for Prompt App. Covers which Material components to use, how to style them with theme tokens, Prompt App-specific UI patterns, and the design language for the app. Use before building any screen or widget.
---

# Design System — Prompt App

Material 3 is the design foundation. All components use `Theme.of(context)` tokens — never raw colors or sizes.


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
TASK: implement_screen
SCREEN: TransformerScreen
COMPONENTS: [PromptInput, PatternSelector, TransformButton, ResultCard]
```
