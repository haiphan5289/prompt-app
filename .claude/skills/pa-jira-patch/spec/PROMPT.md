# Prompt — pa-jira-patch

Step-by-step execution workflow. Branches on `MODE`.

---

## Read Mode

### Step 1: Fetch the Jira ticket

If Atlassian MCP is available:
```
mcp__claude_ai_Atlassian__getJiraIssue(issueKey: "<JIRA>")
```

Extract the following fields:
- `summary` — ticket title
- `description` — full description body
- `priority` — P1 / P2 / P3
- `status` — current workflow state
- `labels` — Prompt App label tags
- `acceptanceCriteria` — extracted from description (look for "Acceptance Criteria" heading or checklist items)
- `technicalNotes` — any implementation hints in the description

### Step 2: Pass through semantic filter

Before returning the extracted spec, apply `pa-semantic-filter` to strip any sensitive business data (revenue targets, OKRs, competitive references) from the ticket content.

### Step 3: Emit Read Output

Produce the Read Output block (see OUTPUT_SCHEMA.md).

### Step 4: Recommend next skill

Based on ticket labels and content, recommend which skill to invoke next:
- Contains acceptance criteria + functional requirements → `pa-semantic-filter → pa-feature-pipeline`
- Needs clarification or scoping → `pa-flipped-interaction` (if available)
- Pattern library label → `pa-prompt-pattern-design`

---

## Update Mode

### Step 1: Format the implementation comment

Build the comment using the template in OUTPUT_SCHEMA.md, substituting `PR_URL`, `NOTES`, and any file/criterion details provided.

### Step 2: Add comment to ticket

If Atlassian MCP is available:
```
mcp__claude_ai_Atlassian__addCommentToJiraIssue(
  issueKey: "<JIRA>",
  body: "<formatted comment>"
)
```

### Step 3: Transition ticket status

If Atlassian MCP is available and `STATUS` is provided:
```
mcp__claude_ai_Atlassian__transitionJiraIssue(
  issueKey: "<JIRA>",
  transition: "<STATUS>"
)
```

### Step 4: Confirm

Print confirmation of the comment ID and new ticket status.
