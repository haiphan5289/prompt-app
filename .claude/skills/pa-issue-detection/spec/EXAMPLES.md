# Examples — pa-issue-detection

## Example 1: Branch with HIGH RISK Issues

**Input:**
```
(default — current branch vs main)
```

**Changed files detected:**
```
lib/features/transformer/presentation/screens/prompt_input_screen.dart
lib/features/transformer/presentation/notifiers/transformer_notifier.dart
lib/features/transformer/domain/usecases/transform_use_case.dart
```

**Output:**
```
## Pre-Merge Scan: feature/transformer-v2 → main

### HIGH RISK (must fix before merge)
- lib/features/transformer/presentation/screens/prompt_input_screen.dart:54 P02: BuildContext used after await without mounted check → add `if (!context.mounted) return;` after line 53
- lib/features/transformer/presentation/notifiers/transformer_notifier.dart:34 P03: ref.watch inside onPressed callback → replace with ref.read(transformerNotifierProvider.notifier).transform(input)
- lib/features/transformer/domain/usecases/transform_use_case.dart:89 P06: Pattern template returned without substitution — contains `{{userInput}}` → call .replaceAll('{{userInput}}', rawPrompt.trim()) before returning

### MEDIUM RISK (should fix)
- lib/features/transformer/presentation/screens/prompt_input_screen.dart:71 P05: .when() call missing error: case → add error: (e, st) => ErrorBanner(message: e.toString())

### LOW RISK (consider fixing)
- lib/features/transformer/presentation/screens/prompt_input_screen.dart:102 P08: print() call in production code → remove or replace with logger

### CLEAN
- lib/features/transformer/domain/usecases/transform_use_case.dart (no issues beyond P06 listed above)

---
Total issues: HIGH 3 | MEDIUM 1 | LOW 1
Recommendation: BLOCK merge
```

---

## Example 2: Clean Branch

**Input:**
```
(default — current branch vs main)
```

**Changed files detected:**
```
lib/features/history/data/datasources/history_local_data_source.dart
lib/features/history/domain/usecases/get_history_use_case.dart
test/features/history/domain/usecases/get_history_use_case_test.dart
```

**Output:**
```
## Pre-Merge Scan: feature/history-delete → main

### HIGH RISK (must fix before merge)
(none)

### MEDIUM RISK (should fix)
(none)

### LOW RISK (consider fixing)
(none)

### CLEAN
- lib/features/history/data/datasources/history_local_data_source.dart
- lib/features/history/domain/usecases/get_history_use_case.dart
- test/features/history/domain/usecases/get_history_use_case_test.dart

---
Total issues: HIGH 0 | MEDIUM 0 | LOW 0
Recommendation: safe to merge
```

---

## Example 3: Riverpod and State Issues

**Output snippet:**
```
### HIGH RISK (must fix before merge)
- lib/features/pattern_library/presentation/notifiers/pattern_notifier.dart:67 P04: Direct state mutation — state.patterns.add(newPattern) does not trigger rebuild → use state = state.copyWith(patterns: [...state.patterns, newPattern])
- lib/features/pattern_library/presentation/notifiers/pattern_notifier.dart:3 P10: @riverpod annotation present but missing part 'pattern_notifier.g.dart'; directive → add part 'pattern_notifier.g.dart'; at top of file

### MEDIUM RISK (should fix)
- lib/features/pattern_library/presentation/screens/pattern_list_screen.dart:44 P11: setState used to update _selectedPattern (business state) → move selection state to PatternNotifier
```
