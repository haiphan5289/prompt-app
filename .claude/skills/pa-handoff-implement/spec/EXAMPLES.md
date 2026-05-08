# Examples — Handoff Implement

---

## Example 1: Before/After on Result Screen (full-stack)

**Input:**
```
HANDOFF: "The result screen should show the original user input above the enhanced prompt.
          Both should be displayed as selectable text. The copy button copies only the enhanced prompt."
FEATURE: transformer
SCOPE: full-stack
```

**Phase 1 extraction:**
- Screens affected: `PromptInputScreen` (result area), `PromptResultCard`
- Interactions: copy (enhanced only), select text (both)
- Data needed: `rawInput` + `enhancedPrompt` from `TransformResult`
- Side effects: none new
- Patterns: none

**Phase 2 mapping:**

| Spec element | Maps to |
|---|---|
| Show rawInput | Modify `TransformResult` entity — add `rawInput` field |
| Show both as selectable text | Update `PromptResultCard` widget — `SelectableText` for each |
| Copy enhanced only | `CopyButton` targets `enhancedPrompt` — no change needed |
| Persist rawInput | Update `HistoryLocalDataSource.save()` — include rawInput |

**Phase 3 implementation order:**
1. `TransformResult` — add `rawInput` field, update `copyWith`
2. `HistoryLocalDataSource` — persist `rawInput`
3. `TransformerNotifier` — pass `rawInput` when creating `TransformResult`
4. `PromptResultCard` — add `SelectableText` for rawInput above enhanced text

**Spec Validation Report:**
```
| Requirement | Implemented | Notes |
|---|---|---|
| Show original input | yes | PromptResultCard — SelectableText(rawInput) |
| Show enhanced prompt | yes | PromptResultCard — existing SelectableText(enhancedPrompt) |
| Copy enhanced only | yes | CopyButton — no change needed, already targets enhancedPrompt |
| Both selectable | yes | SelectableText used for both |
```

---

## Example 2: One-Tap Copy Button (UI only)

**Input:**
```
HANDOFF: "Add a copy icon button to PromptResultCard. Tapping it copies the enhanced prompt
          and shows a brief 'Copied!' snackbar."
FEATURE: transformer
SCOPE: UI only
```

**Phase 1 extraction:**
- Widgets affected: `PromptResultCard`
- Interactions: tap → copy + show SnackBar
- Data needed: enhanced prompt string (already in widget)
- Side effects: `Clipboard.setData()`, `ScaffoldMessenger.showSnackBar()`
- Patterns: none

**Phase 2 mapping:**

| Spec element | Maps to |
|---|---|
| Copy icon button | `CopyButton` widget (already exists or create new) |
| Clipboard copy | `Clipboard.setData(ClipboardData(text: enhancedPrompt))` |
| SnackBar | `ScaffoldMessenger.of(context).showSnackBar(...)` |

**Phase 3 implementation order:**
1. `CopyButton` widget — add or update with SnackBar callback
2. `PromptResultCard` — embed `CopyButton`, pass enhanced prompt

No Notifier, Repository, or UseCase changes needed.

---

## Example 3: Auto-Select Best Pattern (full-stack)

**Input:**
```
HANDOFF: "When the user finishes typing their prompt, automatically highlight the best matching
          pattern in PatternSelectorRow. The user can still override."
FEATURE: transformer
SCOPE: full-stack
```

**Phase 1 → detects ambiguity (how is 'finishes typing' defined?) → invokes pa-flipped-interaction:**

```
Before I implement this, I have 2 quick questions:

1. Should the auto-suggestion trigger on every keystroke (debounced) or only when the user leaves the input field?
2. When a suggestion is highlighted, does it count as the selected pattern immediately, or does the user need to tap it to confirm?
```
