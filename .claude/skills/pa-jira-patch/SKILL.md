---
name: pa-jira-patch
description: Fetch Jira ticket context for Prompt App and patch it with implementation status.
---

# Jira Patch — Prompt App

Read a Jira ticket's requirements before implementing, or update a ticket with implementation notes, PR links, and completion status after work is done.

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
JIRA: PA-42
MODE: read
```
