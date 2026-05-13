# Postprocess — new-screen-build

Steps to execute after Stage 6 completes.

---

## 1. Verify All Files Written

Check that all expected files exist on disk:

```bash
ls -lh laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName].swift
ls -lh laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName]ViewModel.swift
```

If any file missing → abort and report error.

---

## 2. Check for Compilation Errors

Run quick syntax check:

```bash
cd laundry-dashboard
xcodebuild -scheme laundry-dashboard -destination 'platform=iOS Simulator,name=iPhone 15' -dry-run
```

If compilation errors → report to user with file paths and error messages.

---

## 3. Verify Clean Architecture Compliance

Read ViewModel file and verify:
- [ ] ViewModel depends on UseCase and/or Repository (not Service directly)
- [ ] No `import FirebaseFirestore` or `import Alamofire` in ViewModel
- [ ] All business logic delegated to UseCase

If violation found → flag as post-build issue.

---

## 4. Cross-Check with Plan

Compare implemented files against plan:
- [ ] All @Published properties from plan are in ViewModel
- [ ] All dependencies from plan are in ViewModel init
- [ ] All states (loading/empty/error) from plan are in View
- [ ] Feature group matches plan

If mismatch → ask user if intentional or bug.

---

## 5. Update Feature Documentation (Optional)

If `docs/Features/[FeatureGroup]/FEATURE.md` exists, consider adding:

```markdown
## [ScreenName]

- **Purpose:** [from plan]
- **Location:** `Features/[FeatureGroup]/Presentation/[ScreenName].swift`
- **ViewModel:** `[ScreenName]ViewModel.swift`
- **States:** Loading, Empty, Error
- **Dependencies:** [list UseCases/Repositories]
```

Don't block on this — it's optional.

---

## 6. Clean Up Plan File (Optional)

Ask user: "Keep plan file or delete?"

If delete:
```bash
rm .claude/tmp/[ScreenName].plan.md
```

If keep: leave for reference.

---

## 7. Memory Update

If this screen introduced a new pattern, save to memory:

```markdown
---
name: [ScreenName] implementation pattern
type: implementation
---

Pattern for [screen type, e.g., "dashboard with real-time data"].

Key components: [AppCard, AppBadge, AppLoadingView, ...]
Architecture: ViewModel → [UseCase] → [Repository]
States: loading ✓ empty ✓ error ✓
Score: UI [X]/10, Workflow [Y]/10
```

Examples of new patterns:
- First screen with charts
- First form with validation
- First screen with pagination

---

## 8. Report Final Status

Print completion message:

```
✅ new-screen-build complete: [ScreenName]
Stage 3: [N] files scaffolded
Stage 4: UI implemented with [N] App* components
Stage 5: Workflow [score]/10, [N] issues fixed
Stage 6: UI [score]/10 ✓

Files written:
  laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName].swift ([N] lines)
  laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName]ViewModel.swift ([N] lines)
  [+ Domain files if created]

Next steps:
  1. Build and run: Cmd+R
  2. Test states: loading, empty, error
  3. Wire navigation from [previous screen]
```

---

## 9. Suggest Next Actions

Based on screen type, suggest:

**Dashboard Screen:**
- Add to main tab bar
- Connect to real Firebase/API data
- Add export/share functionality

**Form Screen:**
- Wire save action to parent screen
- Add validation tests
- Connect to existing flow

**Detail Screen:**
- Wire navigation from list screen
- Add edit/delete actions
- Test with real data

---

## 10. Check for Missing Integrations

Scan for TODOs left in code:

```bash
grep -r "TODO" laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/Presentation/[ScreenName]*.swift
```

If found → list them for user:
```
⚠️ TODOs remaining:
  - [ScreenName].swift:45 — Connect to real API
  - [ScreenName]ViewModel.swift:78 — Add pagination
```

---

## 11. Token Usage Report (Internal)

Log token usage for this skill run:
- Stage 3 tokens
- Stage 4 tokens
- Stage 5 tokens
- Stage 6 tokens
- Total tokens

This helps optimize future runs. (Don't print to user unless debugging.)

---

## 12. Cleanup (If Failed)

If any stage failed and user aborts:
- Keep scaffolded files (user may want to finish manually)
- Report which stage failed and why
- Keep plan file for debugging

Do NOT delete partial work — it may be salvageable.

---

## Final Checklist

Before ending skill execution:
- [x] All files written to disk
- [x] Files validated (syntax + architecture)
- [x] Both reviews passed (workflow + UI)
- [x] User notified with next steps
- [x] No compilation errors
- [x] Clean Architecture respected

If all ✅ → end skill.
If any ❌ → report issue clearly before ending.
