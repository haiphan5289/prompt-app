# Prompt — new-screen-plan

Run Stages 1–2 only. Write the output to `.claude/tmp/[ScreenName].plan.md` before exiting.

---

## Pre-Flight

Check if `.claude/tmp/[ScreenName].plan.md` already exists.
- If yes → ask the user: "Plan already exists. Overwrite or use existing plan and jump to /new-screen-build?"
- If no → proceed.

---

## Stage 1: Requirements (pa-flipped-interaction)

Invoke `pa-flipped-interaction` with the screen name and description.

Ask the user:
1. What data does this screen display?
2. What actions can the user take?
3. Are there empty/loading/error states?
4. Does it need navigation to other screens?
5. Any animations or transitions?
6. Any App* component preferences?

**Fallback:** If the user says "use defaults" → proceed with:
- States: loading + empty + error
- Navigation: none
- Animations: none
- App* components: AppButton, AppCard, AppTextField, AppLoadingView

---

## Stage 2: Architecture (pa-chain-of-thought)

Invoke `pa-chain-of-thought` with the gathered requirements.

Design:
- ViewModel @Published properties (name + type + default)
- UseCase and Repository dependencies
- Data flow: View → ViewModel → UseCase → Repository → Service → Firebase/Network → @Published → View
- Edge cases and error states

---

## Write Plan to Disk

After Stage 2 completes, write to `.claude/tmp/[ScreenName].plan.md`:

```markdown
# Plan: [ScreenName]
generated: [ISO date]

## Requirements
- Data: [...]
- Actions: [...]
- States: [empty description], [loading description], [error description]
- Navigation: [...]
- Animations: [...]
- App* preferences: [...]

## Architecture

### ViewModel Properties
```swift
@Published var [...]: [...] = [default]
@Published var isLoading = false
@Published var errorMessage: String?
```

### Dependencies
```swift
private let [...]: [...]Repository
```

### Data Flow
[ScreenName] → vm.[action]() → [Name]UseCase.execute() → [Name]Repository.[method]() → Service → Firebase/Network → @Published update → View re-render

### Edge Cases
- [list each edge case]

### Feature Group
[which Features/ subfolder: Auth | Customer | Dashboard | Settings | Transaction]
```

---

## Report

```
✅ new-screen-plan complete: [ScreenName]
Stage 1: [N] requirements captured
Stage 2: [N] @Published properties, [N] dependencies
Plan → .claude/tmp/[ScreenName].plan.md

Next: /new-screen-build [ScreenName]
```
