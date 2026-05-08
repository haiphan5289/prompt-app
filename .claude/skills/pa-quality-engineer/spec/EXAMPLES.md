# Examples — pa-quality-engineer

## Example 1: Transformer Feature Validation

**Input:**
```
PRD: |
  - User enters a prompt in the text field
  - User selects a pattern from the list
  - Tapping "Transform" applies the pattern and shows enhanced prompt
  - Empty input shows a validation snackbar, does not transform
  - Result is saved to history automatically
TARGET: lib/features/transformer/
```

**Output:**
```
## QE Report: Transformer Feature

### Severity Summary
CRITICAL (must fix): 1 issue
MAJOR (should fix): 2 issues
MINOR (nice to fix): 1 issue

---

### CRITICAL Issues
**[Business Requirements]** lib/features/transformer/domain/usecases/transform_use_case.dart:67
Problem: Empty input is not validated — transformer runs on whitespace-only strings
Expected: PRD states empty input shows validation snackbar and does not transform
Actual: TransformUseCase.execute() is called regardless of input content
Fix: Add guard in Notifier: if (input.trim().isEmpty) { show snackbar; return; }

### MAJOR Issues
**[Tests]** test/features/transformer/
Problem: No widget test for empty input validation flow
Expected: Widget test verifying snackbar appears and transformer is not called on empty input
Fix: Add test case in prompt_input_screen_test.dart

**[Architecture]** lib/features/transformer/presentation/notifiers/transformer_notifier.dart:22
Problem: Notifier directly imports PatternLocalDataSource from data layer
Fix: Inject GetPatternUseCase from domain layer instead

### MINOR Issues
**[UI]** lib/features/transformer/presentation/screens/prompt_input_screen.dart:91
Problem: Hardcoded color Colors.blue on Transform button
Fix: Use Theme.of(context).colorScheme.primary

---

### Passing Dimensions
- Riverpod: PASS — ref usage correct, AsyncValue.guard used, all .when() cases handled
- Transformer Logic: PASS — all {{variable}} placeholders substituted, trim applied, history saved

### Recommendation
BLOCK release — empty input validation missing (acceptance criterion unmet)
```

---

## Example 2: History Feature — All Passing

**Input:**
```
PRD: |
  - History screen shows all past transformations
  - Each item shows original prompt, enhanced prompt, and pattern name
  - User can tap an item to copy the enhanced prompt
  - User can swipe to delete a history item
TARGET: lib/features/history/
```

**Output:**
```
## QE Report: History Feature

### Severity Summary
CRITICAL (must fix): 0 issues
MAJOR (should fix): 0 issues
MINOR (nice to fix): 2 issues

---

### MINOR Issues
**[UI]** lib/features/history/presentation/screens/history_screen.dart:44
Problem: HistoryItemWidget missing const constructor
Fix: Add const to constructor: const HistoryItemWidget({super.key, required this.item});

**[UI]** lib/features/history/presentation/screens/history_screen.dart:28
Problem: build() method is 53 lines — slightly over guideline
Fix: Extract _EmptyHistoryPlaceholder as a named const widget

---

### Passing Dimensions
- Business Requirements: PASS — all 4 acceptance criteria implemented and verified
- Architecture: PASS — no cross-layer imports, UseCase correctly used
- Riverpod: PASS — ref patterns correct, all AsyncValue cases handled
- Tests: PASS — UseCase unit test + widget test covering loading/data/error states
- Transformer Logic: N/A — feature does not touch transformer

### Recommendation
Ship as-is — no blocking or major issues found
```
