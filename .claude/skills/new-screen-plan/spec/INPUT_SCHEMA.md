# Input Schema — new-screen-plan

## Required Parameters

| Parameter | Format | Example |
|---|---|---|
| `ScreenName` | PascalCase, ends with `Screen` or `View` | `MachineStatusView` |
| `description` | One sentence what the screen does | `Show real-time washing machine status with color coding` |

## Optional Parameters

| Parameter | Default | Description |
|---|---|---|
| `skip_stage1` | false | Skip requirements if already known — provide them inline |

## Examples

```
/new-screen-plan OrderDetailView Show a single order with items, pricing, and status
/new-screen-plan CustomerListScreen Display all customers with search and filtering
/new-screen-plan RevenueAnalyticsView Dashboard showing daily/weekly/monthly revenue charts
```

## Automatic Context (always included)

- `docs/Features/` — feature specifications
- `laundry-dashboard/Core/Design/Components/` — App* component library
