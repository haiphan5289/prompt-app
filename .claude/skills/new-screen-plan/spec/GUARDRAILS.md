# Guardrails — new-screen-plan

Never-do patterns and anti-hallucination rules.

---

## Stage 1: Requirements

### ❌ NEVER

1. **Proceed without user confirmation if input is vague**
   ```
   Bad: /new-screen-plan DashboardView for stuff
   → DON'T assume what "stuff" means — ask first
   ```

2. **Skip state coverage**
   ```
   Bad: Requirements only mention loading state
   → MUST cover all 3: loading, empty, error
   ```

3. **Use technical jargon in user-facing actions**
   ```
   Bad: "execute Firestore query"
   Good: "fetch orders"
   ```

4. **Forget App* component preferences**
   ```
   Bad: Requirements list no App* components
   → Ask user which components to use, or default to AppButton/AppCard/AppLoadingView
   ```

---

## Stage 2: Architecture

### ❌ NEVER

1. **Skip UseCase layer**
   ```swift
   ❌ ViewModel → Repository directly
   ✅ ViewModel → UseCase → Repository (Clean Architecture)
   ```

2. **Put Service as a ViewModel dependency**
   ```swift
   ❌ private let orderService: OrderService
   ✅ private let fetchOrderUseCase: FetchOrderUseCase
   ✅ private let orderRepository: OrderRepository
   ```
   **Why:** ViewModel depends on domain layer (UseCase/Repository), not data layer (Service).

3. **Forget `@Published` on state properties**
   ```swift
   ❌ var isLoading = false
   ✅ @Published var isLoading = false
   ```

4. **Use concrete types instead of protocols**
   ```swift
   ❌ private let repo: CustomerRepositoryImpl
   ✅ private let repo: CustomerRepository
   ```

5. **Suggest singletons**
   ```swift
   ❌ FirebaseManager.shared.fetchOrders()
   ✅ orderRepository.fetchAll()
   ```

6. **Forget default values for @Published properties**
   ```swift
   ❌ @Published var orders: [Order]
   ✅ @Published var orders: [Order] = []
   ```

7. **Design data flow backward (Firebase → View)**
   ```
   ❌ Firebase → @Published → View → ViewModel
   ✅ View → ViewModel → UseCase → Repository → Firebase → @Published → View
   ```

8. **Omit edge cases**
   ```
   Bad: Architecture only describes happy path
   → MUST list ≥ 3 edge cases (empty data, network fail, validation error, etc.)
   ```

---

## Plan File Writing

### ❌ NEVER

1. **Print plan to conversation instead of disk**
   ```
   ❌ Here's the plan: [paste markdown]
   ✅ Write to .claude/tmp/[ScreenName].plan.md and report file path only
   ```

2. **Use absolute paths in plan file references**
   ```
   ❌ /Users/hai/laundry-dashboard/Features/Customer/CustomerListScreen.swift
   ✅ laundry-dashboard/laundry-dashboard/Features/Customer/...
   ```

3. **Forget the Feature Group**
   ```
   Bad: Plan has no "Feature Group" section
   → MUST specify which Features/ subfolder: Auth | Customer | Dashboard | Settings | Transaction
   ```

4. **Use invalid feature group names**
   ```
   ❌ Feature Group: Screens
   ❌ Feature Group: Views
   ✅ Feature Group: Customer
   ```
   Valid groups: `Auth`, `Customer`, `Dashboard`, `Settings`, `Transaction`

5. **Overwrite existing plan without asking**
   ```
   Pre-flight check: if .claude/tmp/[ScreenName].plan.md exists
   → Ask: "Overwrite or use existing?"
   → DON'T silently overwrite
   ```

---

## Laundry Dashboard Specific Rules

### ❌ NEVER

1. **Suggest wrong component prefix**
   ```
   ❌ MLLabel, MLButton, UILabel, UIButton
   ✅ AppButton, AppCard, AppTextField, AppLoadingView
   ```

2. **Use NavigationView**
   ```
   ❌ NavigationView { ... }
   ✅ NavigationStack { ... }
   ```

3. **Hardcode colors**
   ```
   ❌ Color.blue, Color(hex: "#FF5733")
   ✅ AppColors.primary, AppColors.secondary
   ```

4. **Design ViewModels without @MainActor**
   ```
   All ViewModels in laundry-dashboard MUST have:
   @MainActor final class [Name]ViewModel: ObservableObject
   ```

5. **Design init with dependencies on main actor**
   ```swift
   ❌ init(repo: OrderRepository) { self.repo = repo }
   ✅ nonisolated init(repo: OrderRepository) { self.repo = repo }
   ```

6. **Forget Clean Architecture layers**
   ```
   REQUIRED LAYERS (in order):
   Presentation (ViewModel) → Domain (UseCase + Repository protocol) → Data (Repository impl + Service)
   ```

---

## Anti-Hallucination

### ❌ NEVER invent

1. **Feature groups that don't exist**
   ```
   Before writing "Feature Group: X", verify X exists in laundry-dashboard/Features/
   Valid: Auth, Customer, Dashboard, Settings, Transaction
   ```

2. **App* components that don't exist**
   ```
   Read laundry-dashboard/Core/Design/Components/ to see available components before suggesting
   Valid: AppButton, AppCard, AppTextField, AppLoadingView, AppBadge, AppEmptyStateView, AppErrorView, AppNavigationBar, AppToast, AppSkeletonView, AppDivider
   ```

3. **Repository methods**
   ```
   Don't assume OrderRepository.deleteOrder() exists — mark as TODO if uncertain
   ```

4. **Firebase collection names**
   ```
   Don't specify Firestore paths in the plan — leave that to implementation
   ```

---

## Token Budget

- **Max conversation tokens for Stage 1:** 500
- **Max conversation tokens for Stage 2:** 1000
- **Max plan file size:** 100 lines

If approaching limit → simplify output, move details to plan file.

---

## Fail-Fast Rules

Abort immediately if:
1. User input has no screen name → "Error: Please provide [ScreenName] [description]"
2. Stage 1 answers are all "I don't know" → "Cannot proceed without requirements"
3. Invalid feature group specified → "Valid groups: Auth, Customer, Dashboard, Settings, Transaction"
4. Plan file write fails → "Error writing plan to disk. Check permissions."

Do NOT proceed to Stage 2 if Stage 1 fails any Pass Criteria from EVAL.md.
