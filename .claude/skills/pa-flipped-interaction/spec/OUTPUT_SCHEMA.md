# Output Schema — Flipped Interaction

## Output Format

```
Before I implement this, I have [N] quick questions:

1. [Most critical question — determines architecture or layer]
2. [Second most critical — determines scope or behavior]
3. [Edge case or UX behavior question]
```

## Rules

- The opening line is always exactly: `Before I implement this, I have [N] quick questions:`
- Questions are numbered, one per line.
- No preamble, no explanation of why you are asking, no code.
- Maximum questions per priority level:
  - HIGH priority → 1–2 questions
  - MEDIUM priority → 3–4 questions
  - LOW / exploratory → 4–5 questions
- Questions must be short and specific — one sentence each.
- Do not include rhetorical questions or questions whose answers are already in context.

## What This Skill Does NOT Output

- No implementation code
- No architecture diagrams
- No preliminary design decisions ("I'm thinking we could...")
- No explanations of the question categories being used
- No follow-up until the user answers
