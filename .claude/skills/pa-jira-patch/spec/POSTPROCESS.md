# Post-Execution Steps — pa-jira-patch

## After Read Mode

1. **Pass spec to semantic filter** — run `pa-semantic-filter` on the extracted acceptance criteria to remove noise before implementing
2. **Choose next skill based on ticket type:**

| Ticket label | Next skill |
|---|---|
| `transformer` | `pa-prompt-pattern-design` → `pa-feature-pipeline` |
| `pattern-library` | `pa-prompt-pattern-design` |
| `flutter` / `history` | `pa-feature-pipeline` |
| `bug` | `pa-bugfix-skill` |
| `architecture` | `pa-alternative-approaches` → `pa-feature-pipeline` |

3. **Start with module context** — run `pa-module-context` with the relevant FEATURE before implementing

---

## After Update Mode

1. **Verify the Jira comment was posted** — confirm via `mcp__claude_ai_Atlassian__getJiraIssue` that the comment appears
2. **Verify status transition** — confirm the ticket moved to the target status
3. **Check PR is linked** — confirm `PR_URL` appears in the comment and is accessible
4. **Run final QE pass** — if status is `Done`, run `pa-quality-engineer` on the feature folder before closing

---

## Ticket Label Convention Reminder

| Label | Action |
|---|---|
| `transformer` | Affects core transform engine — run `pa-issue-detection` before merging |
| `pattern-library` | Evaluate new pattern with `pa-prompt-pattern-design` EVAL criteria |
| `flutter` | Run `pa-review-code` before moving to Done |
| `bug` | Confirm fix with `pa-unittest` regression test |
| `dx` | No QE required — dev experience only |
