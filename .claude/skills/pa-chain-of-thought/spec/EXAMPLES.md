# Examples — Chain-of-Thought Analysis

---

## Example 1: Pattern Auto-Selection Feature

**Input:**
```
PROBLEM: Given raw user input, automatically suggest the best PromptPattern.
CONTEXT: PatternSelectorRow already exists. User currently picks manually.
CONSTRAINT: Offline only. Latency < 200 ms.
```

**Output:**

```
## Problem
The app currently requires the user to manually select a PromptPattern before transforming their
input. We want to add an "Auto" mode that analyses the raw input and suggests the most suitable
pattern using offline keyword matching.

## Architecture Impact
- Entities:      none
- Repositories:  modified — PatternRepository (add keyword-index method)
- Providers:     new — suggestPatternProvider(String input)
- Screens:       modified — PatternSelectorRow (add "Auto" chip)

## Data Flow
PatternSelectorRow (user taps "Auto")
  → ref.read(suggestPatternProvider(input).notifier).suggest()
  → SuggestPatternUseCase.execute(input)
  → PatternRepository.findByKeywords(input.split(' '))
  → PatternLocalDataSource (in-memory keyword index)
  → PromptPattern? flows back to PatternSelectorRow → highlights suggested chip

## Edge Cases
1. Input is empty → return null (no suggestion), "Auto" chip shows greyed state
2. No pattern keyword matches → fallback to first pattern in list
3. Multiple patterns tie on keyword count → pick highest-priority pattern (by sort order)
4. User navigates away during suggestion → provider auto-disposes, no side effect

## Test Plan
1. SuggestPatternUseCase returns correct pattern for known keyword — domain — critical
2. SuggestPatternUseCase returns null for empty input — domain — critical
3. SuggestPatternUseCase returns fallback when no keyword matches — domain — high
4. PatternSelectorRow shows "Auto" chip and highlights suggestion — widget — medium

## Implementation Order
1. Add keyword list to PromptPattern entity — complexity: low
2. Implement findByKeywords in PatternLocalDataSource — complexity: medium
3. Implement SuggestPatternUseCase — complexity: low
4. Register suggestPatternProvider in di/providers.dart — complexity: low
5. Update PatternSelectorRow with "Auto" chip — complexity: medium

## Open Questions
Q1. Should the suggestion be applied automatically or require a user tap? — blocks Phase 3 (Data Flow)
Q2. Who maintains the keyword list per pattern — hardcoded or editable? — blocks Phase 1 (Constraints)
```

---

## Example 2: Debugging a Race Condition in TransformerNotifier

**Input:**
```
PROBLEM: When the user taps "Transform" twice quickly, the result card sometimes shows
         the wrong result or flickers.
CONTEXT: TransformerNotifier uses AsyncValue.guard. No debouncing currently.
CONSTRAINT: Cannot add a loading delay longer than 100 ms.
```

**Output (abbreviated):**

```
## Problem
A double-tap on the Transform button fires two concurrent calls to TransformerNotifier.transform().
AsyncValue.guard does not cancel the first call, so both may complete and overwrite each other
in non-deterministic order, causing the UI to show stale or incorrect results.

## Architecture Impact
- Entities:      none
- Repositories:  none
- Providers:     modified — transformerNotifierProvider (add cancellation / debounce)
- Screens:       modified — TransformButton (disable during pending state)

## Data Flow
TransformButton (disabled after first tap while state is AsyncLoading)
  → state = AsyncLoading on first tap → button becomes non-tappable
  → TransformerNotifier.transform() completes → state = AsyncData
  → button re-enables

## Edge Cases
1. Second tap while loading → button is disabled, no second call fires
2. Navigator pop while loading → AsyncNotifier auto-cancels via ref.onDispose
3. Error on first call → state = AsyncError → button re-enables → user can retry

## Test Plan
1. TransformerNotifier is in AsyncLoading state immediately after transform() call — unit — critical
2. TransformButton is disabled when provider state is AsyncLoading — widget — critical
3. TransformButton re-enables after AsyncData/AsyncError — widget — high

## Implementation Order
1. Add disabled-during-loading guard to TransformButton widget — complexity: low
2. Verify notifier sets AsyncLoading synchronously before guard — complexity: low

## Open Questions
Q1. Should we also add a debounce on the input field, or only on the button? — blocks Phase 3
```

---

## Example 3: Multi-Layer History Feature

**Input:**
```
PROBLEM: History screen must show before/after pairs, not just the enhanced prompt.
CONTEXT: HistoryLocalDataSource currently only persists the enhanced prompt string.
CONSTRAINT: Existing history entries (enhanced-only) must remain readable.
```

**Output (abbreviated):**

```
## Problem
The history feature stores only the enhanced prompt. We need to also store the original raw
input so the history screen can display a before/after comparison.

## Architecture Impact
- Entities:      modified — TransformResult (add rawInput field)
- Repositories:  modified — HistoryRepository + HistoryRepositoryImpl
- Providers:     none
- Screens:       modified — HistoryEntryCard (show original + enhanced)

## Edge Cases
1. Legacy entries (no rawInput) → display rawInput as "(not recorded)" gracefully
2. rawInput is very long → truncate to 3 lines with "show more" affordance

## Open Questions
Q1. Should legacy entries be silently hidden or shown with a "(legacy)" label? — blocks Phase 4
```
