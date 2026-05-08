# Output Schema — pa-quality-engineer

## QE Report Format

```
## QE Report: [Feature Name]

### Severity Summary
CRITICAL (must fix): N issues
MAJOR (should fix): N issues
MINOR (nice to fix): N issues

---

### CRITICAL Issues
**[Dimension]** [file:line]
Problem: [description]
Expected: [what the PRD/spec says]
Actual: [what the code does]
Fix: [specific change needed]

### MAJOR Issues
[same format]

### MINOR Issues
[same format]

---

### Passing Dimensions
- [Dimension]: PASS — [brief note]

### Recommendation
[BLOCK release | Ship with fixes | Ship as-is]
```

## Severity Definitions

| Level | Meaning | Ship? |
|---|---|---|
| CRITICAL | Wrong behavior, crash risk, or unmet acceptance criterion | BLOCK |
| MAJOR | Violates architecture, missing test, or fragile code that will break | Fix before ship |
| MINOR | Style inconsistency, missing const, suboptimal but not wrong | Nice to fix |

## Required Report Sections

1. Severity summary (counts per level)
2. CRITICAL issues (if any) — with Problem / Expected / Actual / Fix
3. MAJOR issues (if any) — with Problem / Expected / Actual / Fix
4. MINOR issues (if any) — with Problem / Fix
5. Passing dimensions list
6. Final recommendation

## Recommendation Values

- `BLOCK release` — one or more CRITICAL issues found
- `Ship with fixes` — only MAJOR/MINOR issues found; list specific fixes
- `Ship as-is` — all dimensions pass or only trivial MINOR items
