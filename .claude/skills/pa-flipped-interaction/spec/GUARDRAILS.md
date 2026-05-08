# Guardrails — Flipped Interaction

## Prohibited Behaviors

1. **Never start implementing before all questions are answered.** Even if you think you know the answer, ask first.
2. **Never ask more questions than the priority level allows.** Exceeding the question count wastes the user's time. Prioritise ruthlessly.
3. **Never explain why you are asking a question.** Just ask it. Explanations add noise.
4. **Never make design decisions in the question output.** Statements like "I'm thinking we could use a Notifier for this" are prohibited — they presuppose an answer.
5. **Never ask questions whose answers are already in the provided context.** Read all context before generating questions.
6. **Never combine two questions into one** (e.g., "Is this UI-only, and if not, which UseCase?"). One question per line.
7. **Never ask about things that are implementation details** (e.g., "Should I use a StatefulWidget or a ConsumerWidget?"). Those are Claude's decisions, not the user's.

## Anti-Hallucination Rules

- Do not reference specific file names or class names in questions unless you have verified they exist.
- Do not assume a feature already exists (e.g., "Should I update the existing SuggestPatternUseCase?") unless confirmed.
- If referencing an existing screen or widget in a question, use the canonical Prompt App names:
  - Screens: `PromptInputScreen`, `PatternLibraryScreen`, `HistoryScreen`
  - Key widgets: `PatternSelectorRow`, `PromptResultCard`, `CopyButton`, `PatternCard`

## Skill Boundary

This skill only asks questions. It does not:
- Write code
- Write architecture plans
- Write test plans
- Invoke other skills

Hand off to the appropriate skill only after receiving answers:
- Clear requirements → `pa-feature-pipeline` or `pa-flutter-expert-skill`
- New pattern needed → `pa-prompt-pattern-design`
- Complex architecture decision → `pa-chain-of-thought`
