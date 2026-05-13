# Postprocess — new-screen-plan

Steps to execute after the plan file is written.

---

## 1. Verify Plan File Written

Check that `.claude/tmp/[ScreenName].plan.md` exists on disk.

```bash
ls -lh .claude/tmp/[ScreenName].plan.md
```

If not found → abort and report error.

---

## 2. Validate Plan File Structure

Read the plan file and verify:
- [ ] `generated:` timestamp is present
- [ ] All 7 sections exist: Requirements, Architecture (ViewModel Properties, Dependencies, Data Flow, Edge Cases), Feature Group
- [ ] Swift code blocks use triple backticks with `swift` language tag
- [ ] Feature group is valid (Auth | Customer | Dashboard | Settings | Transaction)

If any section missing → re-run Stage 2 and re-write plan file.

---

## 3. Cross-Check with User Input

Compare plan against original user input:
- [ ] Screen name in plan matches input
- [ ] Screen purpose in plan matches description
- [ ] No major scope creep (plan doesn't add features not mentioned)

If mismatch → ask user: "Plan includes [X]. Is this correct?"

---

## 4. Report to User

Print the completion message:

```
✅ new-screen-plan complete: [ScreenName]
Stage 1: [N] requirements captured
Stage 2: [N] @Published properties, [N] dependencies
Plan → .claude/tmp/[ScreenName].plan.md

Next: /new-screen-build [ScreenName]
```

Include:
- Number of requirements (data fields + actions)
- Number of @Published properties designed
- Number of dependencies (UseCase + Repository)
- Explicit next step command

---

## 5. Memory Update (Optional)

If this is a new screen pattern not seen before, save to memory:

```markdown
---
name: [ScreenName] pattern
type: architecture
---

Pattern for [brief description of screen type].

ViewModel properties: [list key @Published vars]
Dependencies: [list UseCase and Repository]
Edge cases: [list notable edge cases]
```

Examples of "new screen pattern":
- First dashboard screen with real-time data
- First form screen with validation
- First analytics screen with charts

---

## 6. Check for Known Risks

Scan the plan for common risk patterns:

| Pattern | Risk | Mitigation |
|---|---|---|
| Real-time listener (Firebase) | Memory leak if not cleaned up | Add note in plan: "deinit must cancel listener" |
| File upload | Large file → timeout | Add note: "compress/validate before upload" |
| Optimistic UI | Race condition on save | Add note: "add conflict resolution in ViewModel" |
| Pagination | Duplicate items on fetch | Add note: "track fetched IDs to dedupe" |
| Complex validation | Slow UI | Add note: "debounce validation" |

If any risk found → add a ⚠️ Risk section to the plan file before reporting complete.

---

## 7. Set Up for Stage 3 (Scaffold)

Ensure the feature group folder exists:

```bash
mkdir -p laundry-dashboard/laundry-dashboard/Features/[FeatureGroup]/[ScreenName]
```

If folder doesn't exist → create it now so Stage 3 doesn't fail.

---

## 8. Token Usage Report (Internal)

Log token usage for this skill run:
- Stage 1 tokens
- Stage 2 tokens
- Plan file size (lines)

This helps optimize future runs. (Don't print to user unless debugging.)

---

## 9. Prefetch Context for Next Stage (Optional)

If the user is likely to run `/new-screen-build [ScreenName]` immediately, prefetch these files into context:
- `laundry-dashboard/Core/Design/Components/` file list
- `docs/Features/` relevant feature spec (if exists)

This reduces token cost in the next stage.

---

## 10. Cleanup (If Failed)

If any stage failed and user aborts:
- Delete incomplete plan file: `rm .claude/tmp/[ScreenName].plan.md`
- Report: "Plan file deleted due to incomplete execution. Re-run /new-screen-plan when ready."

Do NOT leave partial plan files that could confuse `/new-screen-build`.

---

## Final Checklist

Before ending skill execution:
- [x] Plan file written to disk
- [x] Plan file validated (structure + content)
- [x] User notified with next step command
- [x] Feature group folder exists
- [x] No partial/corrupted plan files remain

If all ✅ → end skill.
If any ❌ → fix issue before ending.
