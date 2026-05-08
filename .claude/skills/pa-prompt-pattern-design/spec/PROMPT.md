# Prompt Pattern Design — Execution Workflow

## Overview

The pattern library is the core value of Prompt App. Each pattern is a transformation strategy that takes a simple user prompt and restructures it into a more powerful form.

```
User input (simple) → Pattern Engine → Enhanced prompt (powerful)
```

---

## Step 1: Clarify Intent

Determine which action is requested:
- **Add new pattern** — design a new pattern from scratch
- **Refine existing pattern** — improve template, examples, or metadata for an existing pattern
- **Evaluate pattern** — score an existing or proposed pattern against the evaluation criteria
- **Audit library** — check which problem domains are not yet covered

---

## Step 2: Define Pattern Anatomy

Every pattern in the library must define all of the following fields:

```
id:          snake_case unique identifier
name:        Human-readable display name
category:    One of the 7 categories (see GUARDRAILS.md)
description: One sentence — what this pattern adds to a prompt
template:    The transformation template with {{userInput}} placeholder
whenToUse:   List of 2–3 trigger conditions
examples:    Minimum 3 input → output pairs
```

---

## Step 3: Write the Template

Apply the transformation template rules for the target category:

| Category | Core addition to prompt |
|---|---|
| Role-Based | `"You are a [role]."` prepended |
| Chain-of-Thought | Numbered reasoning steps appended |
| Few-Shot | 2 example pairs prepended, then `"Now do the same for: {{userInput}}"` |
| Output-Format | Structured section labels appended |
| Constraint-Based | Scope/audience/length constraints appended |
| RISEN | Role → Instructions → Steps → End-goal → Narrowing blocks |
| CATO | Context → Action → Tone → Output blocks |

---

## Step 4: Write Minimum 3 Examples

For each example, provide:
- **Input**: a realistic raw user prompt (lowercase, unpolished, as users actually type)
- **Output**: the full transformed prompt produced by applying the template

Ensure examples span different topic domains (technology, writing, personal, business).

---

## Step 5: Define Variable Transformation Logic

For every `{{variable}}` in the template other than `{{userInput}}`, define how it is resolved:

| Variable | Resolution strategy |
|---|---|
| `{{detectedDomain}}` | Infer from keywords in rawPrompt |
| `{{inferredContext}}` | Infer from intent/tone of rawPrompt |
| `{{audience}}` | Default to "general" unless specified |
| `{{maxLength}}` | Default to "300 words" unless specified |
| `{{role}}` | Derived from detectedDomain or prompt category |

---

## Step 6: Validate Before Adding to Library

Run through the checklist in `EVAL.md` before marking the pattern as ready for production.

---

## Step 7: Add to Seed Data

Add the fully validated pattern to `PatternLocalDataSource` seed data in:
```
lib/features/pattern/data/datasources/pattern_local_data_source.dart
```

---

## Transformation Algorithm (TransformUseCase)

The transformer in `TransformUseCase` follows this algorithm at runtime:

```
1. Receive rawPrompt (user input)
2. Receive patternId (selected by user or auto-detected)
3. Load PromptPattern from repository
4. Call _applyPattern(rawPrompt, pattern)
5. In _applyPattern:
   a. Replace {{userInput}} with rawPrompt.trim()
   b. If pattern has {{detectedDomain}}: infer domain from rawPrompt keywords
   c. If pattern has {{inferredContext}}: infer context from rawPrompt intent
   d. If pattern has {{audience}}: default to "general"
   e. If pattern has {{maxLength}}: default to "300 words"
6. Return enhanced prompt string
```
