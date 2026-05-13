# Guardrails — update-screen

Never-do patterns and regression prevention rules.

---

## General Rules

### ❌ NEVER

1. **Rewrite full files**
   ```
   ❌ "Here's the updated CustomerListScreen.swift: [300 lines]"
   ✅ Use replace_string_in_file for surgical edits only
   ```

2. **Skip the Audit stage**
   ```
   You MUST read existing files first to understand current state
   ```

3. **Assume user intent**
   ```
   If description is vague → ask clarifying questions in Stage 2
   ```

4. **Edit files that don't exist**
   ```
   Pre-flight check: verify [ScreenName].swift and [ScreenName]ViewModel.swift exist
   If not found → abort with error
   ```

---

## Stage 1: Audit

### ❌ NEVER

1. **Skip reading ViewModel**
   ```
   Even if change seems View-only: read ViewModel to capture full state
   ```

2. **Fabricate audit data**
   ```
   Read actual files from disk, don't guess based on screen name
   ```

3. **Miss dependencies**
   ```
   List ALL UseCase and Repository dependencies in ViewModel init
   ```

---

## Stage 2: Delta

### ❌ NEVER

1. **Add features not requested**
   ```
   User: "add search bar"
   ❌ Also add: sorting, filtering, export
   ✅ Just add: search bar
   ```

2. **Remove existing features without asking**
   ```
   If delta requires removal: explicitly confirm with user first
   ```

3. **Modify public API without warning**
   ```
   If method signature must change: warn user about potential callers breaking
   ```

---

## Stage 3: Implement

### ❌ NEVER

1. **Reorder existing @Published properties**
   ```swift
   ❌ Rearrange order of properties
   ✅ Add new @Published below existing ones, preserve order
   ```

2. **Delete existing MARK sections**
   ```swift
   ❌ Remove // MARK: - Empty State to make room
   ✅ Add new // MARK: - Search Section, keep existing marks
   ```

3. **Use wrong component prefix**
   ```swift
   ❌ MLButton, MLCard (memory-love)
   ❌ UIButton, UILabel (UIKit)
   ✅ AppButton, AppCard, AppTextField, AppLoadingView
   ```

4. **Hardcode theme values**
   ```swift
   ❌ .foregroundColor(.blue)
   ❌ .font(.system(size: 16))
   ❌ .padding(20)
   ✅ .foregroundColor(AppColors.primary)
   ✅ .font(AppTypography.bodyMedium)
   ✅ .padding(AppSpacing.medium)
   ```

5. **Break existing navigation**
   ```swift
   If screen has NavigationLink(...) → don't change destination unless explicitly requested
   ```

6. **Skip Clean Architecture**
   ```swift
   ❌ ViewModel → Service directly
   ✅ ViewModel → UseCase → Repository → Service
   ```

7. **Add business logic to View**
   ```swift
   ❌ Button("Save") { FirebaseManager.shared.saveCustomer(...) }
   ✅ Button("Save") { viewModel.saveCustomer() }
   ```

---

## Stage 4: Workflow Review

### ❌ NEVER

1. **Skip review when ViewModel changed**
   ```
   If any @Published or method added/modified: MUST run pa-review-workflow
   ```

2. **Ignore Critical (🔴) issues**
   ```
   0 🔴 issues required to pass Stage 4
   If any 🔴 → fix before continuing
   ```

3. **Re-paste full file into conversation**
   ```
   ❌ Copy entire ViewModel into context
   ✅ Read by file path only
   ```

---

## Stage 5: UI Score

### ❌ NEVER

1. **Score without reading actual file**
   ```
   Read the edited [ScreenName].swift from disk, score actual implementation
   ```

2. **Accept score drop without fixing**
   ```
   If pre-edit was 8.5/10, post-edit must be ≥ 8.5/10
   If dropped → apply quick wins, re-score
   ```

3. **Skip dimensions**
   ```
   pa-review-ui-score has 8 dimensions, must score all
   ```

---

## Stage 6: Regression Check

### ❌ NEVER

1. **Skip regression check**
   ```
   Stage 6 is MANDATORY for all update-screen runs
   ```

2. **Ignore deleted properties**
   ```
   If Audit listed 5 @Published and post-edit has 4:
   → 🔴 REGRESSION: property deleted
   → Must restore before completing
   ```

3. **Ignore broken states**
   ```
   If pre-edit had loading/empty/error and post-edit missing one:
   → 🔴 REGRESSION: state broke
   → Must fix before completing
   ```

4. **Ignore navigation changes**
   ```
   If pre-edit had NavigationLink → CustomerDetailView and post-edit lost it:
   → 🔴 REGRESSION: navigation broke
   ```

---

## Anti-Hallucination

### ❌ NEVER invent

1. **App* components that don't exist**
   ```
   Valid: AppButton, AppCard, AppTextField, AppLoadingView, AppBadge, AppEmptyStateView, AppErrorView, AppNavigationBar, AppToast, AppSkeletonView, AppDivider
   
   Read laundry-dashboard/Core/Design/Components/ before using
   ```

2. **UseCase methods**
   ```
   If adding refundOrder() method:
   → Check if RefundOrderUseCase exists
   → If not: scaffold it first
   ```

3. **Repository methods**
   ```
   If calling customerRepository.search(query:):
   → Verify CustomerRepository protocol has this method
   → If not: add to protocol + impl
   ```

4. **AppColors / AppTypography / AppSpacing that don't exist**
   ```
   Read theme files before using:
   - laundry-dashboard/Core/Design/Theme/AppColors.swift
   - laundry-dashboard/Core/Design/Theme/AppTypography.swift
   - laundry-dashboard/Core/Design/Theme/AppSpacing.swift
   ```

---

## Laundry Dashboard Specific Rules

### ❌ NEVER

1. **Use Vietnamese strings**
   ```
   ❌ "Đang tải..."
   ✅ "Loading..."
   (Laundry Dashboard is a business app — English UI)
   ```

2. **Design for consumer UX**
   ```
   ✅ Business dashboard: tables, charts, KPIs, data-dense
   ❌ Social app: feeds, likes, stories
   ```

3. **Skip UseCase layer**
   ```
   Clean Architecture is MANDATORY
   ViewModel → UseCase → Repository (never skip)
   ```

---

## Token Budget

- **Max conversation tokens per stage:**
  - Stage 1: 800 (audit summary)
  - Stage 2: 500 (delta confirmation)
  - Stage 3: 600 (edit report)
  - Stage 4: 1500 (review table)
  - Stage 5: 1000 (score table)
  - Stage 6: 500 (regression checklist)

Total: ~5000 tokens per run (budget-friendly for medium edits).

---

## Fail-Fast Rules

Abort immediately if:
1. Screen files not found (ViewModel or View missing)
2. Files unreadable (permissions, corrupt)
3. Stage 3 edit fails (replace_string_in_file error)
4. Stage 6 finds > 3 regressions (too many — likely bad edit)

Report error clearly and suggest fix or rollback.
