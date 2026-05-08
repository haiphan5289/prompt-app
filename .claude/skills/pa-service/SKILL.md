---
name: pa-service
description: Generate an API Service class for Prompt App when a feature requires network calls (e.g., calling an AI API for pattern suggestion, or fetching remote pattern updates). Produces a service interface + implementation using Dio.
---

# Service Generator — Prompt App (Network Layer)

Only use this when a feature needs an HTTP call. Most features are offline-first — they use DataSource, not Service.


> **Project context:** See [README.md](../../../README.md) for app overview and core concept.
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
NAME: PatternSuggestion
ENDPOINT: https://api.anthropic.com/v1/messages
OPERATIONS:
  - name: suggestPattern
    method: POST
    request: {prompt: String}
    response: {patternId: String, confidence: double}
```
