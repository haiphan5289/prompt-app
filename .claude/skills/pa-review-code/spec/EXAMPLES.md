# Examples — pa-review-code

## Example 1: Clean Transformer Feature

**Input:**
```
TARGET: lib/features/transformer/
```

**Output:**
```
## Review: transformer/

### Architecture  PASS
### Riverpod      WARN
### Null Safety   PASS
### Widget        WARN
### Performance   PASS
### Domain Logic  PASS
### Tests         FAIL

---

**WARN** `lib/features/transformer/presentation/screens/prompt_input_screen.dart:87`
Problem: build() method is 72 lines — exceeds 50-line guideline
Fix: Extract _PatternSelectorSection and _ResultSection as named widgets

**WARN** `lib/features/transformer/presentation/notifiers/transformer_notifier.dart:34`
Problem: ref.watch used inside a button callback
Fix: Replace with ref.read(transformerNotifierProvider.notifier)

**FAIL** `test/features/transformer/`
Problem: No widget test for PromptInputScreen
Fix: Add test/features/transformer/presentation/screens/prompt_input_screen_test.dart covering loading, data, and error states

Recommendation: merge with fixes noted (address test gap before next sprint)
```

---

## Example 2: Null Safety Violation

**Input:**
```
TARGET: lib/features/history/presentation/screens/history_screen.dart
```

**Output:**
```
## Review: history_screen.dart

### Architecture  PASS
### Riverpod      PASS
### Null Safety   FAIL
### Widget        PASS
### Performance   WARN
### Tests         WARN

---

**FAIL** `history_screen.dart:54`
Problem: BuildContext used after await without mounted check
  await deleteUseCase.execute(id);
  ScaffoldMessenger.of(context).showSnackBar(...); // context may be dead
Fix: Add `if (!context.mounted) return;` after the await

**WARN** `history_screen.dart:31`
Problem: state.value! used without .hasValue guard
Fix: Use state.valueOrNull ?? [] or guard with state.hasValue

**WARN** `history_screen.dart:19`
Problem: ListView with .map() instead of ListView.builder
Fix: Use ListView.builder(itemCount: items.length, itemBuilder: ...)

Recommendation: BLOCK merge — null safety FAIL is a crash risk
```

---

## Example 3: Architecture Violation

**Input:**
```
TARGET: lib/features/pattern_library/presentation/
```

**Output:**
```
## Review: pattern_library/presentation/

### Architecture  FAIL
### Riverpod      PASS
### Null Safety   PASS
### Widget        PASS
### Performance   PASS
### Tests         WARN

---

**FAIL** `pattern_library/presentation/notifiers/pattern_notifier.dart:12`
Problem: Notifier imports from data/ layer directly
  import '../../data/datasources/pattern_local_data_source.dart';
Fix: Notifier should only depend on a UseCase or repository interface from domain/

**FAIL** `pattern_library/presentation/notifiers/pattern_notifier.dart:44`
Problem: Notifier calls repository directly — bypasses UseCase
  final patterns = await _repository.getAll();
Fix: Inject and call GetAllPatternsUseCase instead

Recommendation: BLOCK merge — architecture violations break layer isolation
```
