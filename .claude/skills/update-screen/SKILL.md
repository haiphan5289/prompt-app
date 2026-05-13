---
name: update-screen
description: "Pipeline for modifying an existing SwiftUI screen in laundry-dashboard. Audits the current file state, gathers the delta requirements, applies surgical edits only, then reviews workflow and UI score. Never rewrites full files."
argument-hint: "[ScreenName] [brief description of what needs to change]"
model: sonnet
effort: medium
---

# Update Screen Pipeline

For modifying an existing screen — not building from scratch. The key difference from `/new-screen-build`:

- Reads document file **first** (feature spec, roadmap)
- Reads existing files **first** (audit stage)
- Applies **only the delta** — never rewrites the whole file
- Has a **regression check** to verify existing functionality is untouched
- No scaffold stage (files already exist)

## Files

| File | Purpose |
|---|---|
| [spec/PROMPT.md](spec/PROMPT.md) | Step-by-step pipeline execution |
| [spec/INPUT_SCHEMA.md](spec/INPUT_SCHEMA.md) | Required input parameters |
| [spec/OUTPUT_SCHEMA.md](spec/OUTPUT_SCHEMA.md) | Expected outputs per stage |
| [spec/EXAMPLES.md](spec/EXAMPLES.md) | Example pipeline runs |
| [spec/EVAL.md](spec/EVAL.md) | Quality checklist per stage |
| [spec/GUARDRAILS.md](spec/GUARDRAILS.md) | Anti-patterns and regression rules |
| [spec/POSTPROCESS.md](spec/POSTPROCESS.md) | Post-pipeline verification steps |

## Quick Start

```
/update-screen OrderDetailView Add a "refund order" button in the actions section
/update-screen CustomerListScreen Add search bar with real-time filtering
/update-screen MachineStatusView Show last maintenance date below each machine card
```

## Stages at a Glance

```
Stage 1: Audit        → read existing View + ViewModel, summarize current state
Stage 2: Delta        → gather only what changes (not full requirements)
Stage 3: Implement    → surgical edits with pa-swiftui-expert-skill
Stage 4: Review       → pa-review-workflow on modified ViewModel
Stage 5: UI Score     → pa-review-ui-score on modified View
Stage 6: Regression   → verify no existing behavior was removed
```
