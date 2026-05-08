---
name: pa-issue-detection
description: Pre-merge issue scanner for Prompt App — diffs current branch against main, reads every changed Dart file, and flags high-risk runtime patterns before they reach production.
---

# Pre-Merge Issue Detection — Prompt App

Scans all Dart files changed on the current branch and flags 12 high-risk patterns that pass `flutter analyze` but still cause runtime problems. Run before opening any PR.


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
Scan current branch before opening PR
```
