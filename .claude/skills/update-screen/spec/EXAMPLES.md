# Examples — update-screen

## Example 1: OrderDetailView — Add Refund Button

**Input:**
```
/update-screen OrderDetailView Add a "Refund Order" button in the actions section
```

**Stage 1 — Audit:**
```
View: AppCard (order info), AppBadge (status), AppButton (Update Status, Print Receipt)
States: loading ✓ empty ✓ error ✓
ViewModel: order: Order?, isLoading: Bool, errorMessage: String?
Methods: onAppear(), loadOrder(id:), updateStatus(), printReceipt()
Dependencies: FetchOrderUseCase, UpdateOrderUseCase, OrderRepository
```

**Stage 2 — Delta confirmed:**
```
+ @Published showRefundConfirm: Bool = false
+ refundOrder() async throws
+ View: AppButton "Refund Order" (destructive style) in actions section
- No removals
```

**Stage 3 — Edits applied:**
```swift
// ViewModel — added below existing @Published
@Published var showRefundConfirm: Bool = false

// ViewModel — new method
func refundOrder() async {
    isLoading = true
    defer { isLoading = false }
    do {
        guard let order = order else { return }
        try await refundOrderUseCase.execute(orderId: order.id)
        errorMessage = "Order refunded successfully"
        await loadOrder(id: order.id) // Reload to show updated status
    } catch {
        errorMessage = "Failed to refund order. Please try again."
    }
}

// View — new button in actions section
AppButton("Refund Order", variant: .destructive) {
    showRefundConfirm = true
}
.confirmationDialog("Refund Order", isPresented: $viewModel.showRefundConfirm) {
    Button("Refund", role: .destructive) {
        Task { await viewModel.refundOrder() }
    }
}
```

**Stage 4 — Workflow:** 9.0/10, 0 issues
**Stage 5 — UI Score:** 8.7/10
**Stage 6 — Regression:** ✓ all 3 pre-edit @Published present, all buttons present, states intact

---

## Example 2: CustomerListScreen — Add Search Bar

**Input:**
```
/update-screen CustomerListScreen Add search bar with real-time filtering
```

**Stage 1 — Audit:**
```
View: AppTextField (none), AppCard (customer rows), AppButton (Add Customer), AppLoadingView
States: loading ✓ empty ✓ error ✓
ViewModel: customers: [Customer], isLoading: Bool, errorMessage: String?
Methods: onAppear(), fetchCustomers(), deleteCustomer(id:)
Dependencies: FetchCustomersUseCase, DeleteCustomerUseCase, CustomerRepository
```

**Stage 2 — Delta confirmed:**
```
+ @Published searchQuery: String = ""
+ computed var filteredCustomers: [Customer]
+ View: AppTextField search bar above list
- No removals
```

**Stage 3 — Edits applied:**
```swift
// ViewModel — new @Published
@Published var searchQuery: String = ""

// ViewModel — computed property
var filteredCustomers: [Customer] {
    guard !searchQuery.isEmpty else { return customers }
    return customers.filter { customer in
        customer.name.localizedCaseInsensitiveContains(searchQuery) ||
        customer.phone.contains(searchQuery)
    }
}

// View — new MARK section before list
// MARK: - Search
private var searchBar: some View {
    AppTextField(
        "Search customers...",
        text: $viewModel.searchQuery,
        variant: .outlined
    )
    .padding(.horizontal, AppSpacing.medium)
}
```

**Stage 4 — Workflow:** 8.5/10, 0 issues
**Stage 5 — UI Score:** 8.8/10
**Stage 6 — Regression:** ✓ customers, isLoading, errorMessage present, fetchCustomers() intact

---

## Example 3: MachineStatusView — Add Maintenance Date

**Input:**
```
/update-screen MachineStatusView Show last maintenance date below each machine card
```

**Stage 1 — Audit:**
```
View: AppCard (machine cards), AppBadge (status), AppLoadingView, AppEmptyStateView
States: loading ✓ empty ✓ error ✓
ViewModel: machines: [Machine], isLoading: Bool, errorMessage: String?
Methods: onAppear(), loadMachines()
Dependencies: FetchMachinesUseCase, MachineRepository
```

**Stage 2 — Delta confirmed:**
```
+ View only change: add maintenance date label below status badge in machine card
+ No ViewModel changes (maintenance date already in Machine entity)
→ Can skip Stage 4 (Workflow Review)
```

**Stage 3 — Edits applied:**
```swift
// View — modified machine card
private func machineCard(_ machine: Machine) -> some View {
    AppCard {
        VStack(alignment: .leading, spacing: AppSpacing.small) {
            Text(machine.name)
                .font(AppTypography.titleMedium)
            
            AppBadge(machine.status.displayName, color: machine.status.color)
            
            // NEW: Maintenance date
            if let lastMaintenance = machine.lastMaintenanceDate {
                Text("Last maintenance: \(lastMaintenance.formatted(date: .abbreviated, time: .omitted))")
                    .font(AppTypography.bodySmall)
                    .foregroundColor(AppColors.textSecondary)
            }
        }
    }
}
```

**Stage 4 — SKIPPED (no ViewModel changes)
**Stage 5 — UI Score:** 8.5/10
**Stage 6 — Regression:** ✓ all components intact, machine cards render correctly

---

## Example 4: RevenueAnalyticsView — Add Export Button

**Input:**
```
/update-screen RevenueAnalyticsView Add export to CSV button in toolbar
```

**Stage 1 — Audit:**
```
View: AppCard (revenue chart), AppButton (period selectors), Custom ChartView
States: loading ✓ empty ✓ error ✓
ViewModel: revenueData: [RevenueDataPoint], selectedPeriod: Period, isLoading: Bool
Methods: onAppear(), loadData(period:), changePeriod(_:)
Dependencies: FetchRevenueAnalyticsUseCase, DashboardRepository
```

**Stage 2 — Delta confirmed:**
```
+ @Published showExportSheet: Bool = false
+ exportToCSV() method (returns CSV string)
+ View: AppButton "Export" in toolbar
- No removals
```

**Stage 3 — Edits applied:**
```swift
// ViewModel
@Published var showExportSheet: Bool = false

func exportToCSV() -> String {
    var csv = "Date,Revenue,Orders\n"
    for point in revenueData {
        csv += "\(point.date),\(point.revenue),\(point.orderCount)\n"
    }
    return csv
}

// View — toolbar
.toolbar {
    ToolbarItem(placement: .navigationBarTrailing) {
        AppButton("Export", variant: .outlined) {
            viewModel.showExportSheet = true
        }
    }
}
.sheet(isPresented: $viewModel.showExportSheet) {
    ExportCSVSheet(csvData: viewModel.exportToCSV())
}
```

**Stage 4 — Workflow:** 8.5/10, 0 issues
**Stage 5 — UI Score:** 8.6/10
**Stage 6 — Regression:** ✓ chart, period selectors, loadData() all intact

---

## Example 5: Regression Found and Fixed

**Input:**
```
/update-screen CustomerFormSheet Add email validation
```

**Stage 6 — Regression check (first pass):**
```
❌ Regression found:
  - Pre-edit: @Published var phone: String = ""
  - Post-edit: phone property missing (accidentally deleted during email validation refactor)
  
→ Re-adding phone property...
```

**Stage 6 — After fix:**
```
✓ Regression check: all properties restored
  @Published: 4 pre-edit + 1 new = 5 total ✓
```

---

## Anti-Example: Rewriting Full File (WRONG)

**Bad Stage 3:**
```
Here's the updated CustomerListScreen.swift: [pastes 300 lines]
```

**Correct Stage 3:**
```
✓ Stage 3: Applied 3 edits
  ViewModel: + searchQuery: String
  View: + searchBar in // MARK: - Search
```

**Rule:** NEVER rewrite full files. Surgical edits only.
