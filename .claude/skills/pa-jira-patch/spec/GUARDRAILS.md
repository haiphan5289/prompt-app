# Guardrails — pa-jira-patch

## Anti-Hallucination Rules

1. **Never fabricate ticket content.** Only report fields returned by `mcp__claude_ai_Atlassian__getJiraIssue`. If a field is empty or missing, mark it as "N/A" — do not invent a value.
2. **Never fabricate acceptance criteria.** Only list criteria that appear in the ticket description or a dedicated custom field. If none exist, write "No acceptance criteria found."
3. **Never invent file paths in update mode.** The "Changes" section of the implementation comment must contain only files that were actually modified in the implementation. Do not infer or guess file names.
4. **Skill names in the Recommendation must exist.** Only recommend skills that are listed in `.claude/CLAUDE.md` or known to be defined in the `.claude/skills/` directory.

## Sensitive Data Rules

5. **Apply pa-semantic-filter to ticket content before outputting.** Ticket descriptions often contain OKRs, revenue targets, and competitive references. These must be stripped from the Read mode output.
6. **Do not include stripped content in the Jira comment (update mode).** The implementation comment must contain only technical information.

## MCP Availability

7. **If Atlassian MCP is unavailable**, emit a clear warning and provide manual instructions:
   ```
   Atlassian MCP not available. To perform this action manually:
   Read mode:  Open <JIRA> in your browser and extract the required fields.
   Update mode: Add the comment template from OUTPUT_SCHEMA.md manually to the ticket.
   ```
   Do not silently skip the operation.

## Scope

- Read mode: read-only — no writes to Jira or the filesystem.
- Update mode: adds one comment and transitions status. Does not modify ticket fields, attachments, or linked issues.
- This skill never modifies any `.dart` or repository files.
