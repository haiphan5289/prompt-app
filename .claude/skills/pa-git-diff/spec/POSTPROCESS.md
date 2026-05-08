# Post-Process — pa-git-diff

Steps to take after the diff analysis output is produced.

## 1. Address Checklist Failures

For each item marked `[ ]` in the Review Checklist:
- Decide whether it is a genuine issue or N/A for this change.
- If genuine: fix before opening the PR (re-run relevant skill, e.g. `pa-unittest` for missing tests).

## 2. Run Static Analysis

```bash
flutter analyze
dart format --set-exit-if-changed lib/ test/
```

Ensure both pass with zero issues before submitting.

## 3. Run Tests

```bash
flutter test
```

Confirm all existing tests pass and new tests are green.

## 4. Copy PR Description

Paste the generated PR Description into the GitHub PR body when creating or editing the pull request.

## 5. Link to Jira (if applicable)

If a Jira ticket is associated with this branch, use `pa-jira-patch` (MODE: update) to attach the PR URL and implementation notes to the ticket.

## 6. Request Code Review

After the PR is open, invoke `pa-review-code` to apply the Flutter code review checklist as a final gate.
