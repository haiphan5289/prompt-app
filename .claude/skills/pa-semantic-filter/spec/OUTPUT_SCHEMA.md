# Output Schema — pa-semantic-filter

The skill produces a single Markdown block — the filtered spec — printed to the terminal. No files are written.

## Output Template

```markdown
## Filtered Feature Spec: [Feature Name]

### User Stories
- As a [user], I want [goal] so that [benefit]

### Functional Requirements
- [requirement 1]
- [requirement 2]

### UI/UX Specifications
- [screen description]
- [interaction description]

### Acceptance Criteria
- [ ] [criterion 1]
- [ ] [criterion 2]

### Prompt Pattern Requirements
*(if applicable)*
- Pattern to add/modify: [id]
- Template behavior: [description]
- Expected transformation: [example]

### Technical Constraints
- [performance, offline, platform requirements]

---
**Removed:** [brief note on what was stripped, e.g., "revenue targets, competitive references"]
**Safe to pass to:** pa-feature-pipeline, pa-ai-document, pa-chain-of-thought
```

## Section Rules

| Section | Include when |
|---|---|
| User Stories | Input contains any "As a user…" or goal statements |
| Functional Requirements | Input contains any behavioural requirements |
| UI/UX Specifications | Input mentions screens, layouts, or interactions |
| Acceptance Criteria | Input has explicit done-criteria or testable conditions |
| Prompt Pattern Requirements | Input concerns a pattern to add or modify |
| Technical Constraints | Input mentions performance, offline behaviour, or platform limits |

Omit a section entirely (do not print an empty section) if no content applies.
