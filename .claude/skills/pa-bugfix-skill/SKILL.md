---
name: pa-bugfix-skill
description: Debug and fix Flutter/Dart bugs in Prompt App with precision. Traces root causes through the UI → Notifier → UseCase → Repository data flow.
---

# Flutter Bug Fix Skill — Prompt App

Debug and fix Flutter/Dart bugs by limiting scope to 3–4 files, stating the root cause in one sentence, applying the minimal fix, then verifying end-to-end through the transformer data flow.


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
BUG: Widget not rebuilding after state change
SYMPTOM: Transform button tapped but result card stays empty
FILES: lib/features/transformer/presentation/screens/home_screen.dart
```
