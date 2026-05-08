# Execution Workflow — Flipped Interaction

Do NOT write any code until this workflow is complete and all questions are answered.

---

## Step 1: Classify the Request Priority

Determine the priority level based on how much is unclear:

| Level | Condition | Questions to ask |
|---|---|---|
| HIGH | Architecture is clear, one blocking ambiguity | 1–2 questions |
| MEDIUM | Scope or behavior is unclear | 3–4 questions |
| LOW / exploratory | Multiple valid interpretations, no acceptance criteria | 4–5 questions |

---

## Step 2: Identify Ambiguity Categories

Check each category and flag the ones that are unclear:

### Feature Scope
- Is this UI-only, or does it need a new UseCase/Repository?
- Is this for the transformer screen, the pattern library, or history?
- Does this need to persist across sessions, or is session-only fine?

### Prompt Pattern Specifics (if pattern is involved)
- Is there a template in mind, or should one be designed?
- What is a simple input example and the expected enhanced output?
- Which pattern category does this fall under (role-based, chain-of-thought, etc.)?

### UX Behavior
- Should pattern selection be manual (user picks) or automatic (app suggests)?
- What happens if the transformer fails — silent fallback or visible error?
- Should the enhanced prompt be editable before copying?

### Technical Constraints
- Does this need to work offline, or is a network call acceptable?
- Is performance critical here, or is a slight delay acceptable for better quality?

---

## Step 3: Select and Order Questions

- Pick only the questions from Step 2 that are truly blocking.
- Order them: most critical (determines architecture) first, least critical last.
- Do not ask questions whose answers are obvious from context.
- Do not explain why you are asking — just ask.

---

## Step 4: Format and Deliver

Output exactly:

```
Before I implement this, I have [N] quick questions:

1. [Most critical question — determines architecture]
2. [Second most critical — determines scope]
3. [Edge case or behavior question]
```

No preamble. No explanation. No code. Just the numbered questions.

---

## Step 5: Wait for Answers, Then Hand Off

After the user answers:

- If the request is now clear → switch to `pa-feature-pipeline` or `pa-flutter-expert-skill`.
- If the request involves a new prompt pattern → use `pa-prompt-pattern-design` first.
- If the request requires deep architectural analysis → use `pa-chain-of-thought` first.
