# Guardrails — new-screen-build

Never-do patterns and anti-hallucination rules.

---

## General Rules

### ❌ NEVER

1. **Inline full file contents in conversation**
   ```
   ❌ "Here's the full View implementation: [200 lines]"
   ✅ "✓ Stage 4: UI written → MachineStatusView.swift"
   ```

2. **Run without reading plan file first**
   ```
   Pre-flight check: read .claude/tmp/[ScreenName].plan.md
   If not found → abort immediately
   ```

3. **Skip a stage without user permission**
   ```
   User can specify skip_stages=5,6
   Otherwise: run all stages in order
   ```

4. **Proceed after critical failure**
   ```
   If > 3 🔴 issues in Stage 5 → re-scaffold, don't continue to Stage 6
   ```

---

## Stage 3: Scaffold

### ❌ NEVER

1. **Write files to wrong paths**
   ```
   ❌ laundry-dashboard/Features/[FeatureGroup]/[ScreenName].swift
   ✅ laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName].swift
   ✅ laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName]ViewModel.swift
   ```

2. **Generate ViewModel without @MainActor**
   ```swift
   ❌ class MachineStatusViewModel: ObservableObject
   ✅ @MainActor final class MachineStatusViewModel: ObservableObject
   ```

3. **Generate init on main actor**
   ```swift
   ❌ init(useCase: FetchMachinesUseCase) { self.useCase = useCase }
   ✅ nonisolated init(useCase: FetchMachinesUseCase) { self.useCase = useCase }
   ```

4. **Put Service as ViewModel dependency**
   ```swift
   ❌ private let machineService: MachineService
   ✅ private let fetchMachinesUseCase: FetchMachinesUseCase
   ```

5. **Forget default values for @Published**
   ```swift
   ❌ @Published var machines: [Machine]
   ✅ @Published var machines: [Machine] = []
   ```

---

## Stage 4: UI Implementation

### ❌ NEVER

1. **Use wrong component prefix**
   ```swift
   ❌ MLButton, MLLabel, MLCard (memory-love components)
   ❌ UIButton, UILabel (UIKit)
   ✅ AppButton, AppCard, AppTextField, AppLoadingView, AppBadge
   ```

2. **Hardcode colors**
   ```swift
   ❌ .foregroundColor(.blue)
   ❌ .foregroundColor(Color(hex: "#3498db"))
   ✅ .foregroundColor(AppColors.primary)
   ```

3. **Hardcode typography**
   ```swift
   ❌ .font(.system(size: 16, weight: .bold))
   ✅ .font(AppTypography.titleMedium)
   ```

4. **Hardcode spacing**
   ```swift
   ❌ .padding(16)
   ❌ .padding(.horizontal, 24)
   ✅ .padding(AppSpacing.medium)
   ✅ .padding(.horizontal, AppSpacing.large)
   ```

5. **Use NavigationView**
   ```swift
   ❌ NavigationView { ... }
   ✅ NavigationStack { ... }
   ```

6. **Miss any of the 3 states**
   ```swift
   Must have:
   - if viewModel.isLoading { AppLoadingView() }
   - else if viewModel.items.isEmpty { AppEmptyStateView(...) }
   - else if let error = viewModel.errorMessage { AppErrorView(message: error, ...) }
   ```

7. **Put business logic in View**
   ```swift
   ❌ Button("Load") { fetchDataFromFirebase() }
   ✅ Button("Load") { viewModel.loadData() }
   ```

8. **Create View without injecting ViewModel**
   ```swift
   ❌ @StateObject var viewModel = MachineStatusViewModel()
   ✅ @StateObject var viewModel: MachineStatusViewModel
   (ViewModel injected via initializer or environment)
   ```

---

## Stage 5: Workflow Review

### ❌ NEVER

1. **Re-paste full file into conversation**
   ```
   ❌ Read file via copy-paste
   ✅ Read file by path using file tool
   ```

2. **Skip review if score looks good**
   ```
   Even if no obvious issues: still run full pa-review-workflow
   ```

3. **Ignore Critical (🔴) issues**
   ```
   If ≥ 1 🔴 issue: MUST fix before continuing
   If > 3 🔴 issues: re-scaffold + re-implement
   ```

4. **Rewrite full file for small fixes**
   ```
   ❌ Regenerate entire ViewModel
   ✅ Use replace_string_in_file for surgical edits
   ```

---

## Stage 6: UI Score

### ❌ NEVER

1. **Accept score below target without retry**
   ```
   If score < target_score:
   1. Apply quick wins
   2. Re-score once
   3. If still below → report and ask user
   ```

2. **Give fake score**
   ```
   Read actual file from disk
   Score based on real content
   Don't score based on plan or assumptions
   ```

3. **Skip dimensions**
   ```
   pa-review-ui-score has 8 dimensions
   Must score all 8 (even if some are N/A → give default 8.0)
   ```

---

## Anti-Hallucination

### ❌ NEVER invent

1. **App* components that don't exist**
   ```
   Valid: AppButton, AppCard, AppTextField, AppLoadingView, AppBadge, AppEmptyStateView, AppErrorView, AppNavigationBar, AppToast, AppSkeletonView, AppDivider
   
   Read laundry-dashboard/Core/Design/Components/ to verify before using
   ```

2. **AppColors that don't exist**
   ```
   Read laundry-dashboard/Core/Design/Theme/AppColors.swift to see available colors
   ```

3. **AppTypography styles**
   ```
   Read laundry-dashboard/Core/Design/Theme/AppTypography.swift to see available styles
   ```

4. **AppSpacing values**
   ```
   Read laundry-dashboard/Core/Design/Theme/AppSpacing.swift to see available spacing constants
   ```

5. **UseCase methods**
   ```
   If plan says "FetchMachinesUseCase" but file doesn't exist:
   → Generate scaffold for it in Stage 3
   → Don't assume methods exist
   ```

6. **Repository methods**
   ```
   If ViewModel calls `machineRepository.fetchAll()`:
   → Verify MachineRepository protocol has this method
   → If not: add it to protocol + impl
   ```

---

## Laundry Dashboard Specific Rules

### ❌ NEVER

1. **Use Vietnamese strings (business app uses English)**
   ```
   ❌ "Đang tải..."
   ✅ "Loading..."
   ```

2. **Design for consumer app UX**
   ```
   ✅ Business dashboard: data-dense, charts, tables, KPIs
   ❌ Social app: feeds, likes, comments
   ```

3. **Skip Clean Architecture**
   ```
   REQUIRED: Presentation → Domain → Data
   ViewModel → UseCase → Repository → Service
   ```

---

## Token Budget

- **Max conversation tokens per stage:**
  - Stage 3: 500 (file paths only)
  - Stage 4: 800 (component list + state confirmation)
  - Stage 5: 1500 (score table + issue list)
  - Stage 6: 1000 (score table)

If approaching limit → be more concise, don't repeat plan contents.

---

## Fail-Fast Rules

Abort immediately if:
1. Plan file not found
2. Plan file malformed (missing required sections)
3. Stage 3 file write fails (permissions)
4. Stage 4 produces > 500 line View (needs subviews)
5. Stage 5 has > 5 🔴 issues after 1 retry
6. Stage 6 score < target after 2 retries

Report error clearly and suggest fix.
