# Execution Workflow — Handoff Implement

Run all four phases in order. Never skip to Phase 3 without completing Phase 1 and 2.

---

## Phase 1: Understand the Spec

Read the handoff document and extract answers to:

1. **What screens/widgets are affected?**
2. **What interactions are described?** (tap, swipe, input, copy, navigate)
3. **What data does the UI need?** (entities, states, computed values)
4. **What side effects happen?** (save to history, copy to clipboard, navigate, emit event)
5. **Are any prompt patterns involved?** (new pattern, modified template)

If any of these five are unclear → invoke `pa-flipped-interaction` before proceeding to Phase 2.

---

## Phase 2: Map Spec to Architecture

For each requirement extracted in Phase 1, map it to a layer:

| Spec element | Maps to |
|---|---|
| UI element described | Widget to create or modify |
| Data shown on screen | Provider / Notifier to watch |
| User action (tap / submit) | Notifier method to call |
| Business rule | UseCase logic |
| Data persistence | Repository + DataSource |
| New prompt pattern | `pa-prompt-pattern-design` first |

Produce a mapping table before writing any code.

---

## Phase 3: Implementation (Bottom-Up Order)

Always implement in this order — do not skip steps:

1. **Domain**: entity changes, new UseCase, repository interface update
2. **Data**: repository implementation, datasource changes, seed data (if new pattern)
3. **DI**: register new providers in `lib/core/di/providers.dart`
4. **Presentation**: Notifier → Screen → extracted Widgets
5. **Router**: add route only if a new screen was created

After completing each file:
- Run `dart format` on the file
- Run `flutter analyze` — fix all warnings before moving on

### Common Implementation Patterns

#### "Add a new pattern to the library"
1. Use `pa-prompt-pattern-design` to define the pattern first
2. Add to `PatternLocalDataSource` seed data
3. No new screen needed if `PatternSelectorRow` already exists
4. Add pattern preview string to `PatternPreviewWidget` if it exists

#### "Show before/after on the result screen"
1. Modify `TransformResult` entity to add `rawInput` field
2. Update `HistoryLocalDataSource` to store original
3. Update `TransformerNotifier` to surface both values
4. Update `PromptResultCard` widget to show both

#### "Add one-tap copy button"
1. Presentation only — no new layer needed
2. Add `CopyButton` widget using `Clipboard.setData()`
3. Show a `SnackBar` confirmation after copy
4. No Notifier change needed (clipboard is fire-and-forget)

#### "Auto-select best pattern for input"
1. New UseCase: `SuggestPatternUseCase`
2. Logic: keyword matching against `PromptPattern.useCases` list
3. New provider: `suggestPatternProvider(String input)`
4. Update `PatternSelectorRow` to show suggestion

---

## Phase 4: Validate Against Spec

For every requirement in the handoff, verify:

- [ ] Is it visible or testable in the UI?
- [ ] Does the correct data flow through the layers?
- [ ] Are all stated interactions implemented?
- [ ] Are edge cases from the spec handled?
- [ ] Does it match the described UX behavior?
