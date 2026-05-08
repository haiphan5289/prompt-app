---
name: pa-handoff-implement
description: Implement a Prompt App feature from a written handoff spec (Notion doc, Figma notes, PRD, or inline description) with full Clean Architecture compliance.
---

# Handoff Implement — Prompt App

Takes a design handoff document, extracts requirements, asks clarifying questions if needed, then implements UI and logic changes following the Prompt App layered architecture. Use when receiving a feature spec from a designer or PM.

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
HANDOFF: "Result screen should show original prompt above the enhanced version.
          Both are selectable text. Add a copy button for each."
FEATURE: transformer
SCOPE: full-stack
```
