# Postprocess — update-screen

Steps to execute after Stage 6 completes.

---

## 1. Verify No File Corruption

Check that both files are still valid Swift:

```bash
swift -frontend -parse laundry-dashboard/laundry-dashboard/Features/[...]/[ScreenName].swift
swift -frontend -parse laundry-dashboard/laundry-dashboard/Features/[...]/[ScreenName]ViewModel.swift
```

If syntax errors → report to user with line numbers.

---

## 2. Verify No Regressions

Re-read both files and compare against Stage 1 Audit:
- [ ] All pre-edit @Published properties present
- [ ] All pre-edit methods present
- [ ] All pre-edit navigation intact
- [ ] All pre-edit states (loading/empty/error) intact

If any missing → flag as critical regression, fix before ending.

---

## 3. Cross-Check with Delta

Compare Stage 3 edits against Stage 2 Delta:
- [ ] All additions from Delta are present in files
- [ ] No unexpected edits (not in Delta)
- [ ] No removals unless explicitly in Delta

If mismatch → ask user if intentional or bug.

---

## 4. Update Feature Documentation (Optional)

If `docs/Features/[FeatureGroup]/FEATURE.md` exists, consider adding a changelog entry:

```markdown
### [Date] — [ScreenName] Updated
- Added: [brief description of delta]
- Modified: [list changed methods/properties]
```

Don't block on this — it's optional.

---

## 5. Memory Update

If this edit introduced a new pattern, save to memory:

```markdown
---
name: [ScreenName] edit pattern
type: edit
---

Pattern for [edit type, e.g., "adding search to list screen"].

Changes applied:
- ViewModel: [list @Published/methods added]
- View: [list components/sections added]
Issues found: [workflow score, UI score]
Regression: [any close calls or tricky spots]
```

Examples of memorable patterns:
- First time adding search to a list
- First time adding export functionality
- First time adding real-time listener to existing screen

---

## 6. Check for TODOs

Scan edited files for TODOs:

```bash
grep -n "TODO" laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName]*.swift
```

If found → list them for user:
```
⚠️ TODOs remaining after edit:
  - [ScreenName].swift:78 — Wire search to API
  - [ScreenName]ViewModel.swift:102 — Add debounce to search
```

---

## 7. Suggest Next Actions

Based on edit type, suggest:

**Added search/filter:**
- Add debounce (if real-time search)
- Add search history
- Test with large datasets

**Added button/action:**
- Add confirmation dialog (if destructive)
- Add loading indicator
- Test error cases

**Added form field:**
- Add validation
- Add focus management
- Test with edge cases (empty, long input)

---

## 8. Report Final Status

Print completion message:

```
✅ update-screen complete: [ScreenName]
Stage 1: Audit — [N] @Published, [N] components, states: [loading/empty/error]
Stage 2: Delta — [summary]
Stage 3: [N] edits applied
Stage 4: Workflow — [score]/10, [N] issues fixed
Stage 5: UI Score — [score]/10 ✓
Stage 6: Regression — ✓ no regressions

Files modified:
  laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName].swift (+[N] lines)
  laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName]ViewModel.swift (+[N] lines)

Next steps:
  1. Build and test: Cmd+R
  2. Verify new functionality works
  3. Test existing functionality (regression test)
```

---

## 9. Cleanup (If Failed)

If any stage failed and user aborts:
- Keep edited files (don't rollback automatically — user may want to fix manually)
- Report which stage failed and why
- List what was successfully edited before failure

Do NOT rollback edits automatically — user might want to salvage them.

---

## 10. Token Usage Report (Internal)

Log token usage for this skill run:
- Stage 1: audit tokens
- Stage 2: delta tokens
- Stage 3: edit tokens
- Stage 4: review tokens
- Stage 5: score tokens
- Stage 6: regression tokens
- Total tokens

This helps optimize future runs. (Don't print to user unless debugging.)

---

## 11. Check Integration Points

If edit added new functionality that requires wiring to other screens:

**Added action (button/menu item):**
- Does it need to be called from other screens?
- Does navigation need to be updated?

**Added @Published property:**
- Does parent screen need to observe it?
- Does it need to be persisted?

**Added new dependency:**
- Does app initialization need to provide it?
- Does preview need to mock it?

List integration points for user to check.

---

## Final Checklist

Before ending skill execution:
- [x] Both files syntactically valid
- [x] Regression check passed (0 regressions)
- [x] Workflow review passed
- [x] UI score passed
- [x] Delta fully applied
- [x] User notified with next steps

If all ✅ → end skill.
If any ❌ → report issue clearly before ending.
