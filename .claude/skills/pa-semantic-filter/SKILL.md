---
name: pa-semantic-filter
description: Strip sensitive or irrelevant content from feature requests and PRDs before passing them to other Prompt App skills.
---

# Semantic Filter — Prompt App

Strip business-sensitive information (revenue targets, competitive intelligence, internal metrics) from a feature request or PRD while preserving all technical requirements. Use before `pa-feature-pipeline` or `pa-ai-document` when input comes from external or confidential sources.

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
<Paste the raw feature request or PRD here>
```
