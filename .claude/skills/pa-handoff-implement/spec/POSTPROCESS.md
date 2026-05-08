# Post-Execution Steps — Handoff Implement

## Step 1: Final Analyze + Format Pass

```bash
dart format lib/ test/
flutter analyze
```

Both must complete cleanly before proceeding.

## Step 2: Run Existing Tests

```bash
flutter test
```

If any existing test fails due to the new implementation, fix the regression before marking done.

## Step 3: Spec Validation Report

Produce the Spec Validation Report (see [OUTPUT_SCHEMA.md](OUTPUT_SCHEMA.md)). Every handoff requirement must have a row. No requirement should be left as `no` without a documented reason.

## Step 4: Handoff to Reviewer

If a code review is required, invoke `pa-review-code` with:

```
FILES: [list of changed files]
CONTEXT: [feature name + one-sentence description]
```

## Step 5: Update CHANGELOG or ticket

If the project tracks a CHANGELOG or Jira ticket, update it with:
- What was implemented
- Which files were changed
- Any deferred items or follow-up tasks

## Step 6: Identify Follow-Up Work

Note anything that was explicitly out of scope for this handoff but may need future attention:
- Missing tests for edge cases
- Performance optimisations deferred
- Related screens not yet updated
- Accessibility (semantics labels) not yet added

Surface these as follow-up tasks, not silent omissions.
