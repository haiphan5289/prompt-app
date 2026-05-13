# Output Schema — new-screen-plan

## Conversation Output (short)

```
✅ new-screen-plan complete: [ScreenName]
Stage 1: [N] requirements captured
Stage 2: [N] @Published properties, [N] dependencies
Plan → .claude/tmp/[ScreenName].plan.md

Next: /new-screen-build [ScreenName]
```

## Plan File Written to Disk

`.claude/tmp/[ScreenName].plan.md` contains:

```markdown
# Plan: [ScreenName]
generated: [ISO date]

## Requirements
- Data: [...]
- Actions: [...]
- States: [empty], [loading], [error]
- Navigation: [...]
- Animations: [...]
- App* preferences: [...]

## Architecture

### ViewModel Properties
@Published var ...: ... = ...
@Published var isLoading = false
@Published var errorMessage: String?

### Dependencies
private let ...: ...Repository

### Data Flow
[ScreenName] → vm.[action]() → [Name]Repository.[method]() → [Name]Service → Firebase/Network → @Published → View re-render

### Edge Cases
- [list]

### Feature Group
[Auth | Customer | Dashboard | Settings | Transaction]
```
