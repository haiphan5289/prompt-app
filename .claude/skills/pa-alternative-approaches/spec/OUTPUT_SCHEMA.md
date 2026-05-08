# Output Schema — pa-alternative-approaches

## Output Structure

The skill produces a structured analysis document (in-conversation, not a file).

### Per Option Block
```
## Option N: [Name]

**Core idea:** One sentence.

**How it works in Prompt App:** 2–3 sentences specific to this codebase.

**Code sketch:**
```dart
// Minimal example — key class or method only
```

**Pros:**
- ...

**Cons:**
- ...

**Best when:** [specific condition that makes this the right choice]
```

### Comparison Matrix

```
| Criterion        | Option 1 | Option 2 | Option 3 |
|------------------|----------|----------|----------|
| Dev complexity   | Low      | Med      | High     |
| Testability      | ✅       | ✅       | ⚠️       |
| Performance      | Fast     | Fast     | Med      |
| Offline support  | ✅       | ❌       | ✅       |
| Scalability      | Med      | High     | Low      |
| Score (1–5)      | 4        | 3        | 3        |
```

### Decision Framework

```
If [constraint A] → Option N (reason)
If [constraint B] → Option N (reason)
Default → Option N (reason)
```

### Recommendation

One paragraph stating which option fits the current Prompt App scale and why, referencing the constraints.
