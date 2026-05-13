# Input Schema — new-screen-build

## Required Parameters

| Parameter | Format | Example |
|---|---|---|
| `ScreenName` | PascalCase, ends with `Screen` or `View` — must match the name used in `/new-screen-plan` | `MachineStatusView` |

## Optional Parameters

| Parameter | Default | Description |
|---|---|---|
| `skip_stages` | none | Comma-separated stage numbers to skip (e.g. `skip_stages=5` skips workflow review) |
| `target_score` | 8.0 | Minimum UI score for Stage 6 |

## Examples

```
/new-screen-build MachineStatusView
/new-screen-build OrderDetailView target_score=9.0
/new-screen-build CustomerFormSheet skip_stages=5
```

## Pre-condition

`.claude/tmp/[ScreenName].plan.md` must exist. Run `/new-screen-plan [ScreenName]` first.

## Automatic Context (always included)

- `.claude/tmp/[ScreenName].plan.md` — plan written by new-screen-plan
- `laundry-dashboard/Core/Design/Components/` — App* component library
- `laundry-dashboard/Core/Design/Theme/` — AppColors, AppTypography, AppSpacing
