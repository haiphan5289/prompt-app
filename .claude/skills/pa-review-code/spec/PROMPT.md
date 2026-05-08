# Execution Workflow — pa-review-code

## Step 1: Read Files

Before reviewing, read every file in scope. Never assume what they contain.

```bash
# If reviewing a branch, find changed files first
git diff main...HEAD --name-only | grep '\.dart$'
```

Read each changed file in full before forming any opinions.

## Step 2: Run All Checklist Dimensions in Parallel

Evaluate the code against all 7 dimensions simultaneously:

1. **Architecture** — layer separation, placement, dependency direction
2. **Riverpod** — provider patterns, ref usage, state immutability
3. **Null Safety** — bang operators, mounted checks, AsyncValue access
4. **Widget** — build method size, const constructors, widget type selection
5. **Performance** — const usage, list rendering, expensive computations
6. **Domain Logic** — transformer pattern substitution, template variables (only if transformer code changed)
7. **Tests** — UseCase tests, widget tests, mock isolation

## Step 3: Assign Severity per Dimension

For each dimension assign: `PASS`, `WARN`, or `FAIL`.

| Rating | Meaning | Action |
|---|---|---|
| FAIL | Breaks architecture, causes crashes, or wrong behavior | Must fix before merge |
| WARN | Works but violates conventions or is fragile | Should fix, can merge with note |
| PASS | Clean, correct, follows all conventions | No action needed |

## Step 4: Collect Issues with Line References

For each non-PASS item, record:
- File path and line number
- What the problem is
- What the fix should be

## Step 5: Output Structured Review

Emit review in the format defined in [OUTPUT_SCHEMA.md](OUTPUT_SCHEMA.md).
