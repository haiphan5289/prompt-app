# Evaluation — new-screen-plan

Quality checklist for plan output. Each stage must pass before proceeding.

---

## Stage 1: Requirements (pa-flipped-interaction)

✅ **Pass Criteria:**
- [ ] All 6 questions answered (data, actions, states, navigation, animations, App* preferences)
- [ ] Data types specified (String, Int, Array<...>, Decimal, etc.)
- [ ] Actions are user-facing verbs (load, save, delete, filter — not technical terms)
- [ ] All 3 states covered: loading, empty, error
- [ ] Navigation targets named (or explicitly "none")
- [ ] App* component list includes at least 1 component

❌ **Fail Patterns:**
- Generic answers ("show some data")
- Missing state coverage (only loading, no empty/error)
- Technical jargon in user actions ("execute API call" instead of "fetch orders")
- No App* preferences specified

---

## Stage 2: Architecture (pa-chain-of-thought)

✅ **Pass Criteria:**

### ViewModel Properties
- [ ] Every data field from Stage 1 has a corresponding @Published property
- [ ] Loading state: `@Published var isLoading = false`
- [ ] Error state: `@Published var errorMessage: String?`
- [ ] Default values provided for all @Published vars
- [ ] Property names follow camelCase (no snake_case)

### Dependencies
- [ ] UseCase and Repository dependencies (Clean Architecture)
- [ ] Protocol used for Repository (e.g., `CustomerRepository`, not concrete impl)
- [ ] No singletons (`FirebaseManager.shared` ❌)
- [ ] UseCase dependencies follow proper naming (e.g., `FetchCustomersUseCase`)

### Data Flow
- [ ] Arrows clearly show direction: View → ViewModel → UseCase → Repository → Service → @Published → View
- [ ] Each user action mapped to a ViewModel method
- [ ] Firebase/Network interaction described (Firestore query, REST API call, etc.)
- [ ] Clean Architecture respected (ViewModel depends on domain layer, not data layer)

### Edge Cases
- [ ] At least 3 edge cases listed
- [ ] Each edge case has a mitigation strategy
- [ ] Error scenarios covered (network, missing data, validation)
- [ ] Empty data scenario described (first-run experience, no results)

### Feature Group
- [ ] Feature group matches existing folder in `laundry-dashboard/Features/`
- [ ] Valid groups: Auth, Customer, Dashboard, Settings, Transaction
- [ ] If uncertain → ask user before writing plan

---

## Plan File Format

✅ **Pass Criteria:**
- [ ] File written to `.claude/tmp/[ScreenName].plan.md`
- [ ] ISO timestamp in `generated:` field
- [ ] All 7 sections present: Requirements, Architecture (with 4 subsections), Feature Group
- [ ] Swift code blocks use ```swift
- [ ] Markdown valid (no broken headers or lists)

❌ **Fail Patterns:**
- Plan written to conversation instead of disk
- Missing timestamp
- Code blocks without language tag
- Feature group missing or invalid

---

## Cross-Stage Consistency

✅ **Pass Criteria:**
- [ ] Every data field in Requirements → @Published property in Architecture
- [ ] Every action in Requirements → ViewModel method in Data Flow
- [ ] Every state (loading/empty/error) in Requirements → @Published property or strategy in Architecture
- [ ] App* components from Requirements mentioned in Data Flow or Edge Cases

---

## Token Efficiency

✅ **Pass Criteria:**
- [ ] Plan file < 100 lines (concise, no fluff)
- [ ] Stage 1 output < 20 lines (bulleted, not prose)
- [ ] Stage 2 output < 50 lines (structured, not paragraph form)

❌ **Fail Patterns:**
- Repeating the same information multiple times
- Verbose explanations of obvious patterns
- Full method implementations (should be TODO stubs only)

---

## Scoring

| Dimension | Weight | Pass Threshold |
|---|---|---|
| Requirements Completeness | 25% | 6/6 questions answered |
| Architecture Correctness | 30% | All @Published properties + dependencies + data flow valid |
| Edge Case Coverage | 20% | ≥ 3 edge cases with mitigations |
| Plan File Quality | 15% | Valid markdown, correct path, all sections |
| Consistency | 10% | No drift between stages |

**Overall Pass:** ≥ 80% (4/5 dimensions pass)

---

## Example Pass/Fail

### ✅ Pass Example

```markdown
# Plan: OrderDetailView
generated: 2026-05-13T10:00:00Z

## Requirements
- Data: order (Order), items (Array<OrderItem>), customer (Customer)
- Actions: updateStatus, deleteOrder, printReceipt
- States: loading (spinner), empty (order not found), error (toast)
- Navigation: back to list, customer detail sheet
- Animations: status transition
- App* preferences: AppCard, AppButton, AppBadge

## Architecture
### ViewModel Properties
```swift
@Published var order: Order?
@Published var items: [OrderItem] = []
@Published var isLoading = false
@Published var errorMessage: String?
```

### Dependencies
```swift
private let fetchOrderUseCase: FetchOrderUseCase
private let orderRepository: OrderRepository
```

### Data Flow
OrderDetailView → vm.loadOrder() → FetchOrderUseCase → OrderRepository → Firebase → @Published order

### Edge Cases
- Order deleted → show "Not found" + navigate back
- Price calculation error → recalculate + warning
- Network timeout → show cached data

### Feature Group
Dashboard
```
**Score:** 95% ✅

---

### ❌ Fail Example

```markdown
# Plan: OrderView
generated: 2026-05-13

## Requirements
- Data: some order stuff
- Actions: TBD

## Architecture
var order: Order
```
**Why:** Vague requirements, missing states, wrong syntax (@Published missing), no dependencies, no feature group.

**Score:** 20% ❌
