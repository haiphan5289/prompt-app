# Post-Process — pa-ai-document

Steps to take after the feature document is written.

## 1. Review the EVAL checklist

Open spec/EVAL.md and verify all 25 items. Fix any `[ ]` failures before sharing the document.

## 2. Resolve Open Questions

Review the "Open Questions" section of the generated document. For each unresolved question:
- Create a Jira sub-task, or
- Add a comment on the ticket, or
- Resolve it immediately and update the document.

## 3. Commit the document

```bash
git add lib/features/<feature>/FEATURE.md
git commit -m "docs: add feature document for <feature>"
```

## 4. Link to Jira (if applicable)

If a Jira ticket is associated, use `pa-jira-patch` (MODE: update) to add a comment with the document path:

```
JIRA: PA-XX
MODE: update
NOTES: Feature document written to lib/features/<feature>/FEATURE.md
```

## 5. Pass to implementation skills

Once the document is approved, hand off to the appropriate skill:
- `pa-feature-pipeline` — for full end-to-end implementation
- `pa-scaffold` — to generate boilerplate files described in the document
- `pa-flutter-expert` agent — for complex architecture decisions
