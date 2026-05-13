---
name: new-screen-plan
description: "Stages 1–2 of the new-screen pipeline (token-efficient split). Gathers requirements and designs architecture, then writes a plan file to .claude/tmp/[ScreenName].plan.md. Run this before /new-screen-build."
argument-hint: "[ScreenName] [brief description of what the screen does]"
model: sonnet
effort: low
---

# New Screen — Plan Phase

Cheap half of the split pipeline. Covers requirements + architecture only. Writes output to disk so `/new-screen-build` can pick it up without re-running these stages.

## Files

| File | Purpose |
|---|---|
| [spec/PROMPT.md](spec/PROMPT.md) | Stage execution |
| [spec/INPUT_SCHEMA.md](spec/INPUT_SCHEMA.md) | Parameters |
| [spec/OUTPUT_SCHEMA.md](spec/OUTPUT_SCHEMA.md) | Plan file format |
| [spec/EXAMPLES.md](spec/EXAMPLES.md) | Worked examples |
| [spec/EVAL.md](spec/EVAL.md) | Quality checklist |
| [spec/GUARDRAILS.md](spec/GUARDRAILS.md) | Anti-patterns and never-do rules |
| [spec/POSTPROCESS.md](spec/POSTPROCESS.md) | Post-execution steps |

## Quick Start

```
/new-screen-plan MachineStatusView Show real-time washing machine status with color coding
/new-screen-plan OrderDetailView Full screen view of a laundry order with items and pricing
```

After this completes, run:
```
/new-screen-build [ScreenName]
```
