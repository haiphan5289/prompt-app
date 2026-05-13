# Examples — new-screen-plan

## Example 1: Machine Status Dashboard

**User Input:**
```
/new-screen-plan MachineStatusView Show real-time washing machine status with color coding
```

**Stage 1 Output (Requirements):**
```
Requirements gathered:
- Data: machine list (Array<Machine>), status per machine (enum: idle/running/maintenance), cycle time remaining (Int)
- Actions: refresh status, filter by status, navigate to machine detail
- States: loading ✓ empty ✓ error ✓
- Navigation: to MachineDetailView
- Animations: status color pulse
- App* components: AppCard, AppBadge, AppLoadingView, AppButton
```

**Stage 2 Output (Architecture):**
```swift
// ViewModel Properties
@Published var machines: [Machine] = []
@Published var filterStatus: MachineStatus?
@Published var isLoading = false
@Published var errorMessage: String?

// Dependencies
private let fetchMachinesUseCase: FetchMachinesUseCase
private let machineRepository: MachineRepository

// Data Flow
MachineStatusView → vm.loadMachines() → FetchMachinesUseCase.execute() → MachineRepository.fetchAll() → Firebase → @Published machines → View re-render

// Edge Cases
- No machines configured → empty state "No machines available"
- Firebase fetch fails → error state with retry button
- Status real-time listener disconnects → show "Offline" badge
```

**Plan File Written:**
```markdown
# Plan: MachineStatusView
generated: 2026-05-13T10:30:00Z

## Requirements
- Data: machine list, status, cycle time
- Actions: refresh, filter, navigate to detail
- States: loading (spinner), empty ("No machines"), error (message + retry)
- Navigation: to MachineDetailView
- Animations: status badge pulse
- App* preferences: AppCard, AppBadge, AppLoadingView, AppButton

## Architecture

### ViewModel Properties
```swift
@Published var machines: [Machine] = []
@Published var filterStatus: MachineStatus?
@Published var isLoading = false
@Published var errorMessage: String?
```

### Dependencies
```swift
private let fetchMachinesUseCase: FetchMachinesUseCase
private let machineRepository: MachineRepository
```

### Data Flow
MachineStatusView → vm.loadMachines() → FetchMachinesUseCase → MachineRepository → Firebase → @Published update → View

### Edge Cases
- No machines → empty state
- Network error → error state with retry
- Real-time listener fails → offline badge

### Feature Group
Dashboard
```

---

## Example 2: Customer Order Detail

**User Input:**
```
/new-screen-plan OrderDetailView Full screen view of a laundry order with items and pricing
```

**User Answers (pa-flipped-interaction):**
1. Data: order (Order), items (Array<OrderItem>), customer info (Customer), total price (Decimal), status (OrderStatus)
2. Actions: update status, add item, edit item, delete order, print receipt
3. States: loading, empty (order not found), error
4. Navigation: back to order list, customer detail sheet
5. Animations: status change transition
6. App* preferences: AppCard, AppButton, AppTextField, AppBadge

**Stage 2 Output (Architecture):**
```swift
// ViewModel Properties
@Published var order: Order?
@Published var items: [OrderItem] = []
@Published var customer: Customer?
@Published var isLoading = false
@Published var errorMessage: String?
@Published var showStatusSheet = false
@Published var showDeleteConfirm = false

// Dependencies
private let fetchOrderUseCase: FetchOrderUseCase
private let updateOrderUseCase: UpdateOrderUseCase
private let deleteOrderUseCase: DeleteOrderUseCase
private let orderRepository: OrderRepository

// Data Flow
OrderDetailView → vm.loadOrder(id:) → FetchOrderUseCase → OrderRepository → Firebase → @Published order
OrderDetailView → vm.updateStatus() → UpdateOrderUseCase → OrderRepository → Firebase → reload order

// Edge Cases
- Order deleted by another user → show "Order not found" + navigate back
- Price calculation error → show warning banner + recalculate
- Update fails (network) → show error toast, keep old data
- Concurrent edits → optimistic UI + rollback on conflict
```

---

## Example 3: Revenue Analytics Dashboard

**User Input:**
```
/new-screen-plan RevenueAnalyticsView Dashboard showing daily/weekly/monthly revenue charts
```

**User Answers:**
1. Data: revenue data (Array<RevenueDataPoint>), period selector (enum: day/week/month), total revenue (Decimal), order count (Int)
2. Actions: change period, export data, refresh
3. States: loading (initial fetch), empty (no data for period), error (fetch failed)
4. Navigation: none (standalone dashboard)
5. Animations: chart fade-in on data load
6. App* preferences: AppCard, AppButton, AppLoadingView (for charts - custom view)

**Stage 2 Output:**
```swift
// ViewModel Properties
@Published var revenueData: [RevenueDataPoint] = []
@Published var selectedPeriod: Period = .week
@Published var totalRevenue: Decimal = 0
@Published var orderCount: Int = 0
@Published var isLoading = false
@Published var errorMessage: String?

// Dependencies
private let fetchRevenueUseCase: FetchRevenueAnalyticsUseCase
private let dashboardRepository: DashboardRepository

// Data Flow
RevenueAnalyticsView.onAppear → vm.loadData(period:) → FetchRevenueAnalyticsUseCase → DashboardRepository → Analytics Service → @Published revenueData

// Edge Cases
- No orders in selected period → empty state "No revenue data for this period"
- Analytics service timeout → show cached data + "Using cached data" badge
- Large dataset (> 1000 points) → downsample for chart performance
- Period change mid-load → cancel previous fetch

### Feature Group
Dashboard
```

---

## Example 4: Customer Form Screen

**User Input:**
```
/new-screen-plan CustomerFormSheet Form for adding/editing customer information
```

**User Answers:**
1. Data: name (String), phone (String), email (String?), address (String?), validation states
2. Actions: save customer, cancel
3. States: none (form screen, no async loading initially)
4. Navigation: dismiss sheet on save/cancel
5. Animations: shake on validation error
6. App* preferences: AppTextField, AppButton, AppCard

**Stage 2 Output:**
```swift
// ViewModel Properties
@Published var name = ""
@Published var phone = ""
@Published var email = ""
@Published var address = ""
@Published var nameError: String?
@Published var phoneError: String?
@Published var canSave = false
@Published var isSaving = false

// Dependencies
private let addCustomerUseCase: AddCustomerUseCase
private let updateCustomerUseCase: UpdateCustomerUseCase
private let customerRepository: CustomerRepository

// Data Flow
CustomerFormSheet → vm.save() → AddCustomerUseCase.execute() → CustomerRepository.save() → Firebase → dismiss on success

// Edge Cases
- Empty required fields → show inline validation errors
- Phone number format invalid → "Invalid phone number"
- Duplicate customer (same phone) → show "Customer already exists" warning
- Save fails (network) → keep form open, show error toast, allow retry

### Feature Group
Customer
```

---

## Anti-Example: Too Vague Input

**User Input:**
```
/new-screen-plan DashboardView for showing stuff
```

**pa-flipped-interaction triggers:**
```
❌ Input too vague. Need clarification:
1. What data to display? (revenue, orders, machines, customers?)
2. Which actions? (filter, export, refresh?)
3. Is this the main dashboard or a specific analytics view?

Please provide more details or run:
  /new-screen-plan DashboardHomeScreen Show overview: today's revenue, active orders, machine status
```

**Rule:** Never proceed with Stage 2 unless requirements are specific.
