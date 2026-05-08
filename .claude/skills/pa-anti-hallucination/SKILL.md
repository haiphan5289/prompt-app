---
name: pa-anti-hallucination
description: Guard against hallucinations when generating Flutter/Dart code for Prompt App. Verify every package, class, method, provider, and file path exists in the codebase before generating.
---

# Anti-Hallucination — Flutter / Dart

Run these checks before generating any code for Prompt App. Never assume a symbol exists — verify packages, providers, domain models, file paths, and method signatures against the actual codebase.

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
# Before generating any code, verify the symbol:
grep -r "patternRepositoryProvider" lib/
find lib/ -name "prompt_pattern.dart"
grep -A 50 "dependencies:" pubspec.yaml | grep "flutter_riverpod"
```
