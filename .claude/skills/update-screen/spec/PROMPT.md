# Prompt — update-screen Pipeline

Execute each stage in order. Do NOT skip a stage unless explicitly told via `skip_stages`. Do NOT rewrite entire files — apply surgical edits only.

---

## Stage 1: Audit (Read Documents + Existing Files)

First, read the document files:
- `docs/Features/` — feature specs and roadmap (understand where this screen fits)
- `laundry-dashboard/Core/Design/Components/` — App* component list (know what's available before editing)

Then read the screen files from disk:
- Find `[ScreenName].swift` in `laundry-dashboard/laundry-dashboard/Features/`
- Find `[ScreenName]ViewModel.swift` in same folder
- Find related `*Repository.swift` and `*UseCase.swift` files (if referenced)

Produce an **Audit Summary** (in conversation, concise):

```
Audit: [ScreenName]
View:
  - App* components in use: [list]
  - States handled: loading ✓/✗  empty ✓/✗  error ✓/✗
  - Navigation destinations: [list or none]
  - Existing subviews / MARK sections: [list]
ViewModel:
  - @Published properties: [name: Type = default, ...]
  - Methods: [list]
  - Dependencies: [UseCase and Repository names]
  - Potential risks: [any fragile patterns noticed]
```

Do NOT proceed to Stage 2 until the audit is shown to the user.

---

## Stage 2: Delta Requirements

Ask the user **only about what changes** — do not re-ask about things that already work.

Based on the audit, ask:
1. Which existing component/method/property needs to change?
2. What new data or actions are being added?
3. Does this require new @Published properties in the ViewModel?
4. Does this require a new UseCase or Repository method?
5. Should any existing behavior be removed or replaced?

**Fallback:** If the description in the input is already specific enough → confirm with the user in one line and proceed.

---

## Stage 3: Implement (pa-swiftui-expert-skill)

Apply changes using `pa-swiftui-expert-skill`. **Surgical edits only.**

Rules:
- Use the Edit tool — do NOT rewrite the full file
- Add new @Published properties below existing ones (never reorder)
- Add new View subviews in a new `// MARK: -` section
- Use App* components for any new UI: `AppButton`, `AppCard`, `AppTextField`, `AppLoadingView`, `AppBadge`
- Use `AppColors.*` for all new colors
- Use `AppTypography.*` for all new text styles
- Use `AppSpacing.*` for all new spacing
- If new UseCase needed → add it to existing Domain/ folder, do NOT create a new one unless the delta explicitly requires it

After edits, report:
```
✓ Stage 3: Applied [N] edits
  ViewModel: [list of new/changed @Published, methods]
  View: [list of new/changed components, sections]
```

---

## Stage 4: Workflow Review (pa-review-workflow)

Invoke `pa-review-workflow` on the modified `[ScreenName]ViewModel.swift`.

Read from disk by path — do not re-paste file.

Check:
- New @Published properties have correct defaults
- New async methods have `defer { isLoading = false }`
- New Firebase listeners have deinit cleanup (if applicable)
- Existing cancellables not disrupted
- Clean Architecture: ViewModel → UseCase → Repository (never skip layers)

Fix all Critical (🔴) issues. Report score table.

---

## Stage 5: UI Score (pa-review-ui-score)

Invoke `pa-review-ui-score` on the modified `[ScreenName].swift`.

Read from disk by path.

Target: `{target_score}` (default 8.0). If the existing screen was already scoring above target, the updated screen must match or exceed that score.

If score dropped vs pre-edit → apply quick wins, re-score.

---

## Stage 6: Regression Check

Read the final `[ScreenName].swift` and `[ScreenName]ViewModel.swift` from disk.

Verify against the Audit Summary from Stage 1:
- [ ] All @Published properties from the audit are still present (none accidentally removed)
- [ ] All existing App* components are still present
- [ ] All existing MARK sections are intact
- [ ] All existing navigation destinations are still wired
- [ ] Loading / empty / error states that existed before still exist
- [ ] No existing method signatures changed

If any regression found → fix it before reporting complete.

---

## Pipeline Complete

```
✅ update-screen complete: [ScreenName]
Stage 1: Audit — [N] properties, [N] components, states: [loading/empty/error presence]
Stage 2: Delta — [summary of what changed]
Stage 3: [N] edits applied (ViewModel: [...] / View: [...])
Stage 4: Workflow — [score]/10, [N] issues fixed
Stage 5: UI Score — [score]/10 ✓
Stage 6: Regression — ✓ no regressions / [list any fixed]
```
