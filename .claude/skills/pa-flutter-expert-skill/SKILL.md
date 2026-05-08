---
name: pa-flutter-expert-skill
description: Flutter/Riverpod architecture reference for Prompt App. Covers Clean Architecture layering, Riverpod patterns, Widget composition, navigation, local storage, and domain models.
---

# Flutter Expert Skill — Prompt App

The canonical architecture and code-pattern reference for Prompt App. Use before writing any Flutter code — covers Clean Architecture layering, Riverpod patterns (Notifier, AsyncNotifier, Provider), widget composition rules, navigation with GoRouter, local storage with Hive, and the app's domain model.

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
TASK: Implement <feature name>
LAYER: <Presentation | Domain | Data | Full-stack>
FEATURE: <transformer | pattern_library | history>
```
