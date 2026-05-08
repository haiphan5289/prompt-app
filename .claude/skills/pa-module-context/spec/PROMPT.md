# Execution Workflow — pa-module-context

Provide a full architecture map of the Prompt App feature requested.

---

## Step 1: Parse the Input

Identify:
- `FEATURE`: which feature to map (`transformer`, `pattern_library`, `history`, or `all`)
- `TASK`: what the caller is about to implement — used to highlight the most relevant providers and files

---

## Step 2: Output the Feature Map

For the requested feature (or all features if `FEATURE: all`), provide:

### Folder Structure
```
lib/features/<feature>/
├── presentation/
│   ├── screens/
│   ├── notifiers/
│   └── widgets/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── data/
    ├── repositories/
    └── datasources/
```

### Key Providers Table
List the most important Riverpod providers for this feature:

| Provider | Type | Returns | Used by |
|---|---|---|---|
| `transformerNotifierProvider` | `AsyncNotifier` | `TransformedPrompt?` | `TransformerScreen` |

### Key Entities Table
| Entity | Location | Key fields |
|---|---|---|
| `TransformedPrompt` | `domain/entities/` | `original`, `enhanced`, `patternId` |

### Key Files Table
| File | Purpose |
|---|---|
| `presentation/screens/transformer_screen.dart` | Main transformer UI |
| `presentation/notifiers/transformer_notifier.dart` | State management |

---

## Step 3: Highlight Task-Relevant Files

Based on `TASK`, call out which specific files the caller should read before implementing:

```
For your task "<TASK>", start by reading:
1. <file path> — <why>
2. <file path> — <why>
```

---

## Step 4: Naming Convention Reminder

Always append the naming conventions table (see spec/OUTPUT_SCHEMA.md) so the caller generates correct names.

---

## Step 5: Anti-Hallucination Check

Before referencing any file or class name, verify it exists:
```bash
find lib/features/<feature> -name "*.dart" | head -30
grep -rn "class <ClassName>" lib/features/<feature>/
```

Only list files that actually exist in the project.
