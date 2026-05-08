---
name: pa-ai-document
description: Generate a structured feature document for Prompt App by reading from multiple sources (Jira, Confluence, local files, git diff) and writing a co-located .md file inside the repo.
argument-hint: "[JIRA: <key>] [FILES: <path>] [FEATURE_REQUEST: ...] [CONTEXT: ...]"
---

# AI Document — Feature Documentation

Generate a structured, co-located feature document by gathering context from Jira, local files, and git diff. Use when documenting a new feature with PRD context, business rules, architecture overview, and key implementation files.

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
FEATURE_REQUEST: Describe the feature here
PRIORITY: Medium
```
