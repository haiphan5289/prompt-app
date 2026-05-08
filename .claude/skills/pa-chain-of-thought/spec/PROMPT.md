# Execution Workflow — Chain-of-Thought Analysis

Run all six phases in order. Do not skip phases. Always end with Open Questions.

---

## Phase 1: Requirement Decomposition

1. Restate the problem in one paragraph using your own words.
2. Answer explicitly:
   - What is the exact desired behavior?
   - What inputs does this receive? What outputs does it produce?
   - What are the success criteria?
   - What constraints exist (offline, performance, UX)?

---

## Phase 2: Architecture Impact

Map which layers are touched:

- **Presentation** — Which screens/widgets are affected? Any new routes?
- **Domain** — New or modified entity? New or modified UseCase? New or modified repository interface?
- **Data** — New or modified repository implementation? New datasource? Seed data change?

Answer each bullet with `new`, `modified`, or `none`.

---

## Phase 3: Data Flow Design

Trace the complete data flow using the canonical Prompt App pattern:

```
User action
  → Widget (ref.read notifier.method())
  → Notifier (AsyncValue.guard → useCase.execute())
  → UseCase (business logic → repository call)
  → Repository (data access → datasource)
  → Result flows back up
```

Fill in each arrow with the actual class names for this feature. Identify every provider that will be read or watched.

---

## Phase 4: Edge Cases & Failure Modes

Answer each question with a concrete handling strategy:

1. What happens if the input is empty or whitespace-only?
2. What happens if a pattern template has an unmatched `{{variable}}`?
3. What happens if local storage is full or corrupted?
4. What if the user navigates away mid-transformation?
5. What if the same prompt is submitted twice quickly (race condition)?
6. Any additional edge cases specific to this feature?

---

## Phase 5: Test Plan

1. Which layer has the most business logic? → write UseCase unit tests first.
2. What is the most likely failure point? → write a test for that failure first.
3. What does the happy-path widget test look like?
4. List tests in priority order (most critical first).

---

## Phase 6: Implementation Roadmap

Order the work bottom-up:

1. Domain entities and interfaces (no dependencies — implement first)
2. Data layer implementation (repositories, datasources)
3. Provider registration (`lib/core/di/providers.dart`)
4. Notifier
5. UI (widgets and screen — implement last; depends on everything above)

Number each step and estimate complexity (low / medium / high).

---

## Final Step: Open Questions

List every ambiguity that requires user input before starting implementation. Format:

```
Q1. [Question] — blocks [Phase N]
Q2. [Question] — blocks [Phase N]
```

**Always surface Open Questions** before handing off to `pa-feature-pipeline`.
