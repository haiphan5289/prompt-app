# Guardrails — pa-module-context

## Never List Files That Don't Exist

```bash
# ALWAYS verify before listing
find lib/features/{{feature}} -name "*.dart" | sort

# ALWAYS verify class names
grep -rn "class TransformerNotifier" lib/
```

If a file is expected but not found, say so explicitly:
```
Note: transform_prompt_use_case.dart does not exist yet — you will need to create it.
```

Never silently list a file that doesn't exist.

## Never Invent Provider Names

```bash
# Verify providers
grep -n "Provider" lib/core/di/providers.dart
```

If a provider doesn't exist in `providers.dart`, don't include it in the table. Instead note it's missing.

## Do Not Mix Feature Layers

Each feature's map must show only that feature's files. Do not reference cross-feature files unless `FEATURE: all` is requested.

## Naming Conventions Are Non-Negotiable

All suggested names for the TASK must follow the table in OUTPUT_SCHEMA exactly:

| What | Convention |
|---|---|
| Screens | `PascalCaseScreen` |
| Notifiers | `PascalCaseNotifier` |
| Notifier providers | `camelCaseNotifierProvider` |
| UseCases | `VerbNounUseCase` |
| Entities | `PascalCase` noun |
| Files | `snake_case.dart` |

## Do Not Suggest Architecture Changes

This skill maps the existing architecture — it does not redesign it. If the task requires architectural change, redirect to `pa-alternative-approaches` or `pa-feature-pipeline`.

## Prohibited Outputs

| Pattern | Why |
|---|---|
| Listing files without verification | Causes hallucination errors downstream |
| Using Navigator.push in examples | GoRouter is the router |
| Suggesting non-Riverpod state patterns | Riverpod is the only state solution |
| Omitting the naming convention table | Required for every output |
