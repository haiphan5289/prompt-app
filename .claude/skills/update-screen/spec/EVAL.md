# Evaluation — update-screen

Quality checklist per stage.

---

## Stage 1: Audit

✅ **Pass Criteria:**
- [ ] Both View and ViewModel files read from disk successfully
- [ ] Audit summary lists all App* components currently in use
- [ ] All 3 states (loading/empty/error) presence checked
- [ ] All @Published properties listed with types and defaults
- [ ] All methods listed
- [ ] Dependencies listed (UseCase + Repository)
- [ ] Potential risks identified (or "none")

❌ **Fail Patterns:**
- Audit skipped (went straight to Delta)
- File paths wrong (couldn't read files)
- Incomplete audit (missing components or properties)

---

## Stage 2: Delta Requirements

✅ **Pass Criteria:**
- [ ] User confirmed what changes before proceeding
- [ ] Delta clearly separates: additions (+), modifications (~), removals (-)
- [ ] New @Published properties specified with types and defaults
- [ ] New methods described (signature + purpose)
- [ ] View changes described (which sections + which components)

❌ **Fail Patterns:**
- Assumed user intent without asking
- Delta too vague ("add some UI")
- No distinction between add/modify/remove

---

## Stage 3: Implement (Surgical Edits)

✅ **Pass Criteria:**
- [ ] Used `replace_string_in_file` or `multi_replace_string_in_file` (not full rewrite)
- [ ] New @Published added below existing ones (preserved order)
- [ ] New View sections added in new `// MARK: -` blocks
- [ ] All new UI uses App* components
- [ ] All new colors use `AppColors.*`
- [ ] All new text uses `AppTypography.*`
- [ ] All new spacing uses `AppSpacing.*`
- [ ] Edit report lists exactly what was changed

🔴 **Critical Fail Patterns:**
- Rewrote entire file
- Reordered existing @Published properties
- Used ML* or UI* components
- Hardcoded colors/fonts/spacing
- Deleted existing code unintentionally

---

## Stage 4: Workflow Review (pa-review-workflow)

✅ **Pass Criteria:**
- [ ] Score ≥ 7.0/10
- [ ] 0 Critical (🔴) issues
- [ ] Clean Architecture respected (ViewModel → UseCase → Repository)
- [ ] New async methods have proper loading state management
- [ ] New Firebase listeners have deinit cleanup (if applicable)

❌ **Fail Patterns:**
- Skipped when ViewModel was modified
- Score < 7.0/10 with issues unfixed

---

## Stage 5: UI Score (pa-review-ui-score)

✅ **Pass Criteria:**
- [ ] Score ≥ target_score (default 8.0)
- [ ] Score did not drop compared to pre-edit baseline
- [ ] All dimensions ≥ 7.0

❌ **Fail Patterns:**
- Score dropped after edit (regression in UI quality)
- New hardcoded values added
- States broke (loading/empty/error)

---

## Stage 6: Regression Check

✅ **Pass Criteria:**
- [ ] All pre-edit @Published properties still present
- [ ] All pre-edit App* components still present
- [ ] All pre-edit MARK sections intact
- [ ] All pre-edit navigation still wired
- [ ] Loading/empty/error states that existed before still exist
- [ ] No method signatures changed (unless explicitly part of delta)

🔴 **Critical Fail (must fix before completing):**
- Any @Published property accidentally deleted
- Any existing component accidentally removed
- Navigation broke
- State handling broke

---

## Cross-Stage Consistency

✅ **Pass Criteria:**
- [ ] All additions from Stage 2 Delta are present in Stage 3 edits
- [ ] No edits in Stage 3 that weren't mentioned in Stage 2 Delta
- [ ] Workflow review findings match what was edited
- [ ] UI score reflects the actual edited View (not old version)

---

## Scoring Summary

| Stage | Pass Threshold | Critical Failure |
|---|---|---|
| 1. Audit | All files read + summary complete | Files not found |
| 2. Delta | User confirmed changes | Assumed intent |
| 3. Implement | Surgical edits only | Full file rewrite |
| 4. Workflow Review | ≥ 7.0/10, 0 🔴 | Skipped when ViewModel changed |
| 5. UI Score | ≥ target, no drop | Score dropped |
| 6. Regression | 0 regressions | Property/component deleted |

**Overall Pass:** All 6 stages pass.

---

## Example Pass/Fail

### ✅ Pass Example

```
Stage 1: Audit — 3 @Published, 5 App* components, all states ✓
Stage 2: Delta — +1 @Published, +1 method, +1 button
Stage 3: 3 edits applied (ViewModel: +2, View: +1)
Stage 4: 8.5/10, 0 🔴
Stage 5: 8.7/10 ✓ (target 8.0, pre-edit was 8.5)
Stage 6: ✓ no regressions
→ PASS
```

### ❌ Fail Example

```
Stage 1: Audit — 3 @Published, 5 components ✓
Stage 2: Delta — +searchQuery @Published
Stage 3: Rewrote entire View file (200 lines pasted)
→ FAIL at Stage 3 (violated surgical edit rule)
```
