# Output Schema — new-screen-build

## Conversation Output (short — never inline full code)

```
✅ new-screen-build complete: [ScreenName]
Stage 3: Scaffolded
  → laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName].swift
  → laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName]ViewModel.swift
  [→ + Domain files if created]
Stage 4: UI written → [ScreenName].swift
  Components: AppButton, AppCard, AppLoadingView [+ others]
  States: loading ✓ empty ✓ error ✓
Stage 5: [score]/10, [N] issues fixed
Stage 6: [score]/10 ✓
```

## Files Written to Disk

```
laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName].swift
laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName]ViewModel.swift
laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Domain/[Name]UseCase.swift        ← if new UseCase
laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Domain/[Name]Repository.swift     ← if new Repository
laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Data/[Name]RepositoryImpl.swift   ← if Repository created
```

## What Is Never Output Inline

- Full SwiftUI View implementation
- Full ViewModel implementation
- Full UseCase/Repository implementation

These are written to disk only. Stages 5 and 6 read from disk paths.
