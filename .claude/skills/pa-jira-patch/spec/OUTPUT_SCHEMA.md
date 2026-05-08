# Output Schema — pa-jira-patch

## Read Mode Output

Printed to terminal. No files written.

```
## Ticket: PA-42
Title: [summary]
Priority: [P1/P2/P3]
Status: [In Progress / To Do / Done]
Labels: [label1, label2]

### Acceptance Criteria
- [ ] [criterion 1]
- [ ] [criterion 2]

### Technical Notes
[any implementation hints from ticket]

### Recommendation
Pass to: [pa-semantic-filter → pa-feature-pipeline | pa-flipped-interaction]
```

## Update Mode Output

### Comment added to Jira ticket

```markdown
## Implementation Complete

**PR:** [PR_URL]
**Changes:**
- [file 1]: [what changed]
- [file 2]: [what changed]

**Test plan:**
- [ ] [manual test step]
- [ ] flutter test passes

**Acceptance criteria status:**
- [x] [criterion 1] — implemented in [file]
- [x] [criterion 2] — implemented in [file]
```

### Terminal confirmation

```
Comment added: [comment ID]
Ticket status transitioned to: [STATUS]
```
