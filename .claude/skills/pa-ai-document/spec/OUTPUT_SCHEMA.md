# Output Schema — pa-ai-document

## Output File

A single Markdown file written to the repository at the co-located path:

```
lib/features/<feature>/FEATURE.md
```

or for cross-cutting features:

```
docs/<feature-name>.md
```

## Document Template

```markdown
# [Feature Name]

## Summary
[1–2 sentence description of what this feature does and why]

## Business Rules
- [rule 1: e.g., "Pattern must be applied before history is saved"]
- [rule 2: e.g., "Empty input must not trigger transformation"]
- [rule 3: ...]

## Architecture Overview
**Layers affected:** Presentation / Domain / Data

**Data flow:**
User input → [NotifierName] → [UseCaseName] → [RepositoryName] → result

**Key providers:**
- `[providerName]` — [what it does]
- `[providerName2]` — [what it does]

## Prompt Pattern Involvement
*(Fill if feature adds/modifies a pattern)*
- Pattern ID: `[id]`
- Template: `[template snippet]`
- Transformation: [how input maps to output]

## Key Files & Symbols

| File | Symbol | Purpose |
|---|---|---|
| `lib/features/.../[file].dart` | `[ClassName]` | [what it does] |

## API Contracts
*(If feature calls an external API)*
- Endpoint: `[url or N/A]`
- Method: `GET/POST/N/A`
- Request: `[params or N/A]`
- Response: `[model or N/A]`

## Edge Cases & Error Handling
- Empty input → [behavior]
- Network unavailable → [behavior]
- Storage full → [behavior]

## Test Coverage
- [ ] `[TestFile]` — [what it tests]

## Open Questions
- [any unresolved decisions]

## Sources
- Jira: [key or N/A]
- Files read: [list]
- Generated: [date]
```

## Priority Variations

| Priority | Sections included |
|---|---|
| `High` | All sections + mermaid flowchart in Architecture Overview |
| `Medium` | All sections, no diagram |
| `Low` | Summary + Business Rules + Key Files & Symbols only |
