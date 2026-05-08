# Execution Workflow — pa-quality-engineer

## Step 1: Ingest Inputs

Read the PRD (inline or from file path) and the TARGET folder/files.

```bash
# List the target folder contents
ls -R lib/features/<feature>/

# Run static checks
grep -r "import.*data/" lib/features/*/presentation/
grep -r "import.*presentation/" lib/features/*/domain/
grep -n "ref\.watch" lib/features/*/presentation/
grep -n "setState" lib/features/*/presentation/
grep -n "Color(0x\|Colors\." lib/features/*/presentation/
grep -n "fontSize:\|EdgeInsets.all([0-9]" lib/features/*/presentation/
find test/features/ -name "*_test.dart" | sort
flutter test --coverage 2>&1 | tail -5
```

If the feature touches transformer code, also run:
```bash
grep -n "{{" lib/features/transformer/
grep -n "replaceAll" lib/features/transformer/domain/usecases/
```

## Step 2: Run All 6 Dimensions in Parallel

Evaluate all dimensions simultaneously — do not block on one before starting another.

### Dimension 1: Business Requirements
For each acceptance criterion in the PRD:
- Is it implemented?
- Does it behave exactly as specified?
- Are edge cases from the PRD handled?

Flag any criterion not met, partially met, or behavior differs from spec.

### Dimension 2: Architecture Compliance
- Presentation never imports from `data/`
- Domain never imports Flutter or Riverpod packages
- All repository calls go through UseCases (not direct from Notifier)
- New providers registered in `lib/core/di/providers.dart`

### Dimension 3: Riverpod Correctness
- `ref.watch` only inside `build()` methods
- `ref.read` only in callbacks and event handlers
- All Notifiers use `AsyncValue.guard()` for async operations
- State immutability: `state = state.copyWith(...)` not `state.field = ...`
- `AsyncValue.when()` handles all three cases (data/loading/error)
- `@riverpod` annotation + `part '*.g.dart'` present on all new providers

### Dimension 4: Prompt Transformer Logic
*(Only if feature touches transformer or pattern library)*
- All `{{variable}}` placeholders substituted in `_applyPattern()`
- `rawPrompt.trim()` applied before injection
- New patterns have: `id`, `name`, `category`, `template`, `examples` (≥3)
- No duplicate pattern `id` in seed data
- `TransformResult` saved to history after every transformation
- Empty/whitespace input handled (not submitted to transformer)

### Dimension 5: UI Consistency
- All colors from `Theme.of(context).colorScheme.*` or `AppColors.*`
- All typography from `Theme.of(context).textTheme.*`
- All spacing from `AppSpacing.*` constants
- No `Colors.blue`, `Colors.red`, etc.
- `const` constructors on all applicable widgets
- `build()` methods under 50 lines

### Dimension 6: Test Coverage
- Every new UseCase has a unit test (happy path + error path)
- Every new Screen has a widget test (loading + data + error states)
- Transformer patterns tested: input → expected enhanced output
- No real Hive boxes in tests (use fakes/mocks)
- `flutter test` passes with zero failures

## Step 3: Classify Issues by Severity

| Level | Meaning |
|---|---|
| CRITICAL | Wrong behavior, crash risk, or unmet acceptance criterion |
| MAJOR | Violates architecture, missing test, or fragile code that will break |
| MINOR | Style inconsistency, missing const, suboptimal but not wrong |

## Step 4: Output QE Report

Emit the report in the format defined in [OUTPUT_SCHEMA.md](OUTPUT_SCHEMA.md).
