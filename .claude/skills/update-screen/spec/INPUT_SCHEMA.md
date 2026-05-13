# Input Schema — update-screen

## Required Parameters

| Parameter | Format | Example |
|---|---|---|
| `ScreenName` | PascalCase, ends with `View` or `Screen` — must be an existing screen | `OrderDetailView` |
| `description` | One sentence describing what needs to change | `Add a refund order button in the actions section` |

## Optional Parameters

| Parameter | Default | Description |
|---|---|---|
| `skip_stages` | none | Comma-separated stages to skip (e.g. `skip_stages=4` if ViewModel unchanged) |
| `target_score` | 8.0 | Minimum UI score to accept in Stage 5 |

## Examples

```
/update-screen OrderDetailView Add a "refund order" button in the actions section
/update-screen CustomerListScreen Add search bar with real-time filtering
/update-screen MachineStatusView Show last maintenance date below each machine card
/update-screen RevenueAnalyticsView Add export to CSV button in toolbar
```

## Automatic Context (always included)

- `docs/Features/` — feature specs, so the change fits the roadmap
- `laundry-dashboard/Core/Design/Components/` — App* component library
- The existing `[ScreenName].swift` and `[ScreenName]ViewModel.swift` (read in Stage 1)
