# Prompt — new-screen-build

Run Stages 3–6. Read plan from disk. Write all Swift files to disk. **Never inline full file contents in the conversation — report file paths only.**

---

## Pre-Flight

Read `.claude/tmp/[ScreenName].plan.md`.

If not found → abort:
```
❌ Plan not found: .claude/tmp/[ScreenName].plan.md
Run /new-screen-plan [ScreenName] first.
```

Extract from plan: requirements, ViewModel properties, dependencies, data flow, feature group.

---

## Stage 3: Scaffold (pa-scaffold)

Generate skeleton files based on the plan's architecture section.

Write to disk:
```
laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName].swift
laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName]ViewModel.swift
```

If plan requires a new UseCase or Repository, also write:
```
laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Domain/[Name]UseCase.swift
laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Domain/[Name]Repository.swift
laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Data/[Name]RepositoryImpl.swift
```

ViewModel must:
- Be `@MainActor final class [ScreenName]ViewModel: ObservableObject`
- Have `nonisolated init(...)`
- Depend on UseCase and Repository protocols (Clean Architecture)

**Report only:**
```
✓ Stage 3: Scaffolded
  → [ScreenName].swift
  → [ScreenName]ViewModel.swift
  [→ UseCase + Repository if created]
```
Do NOT print file contents in the conversation.

---

## Stage 4: UI Implementation (pa-swiftui-expert-skill)

Read the plan + the scaffolded ViewModel file from disk.

Implement the full SwiftUI UI. Write to `[ScreenName].swift`.

Requirements (from plan):
- App* components only: `AppButton`, `AppCard`, `AppTextField`, `AppLoadingView`, `AppBadge`, `AppEmptyStateView`, `AppErrorView`
- All colors from `AppColors.*`
- All typography from `AppTypography.*`
- All spacing from `AppSpacing.*`
- `NavigationStack` — never `NavigationView`
- Loading state, empty state (icon + message + CTA), error state

**Report only:**
```
✓ Stage 4: UI written → [ScreenName].swift
  Components used: [AppButton, AppCard, ...]
  States: loading ✓ empty ✓ error ✓
```
Do NOT inline the SwiftUI implementation in the conversation.

---

## Stage 5: Workflow Review (pa-review-workflow)

Read `[ScreenName]ViewModel.swift` from disk by path. Do not paste it into context — read it via the file tool.

Check and fix in-place:
- `nonisolated init` on all `@MainActor` classes
- `defer { isLoading = false }` present in async methods
- Idempotency guard (`guard items.isEmpty else { return }`) where appropriate
- Firebase listener cleaned up in `deinit` (if applicable)
- Clean Architecture: ViewModel → UseCase → Repository (never skip layers)

**Failure recovery:** If > 3 Critical (🔴) issues found → re-scaffold ViewModel (Stage 3), re-run Stage 4, then re-run Stage 5.

**Report:** Score table + issues fixed. Apply patches directly to the file — do not reprint the full file.

---

## Stage 6: UI Score (pa-review-ui-score)

Read `[ScreenName].swift` from disk by path.

Target: `{target_score}` (default 8.0).

Check:
- AppTheme token usage (no hardcoded colors/fonts/spacing)
- Material 3 component usage (App* prefix)
- Visual hierarchy and layout
- Empty/loading/error states
- Business dashboard clarity

If score < target → apply quick wins directly to file, re-score once.

**Report:** Score table only.

---

## Final Report

```
✅ new-screen-build complete: [ScreenName]
Stage 3: [list file paths]
Stage 4: [ScreenName].swift
Stage 5: [score]/10, [N] issues fixed
Stage 6: [score]/10 ✓

Files written:
  laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName].swift
  laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName]ViewModel.swift
  [+ Domain files if created]
```
