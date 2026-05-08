# Eval — pa-jira-patch

Quality checklist for both read and update mode outputs.

## Read Mode

- [ ] 1. Ticket key in the output header matches the `JIRA` input exactly
- [ ] 2. Title is the actual ticket summary (not a placeholder)
- [ ] 3. Priority is one of P1, P2, or P3 (not a raw Jira value like "Major")
- [ ] 4. Status reflects the current workflow state from the ticket
- [ ] 5. Labels section lists all Prompt App labels present on the ticket
- [ ] 6. Acceptance Criteria section is populated if the ticket has any criteria
- [ ] 7. Acceptance Criteria items are in checkbox format (`- [ ]`)
- [ ] 8. Technical Notes section contains only implementation-relevant content (no sensitive data)
- [ ] 9. Sensitive content has been stripped via pa-semantic-filter before output
- [ ] 10. Recommendation names a real downstream skill (not a made-up skill name)
- [ ] 11. Recommendation matches the ticket content (pattern label → pa-prompt-pattern-design, etc.)

## Update Mode

- [ ] 12. PR URL in the comment is the actual URL provided in input (not modified)
- [ ] 13. Changes section lists specific files/symbols changed (not generic descriptions)
- [ ] 14. Test plan contains at least one manual step and `flutter test passes`
- [ ] 15. Acceptance criteria status maps each criterion to the file where it was implemented
- [ ] 16. No criterion is marked `[x]` without implementation evidence
- [ ] 17. Comment was successfully posted (confirmation includes comment ID)
- [ ] 18. Ticket status was successfully transitioned (confirmation includes new status)
- [ ] 19. If Atlassian MCP is unavailable, a clear fallback message is shown (no silent failure)

## General

- [ ] 20. No sensitive business data (revenue, OKRs, competitor names) appears in any output
- [ ] 21. No placeholder text (e.g. `[file 1]`, `[what changed]`) remains in update mode comment
- [ ] 22. Output is limited to the requested ticket — no other tickets are fetched or modified
