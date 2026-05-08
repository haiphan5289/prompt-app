# Examples — Anti-Hallucination

## Example 1: Verifying a Provider Before Use

**Input (code generation intent):**
> "Use `patternRepositoryProvider` to fetch all patterns in a new screen."

**Verification step:**
```bash
grep -r "patternRepositoryProvider" lib/
# Result: lib/core/di/providers.dart:18:PatternRepository patternRepository(PatternRepositoryRef ref) =>
```

**Output:**
```
## Symbol Verification
| Symbol | Type | Status | Source |
|---|---|---|---|
| patternRepositoryProvider | provider | VERIFIED | lib/core/di/providers.dart:18 |
```
Code generation proceeds normally.

---

## Example 2: Missing Package Detected

**Input (code generation intent):**
> "Import `cached_network_image` to display pattern thumbnails."

**Verification step:**
```bash
grep -A 50 "dependencies:" pubspec.yaml | grep "cached_network_image"
# Result: (no output)
```

**Output:**
```
[BLOCKED] Cannot generate code: package 'cached_network_image' is not in pubspec.yaml.
Action required: Add to pubspec.yaml under dependencies, then run `flutter pub get`.

Suggested addition:
  cached_network_image: ^3.3.0
```
Code generation is blocked until resolved.

---

## Example 3: Field Name Verification

**Input (code generation intent):**
> "Access `result.enhancedText` to display the transformed prompt."

**Verification step:**
```bash
grep -r "enhancedText" lib/
# Result: (no output)
grep -r "class TransformResult" lib/
# Result: lib/features/transformer/domain/entities/transform_result.dart
# Reading file reveals field is named: enhancedPrompt
```

**Output:**
```
[FLAGGED] Field 'enhancedText' not found on TransformResult.
Actual field name: 'enhancedPrompt' (lib/features/transformer/domain/entities/transform_result.dart:7)
Correcting to: result.enhancedPrompt
```
Code generation proceeds with the corrected field name.
