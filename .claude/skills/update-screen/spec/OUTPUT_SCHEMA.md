# Output Schema — update-screen

## Stage 1 Output (Audit Summary)

```
Audit: [ScreenName]
View:
  - App* components: AppButton (2×), AppCard (5×), AppTextField (1×), AppLoadingView (1×)
  - States: loading ✓  empty ✓  error ✓
  - Navigation: → CustomerDetailView on row tap
  - MARK sections: // MARK: - Body, // MARK: - Customer List, // MARK: - Empty State
ViewModel:
  - @Published: customers: [Customer] = [], isLoading: Bool = false, errorMessage: String? = nil
  - Methods: onAppear(), fetchCustomers(), deleteCustomer(id:)
  - Dependencies: FetchCustomersUseCase, DeleteCustomerUseCase, CustomerRepository
  - Risks: none
```

## Stage 2 Output (Delta Confirmation)

```
Delta for [ScreenName]:
+ New @Published: searchQuery: String = ""
+ New @Published: filteredCustomers: [Customer] = []
+ New method: filterCustomers()
+ New View section: search bar above list
- No removals
```

## Stage 3 Output (Edit Report)

```
✓ Stage 3: Applied 4 edits
  ViewModel: + searchQuery: String, + filteredCustomers: [Customer], + filterCustomers()
  View: + AppTextField search bar in // MARK: - Search Section
```

## Stage 4 Output (Workflow Review)

Score table (from pa-review-workflow) + list of issues fixed.

## Stage 5 Output (UI Score)

Score table (from pa-review-ui-score).

## Stage 6 Output (Regression Report)

```
Regression check: ✓
  @Published: 3 pre-edit + 2 new = 5 total ✓
  App* components: all 9 pre-edit components present ✓
  States: loading ✓ empty ✓ error ✓
  Navigation: → CustomerDetailView still wired ✓
  Method signatures: unchanged ✓
```

## Final Summary

```
✅ update-screen complete: [ScreenName]
Stage 1: Audit — 3 @Published, 9 App* components, all states present
Stage 2: Delta — +2 @Published, +1 method, +1 subview
Stage 3: 4 edits applied
Stage 4: Workflow — 8.5/10, 1 issue fixed
Stage 5: UI Score — 8.5/10 ✓
Stage 6: Regression — ✓ no regressions
```
