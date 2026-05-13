# Evaluation — new-screen-build

Quality checklist per stage. Each stage must pass before proceeding to next.

---

## Stage 3: Scaffold (pa-scaffold)

✅ **Pass Criteria:**
- [ ] Files written to correct paths (`Features/[FeatureGroup]/Presentation/` and `Domain/`)
- [ ] ViewModel class has `@MainActor` and `final class ... : ObservableObject`
- [ ] ViewModel init is `nonisolated`
- [ ] All @Published properties from plan are present with correct types and defaults
- [ ] Dependencies match plan (UseCase + Repository)
- [ ] Swift syntax valid (no compilation errors)

❌ **Fail Patterns:**
- Files written to wrong feature group
- Missing `@MainActor` or `nonisolated init`
- @Published properties missing or wrong types
- Dependencies are Services instead of UseCases/Repositories

**Abort if:** File write fails (permissions, path doesn't exist)

---

## Stage 4: UI Implementation (pa-swiftui-expert-skill)

✅ **Pass Criteria:**

### Component Usage
- [ ] All components use App* prefix (AppButton, AppCard, etc.)
- [ ] No UIKit components (UILabel, UIButton, etc.)
- [ ] No ML* components from memory-love
- [ ] Components match plan's App* preferences

### Theming
- [ ] All colors use `AppColors.*` (no hardcoded Color.blue, hex values)
- [ ] All text uses `AppTypography.*` styles
- [ ] All spacing uses `AppSpacing.*` constants
- [ ] No magic numbers for padding/spacing

### States
- [ ] Loading state renders `AppLoadingView`
- [ ] Empty state shows `AppEmptyStateView` with message + optional CTA
- [ ] Error state shows `AppErrorView` or toast with retry action
- [ ] All 3 states work correctly (tied to ViewModel @Published vars)

### Navigation
- [ ] Uses `NavigationStack` (never NavigationView)
- [ ] Navigation matches plan (sheets, pushes, etc.)
- [ ] Passes data correctly to destination views

### Architecture
- [ ] View has `@StateObject var viewModel: [Name]ViewModel`
- [ ] View calls `viewModel.method()` for user actions (no business logic in View)
- [ ] View uses `@ObservedObject` or `@StateObject` correctly

❌ **Fail Patterns:**
- Hardcoded colors/fonts/spacing
- Missing any of the 3 states
- Business logic in View body
- Wrong component prefix (ML* or UI*)

**Abort if:** File too large (> 500 lines) — needs refactoring into subviews

---

## Stage 5: Workflow Review (pa-review-workflow)

✅ **Pass Criteria:**
- [ ] Score ≥ 7.0/10
- [ ] 0 Critical (🔴) issues
- [ ] Clean Architecture respected (ViewModel → UseCase → Repository)
- [ ] All async methods have proper loading state management
- [ ] No memory leaks (deinit cleans up listeners if present)

🔴 **Critical Issues (must fix):**
- ViewModel depends on Service directly (skips UseCase layer)
- Missing `@MainActor` on ViewModel
- Missing `nonisolated init`
- Async method missing `defer { isLoading = false }`
- Firebase listener not cleaned up in deinit

🟡 **Warning Issues (should fix):**
- Missing idempotency guard
- Error messages not user-friendly
- Cancellable not stored

🟢 **Info Issues (nice to have):**
- Could extract private helper methods
- Could add comments

**Failure recovery:** If > 3 🔴 issues → re-scaffold + re-implement

---

## Stage 6: UI Score (pa-review-ui-score)

✅ **Pass Criteria:**
- [ ] Score ≥ target_score (default 8.0)
- [ ] All dimensions ≥ 7.0 (no major weak spots)

**Dimensions Scored:**
1. Business Dashboard Clarity (20%) — data presentation, KPIs visible
2. Visual Hierarchy (20%) — proper use of size/color/spacing to guide eye
3. AppTheme Compliance (20%) — no hardcoded values
4. Layout Consistency (15%) — proper grid/alignment
5. Empty/Loading States (10%) — all 3 states polished
6. Animations (5%) — smooth transitions (if applicable)
7. Color Token Usage (5%) — semantic colors (primary/secondary/error)
8. Overall Polish (5%) — feels production-ready

❌ **Fail Patterns:**
- Score < target after 1 retry
- Any dimension < 5.0 (broken)
- Hardcoded colors still present after review

**Abort if:** Score drops after applying quick wins (regression)

---

## Cross-Stage Validation

After all stages complete, verify:
- [ ] All files from Stage 3 still exist (not accidentally deleted)
- [ ] ViewModel properties match plan
- [ ] View uses all ViewModel @Published properties
- [ ] No compilation errors (check with pa-bugfix-skill if needed)

---

## Scoring Summary

| Stage | Pass Threshold | Critical Failure |
|---|---|---|
| 3. Scaffold | Valid Swift syntax + files written | File write fails |
| 4. UI Implementation | All 3 states + App* components | Wrong component prefix |
| 5. Workflow Review | ≥ 7.0/10, 0 🔴 issues | > 3 🔴 issues |
| 6. UI Score | ≥ target_score | Score < target after retry |

**Overall Pass:** All 4 stages pass.

---

## Example Pass/Fail

### ✅ Pass Example

```
Stage 3: Files written ✓
Stage 4: AppCard, AppButton, AppLoadingView used. States: loading ✓ empty ✓ error ✓
Stage 5: 8.5/10, 0 🔴, 1 🟡 (fixed)
Stage 6: 8.7/10 ✓ (target 8.0)
→ PASS
```

### ❌ Fail Example

```
Stage 3: Files written ✓
Stage 4: Used Color.blue (hardcoded), missing error state
Stage 5: 5.0/10, 4 🔴 issues (ViewModel → Service directly, missing @MainActor, no defer, no deinit)
→ FAIL at Stage 5 → re-scaffold triggered
```
