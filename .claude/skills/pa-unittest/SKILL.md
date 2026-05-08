---
name: pa-unittest
description: Generate Flutter unit tests and widget tests for Prompt App following Clean Architecture — produces correctly structured test files with mocks, setup, and Given-When-Then style test cases.
model: sonnet
effort: high
---

# Flutter Unit & Widget Tests — Prompt App

Generates well-structured test files for UseCases, Notifiers, Repositories, and Screens. Uses `mocktail` for mocking, mirrors source structure in `test/`, and follows Given-When-Then test case style.

## Files

| File | Purpose |
|---|---|
| [spec/PROMPT.md](spec/PROMPT.md) | Step-by-step execution |
| [spec/INPUT_SCHEMA.md](spec/INPUT_SCHEMA.md) | Input parameters |
| [spec/OUTPUT_SCHEMA.md](spec/OUTPUT_SCHEMA.md) | Expected outputs |
| [spec/EXAMPLES.md](spec/EXAMPLES.md) | Worked examples |
| [spec/EVAL.md](spec/EVAL.md) | Quality checklist |
| [spec/GUARDRAILS.md](spec/GUARDRAILS.md) | Anti-hallucination rules |
| [spec/POSTPROCESS.md](spec/POSTPROCESS.md) | Post-execution steps |

## Quick Start

```
TARGET: UseCase
NAME: TransformUseCase
FEATURE: transformer
```
