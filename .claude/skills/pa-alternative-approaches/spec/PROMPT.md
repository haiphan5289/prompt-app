# Execution Workflow — pa-alternative-approaches

## Step 1: Understand the Problem

Read the PROBLEM, CONTEXT, COMPLEXITY, and CONSTRAINTS inputs.

If the problem involves existing code, read the relevant files before proposing alternatives:
```bash
# Check what already exists
find lib/features/<context-feature>/ -name "*.dart" | head -20
```

Verify which packages are already in the project:
```bash
grep -A 50 "dependencies:" pubspec.yaml
```

Only propose options using packages that are either already in `pubspec.yaml` or are well-known Flutter packages with confirmed API compatibility.

## Step 2: Generate 3–5 Options

For each option:

1. Give it a short, descriptive name
2. State the core idea in one sentence
3. Explain how it works in the Prompt App context specifically
4. Write a minimal code sketch (key class/method, not boilerplate)
5. List pros and cons
6. State when this option is the best choice

Scale number of options to COMPLEXITY:
- `Simple` → 3 options
- `Medium` → 3–4 options
- `Complex` → 4–5 options

## Step 3: Build the Comparison Matrix

Evaluate each option against these standard criteria:

| Criterion | Description |
|---|---|
| Dev complexity | Low/Med/High — how hard to implement and maintain |
| Testability | Can the logic be unit tested without Flutter/Riverpod? |
| Performance | Runtime speed and memory characteristics |
| Offline support | Works without network connection? |
| Scalability | Can it handle growth without a rewrite? |
| Score (1–5) | Overall fit for current Prompt App scale |

## Step 4: Write the Decision Framework

Produce an `if/else` decision tree:
```
If [constraint or condition] → Option N (reason)
If [other condition] → Option N (reason)
Default: Option N (reason)
```

The framework must be actionable — the user should be able to follow it and reach a clear choice.

## Step 5: Apply Architecture Evaluation (for architecture-level decisions)

Always evaluate architecture options against these 4 questions:
1. Does it respect Clean Architecture layers? (Domain has no external deps)
2. Is it testable? (Can UseCase be tested without Flutter/Riverpod?)
3. Does it support offline? (Core transformer must work without internet)
4. Is it overly complex for current scale? (Don't over-engineer for MVP)

**Default principle:** Choose the simplest option that satisfies current requirements. The transformer is the core — complexity budget should go there, not infrastructure.
