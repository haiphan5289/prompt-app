# Examples — new-screen-build

## Example 1: Machine Status Dashboard (Full Pipeline)

**Pre-condition:**
`.claude/tmp/MachineStatusView.plan.md` exists from `/new-screen-plan`

**User Input:**
```
/new-screen-build MachineStatusView
```

**Stage 3 Output:**
```
✓ Stage 3: Scaffolded
  → laundry-dashboard/laundry-dashboard/Features/Dashboard/Presentation/MachineStatusView.swift
  → laundry-dashboard/laundry-dashboard/Features/Dashboard/Presentation/MachineStatusViewModel.swift
```

**Files Created:**
- `MachineStatusView.swift` — SwiftUI View skeleton with `@StateObject var viewModel`
- `MachineStatusViewModel.swift` — ObservableObject with @Published properties from plan

**Stage 4 Output:**
```
✓ Stage 4: UI written → MachineStatusView.swift
  Components used: AppCard, AppBadge, AppLoadingView, AppButton, AppEmptyStateView
  States: loading ✓ empty ✓ error ✓
```

**Stage 5 Output:**
```
✓ Stage 5: Workflow Review — 8.5/10
Issues fixed:
  🟡 Missing defer { isLoading = false } in loadMachines() → added
  🟢 Idempotency guard added to prevent duplicate fetches
```

**Stage 6 Output:**
```
✓ Stage 6: UI Score — 8.2/10 ✓
Strengths: Proper AppTheme tokens, clear visual hierarchy, all states handled
Improvements: Could add pull-to-refresh
```

---

## Example 2: Customer Form with Higher Target Score

**User Input:**
```
/new-screen-build CustomerFormSheet target_score=9.0
```

**Stage 3–4:** (same as Example 1)

**Stage 5 Output:**
```
✓ Stage 5: Workflow Review — 9.0/10
No critical issues. Clean Architecture respected.
```

**Stage 6 Output (First Pass):**
```
⚠️ Stage 6: UI Score — 8.3/10 (below target 9.0)
Issues:
  - Hardcoded spacing values → use AppSpacing.*
  - No focus state on text fields
  - Form validation not visually clear
```

**Stage 6 Output (After Quick Wins):**
```
✓ Stage 6: UI Score — 9.1/10 ✓ (target reached)
Applied:
  - Replaced hardcoded spacing with AppSpacing tokens
  - Added .focused() modifier for field focus
  - Added inline validation icons
```

---

## Example 3: Skip Workflow Review

**User Input:**
```
/new-screen-build OrderDetailView skip_stages=5
```

**Stage 3–4:** (scaffolded + UI implemented)

**Stage 5:** SKIPPED

**Stage 6 Output:**
```
✓ Stage 6: UI Score — 8.5/10 ✓
(Workflow review was skipped per user request)
```

**Final Report:**
```
✅ new-screen-build complete: OrderDetailView
Stage 3: OrderDetailView.swift, OrderDetailViewModel.swift
Stage 4: UI written
Stage 5: SKIPPED
Stage 6: 8.5/10 ✓
```

---

## Example 4: New UseCase Required

**Pre-condition:**
Plan file specifies `FetchRevenueAnalyticsUseCase` (doesn't exist yet)

**User Input:**
```
/new-screen-build RevenueAnalyticsView
```

**Stage 3 Output:**
```
✓ Stage 3: Scaffolded
  → RevenueAnalyticsView.swift
  → RevenueAnalyticsViewModel.swift
  → Domain/FetchRevenueAnalyticsUseCase.swift (NEW)
  → Domain/DashboardRepository.swift (extended with new method)
```

**Note:** Skill detected missing UseCase from plan and auto-generated it.

---

## Example 5: Plan Not Found (Error Case)

**User Input:**
```
/new-screen-build NonExistentView
```

**Output:**
```
❌ Plan not found: .claude/tmp/NonExistentView.plan.md
Run /new-screen-plan NonExistentView first.
```

Skill aborts immediately — no stages run.

---

## Example 6: Critical Issues Force Re-Scaffold

**Stage 5 Output (First Pass):**
```
❌ Stage 5: Workflow Review — 4.0/10
Critical issues (🔴):
  1. ViewModel depends on Service directly (breaks Clean Architecture)
  2. Missing @MainActor on ViewModel class
  3. No nonisolated init
  4. Async method missing defer { isLoading = false }

→ Re-scaffolding ViewModel to fix architecture violations...
```

**Stage 5 Output (After Re-Scaffold):**
```
✓ Stage 5: Workflow Review — 8.0/10
Issues fixed after re-scaffold. Clean Architecture now respected.
```

---

## Anti-Example: Inlining Full Code (WRONG)

**Bad Output:**
```
Stage 4: Here's the full SwiftUI View:
[pastes 200 lines of code into conversation]
```

**Correct Output:**
```
✓ Stage 4: UI written → MachineStatusView.swift
  Components used: AppCard, AppBadge, AppLoadingView
  States: loading ✓ empty ✓ error ✓
```

**Rule:** NEVER inline full file contents. File paths only.
