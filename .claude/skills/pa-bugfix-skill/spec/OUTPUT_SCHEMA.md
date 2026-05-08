# Output Schema — Bug Fix

## Required Output Sections

### 1. Root Cause Statement

One sentence, clearly identifying the root cause:

```
Root cause: `ref.read(transformerNotifierProvider)` is used inside `build()` instead of `ref.watch`, so the widget never subscribes to state changes.
```

### 2. Mechanism Explanation

2–4 sentences explaining why this causes the observed symptom.

### 3. Minimal Fix (code diff)

Show only the changed lines. Do not rewrite surrounding code.

```dart
// Before
final state = ref.read(transformerNotifierProvider);

// After
final state = ref.watch(transformerNotifierProvider);
```

### 4. Data Flow Trace

Confirm the fix at each step of the transformer flow:

```
User taps button → ✓ Widget calls notifier.transform(input)
Notifier → ✓ state = AsyncLoading() emitted
Widget rebuild → ✓ ref.watch triggers rebuild — FIXED HERE
UseCase → ✓ patternRepository.getById called
Notifier → ✓ state = AsyncData(result) emitted
Widget rebuild → ✓ PromptResultCard displays result
```

### 5. Verification Steps

```
How to verify:
1. Run flutter analyze lib/ → zero warnings
2. Hot restart app
3. Enter prompt text → select pattern → tap Transform
4. Loading indicator appears → result card populates
5. Run flutter test → all pass
```

## Files Modified

List every file changed:

| File | Change |
|---|---|
| `lib/features/transformer/presentation/screens/home_screen.dart` | `ref.read` → `ref.watch` on line 34 |
