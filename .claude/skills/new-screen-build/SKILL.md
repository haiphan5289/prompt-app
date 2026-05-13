---
name: new-screen-build
description: "Stages 3–6 of the new-screen pipeline (token-efficient split). Reads .claude/tmp/[ScreenName].plan.md, scaffolds files, implements UI, runs workflow review and UI score. All code written to disk — never inlined in conversation."
argument-hint: "[ScreenName] [optional: skip_stages=5,6] [optional: target_score=9.0]"
model: sonnet
effort: high
---

# New Screen — Build Phase

Expensive half of the split pipeline. Reads the plan written by `/new-screen-plan` and executes Stages 3–6. Writes all Swift files to disk and reports file paths only — never inlines full code in the conversation.

## Files

| File | Purpose |
|---|---|
| [spec/PROMPT.md](spec/PROMPT.md) | Stage execution |
| [spec/INPUT_SCHEMA.md](spec/INPUT_SCHEMA.md) | Parameters |
| [spec/OUTPUT_SCHEMA.md](spec/OUTPUT_SCHEMA.md) | Expected outputs |
| [spec/EXAMPLES.md](spec/EXAMPLES.md) | Worked examples |
| [spec/EVAL.md](spec/EVAL.md) | Quality checklist |
| [spec/GUARDRAILS.md](spec/GUARDRAILS.md) | Anti-patterns |
| [spec/POSTPROCESS.md](spec/POSTPROCESS.md) | Post-execution steps |

## Quick Start

```
/new-screen-build MachineStatusView
/new-screen-build OrderDetailView target_score=9.0
/new-screen-build CustomerFormSheet skip_stages=5
```

Requires `/new-screen-plan [ScreenName]` to have been run first.
