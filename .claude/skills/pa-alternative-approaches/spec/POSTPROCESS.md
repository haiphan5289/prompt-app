# Post-Execution Steps — pa-alternative-approaches

## 1. Confirm Choice with User

After presenting the analysis, ask:
```
Based on this analysis, I recommend Option N: [Name].
Shall I proceed with implementation using this approach?
```

Do not start implementing until the user confirms.

## 2. Document the Decision (if significant)

For architecture-level decisions, suggest the user record the choice:
- In the PR description
- In a comment above the relevant code if the choice is non-obvious

## 3. Hand Off to Implementation Skill

Once the user confirms an option, hand off to the appropriate skill:

| Decision type | Next skill |
|---|---|
| New feature architecture | `pa-feature-pipeline` |
| Specific Flutter pattern | `pa-flutter-expert-skill` |
| New module/layer | `pa-module` or `pa-scaffold` |
| Repository pattern | `pa-repository` |
| UseCase pattern | `pa-generate-usecase` |
| UI widget | `pa-widget` or `pa-figma-implement` |

## 4. Anti-Hallucination Check Before Implementing

Before writing any code from the chosen option, run `pa-anti-hallucination` checks:
```bash
# Verify packages
grep "<package>" pubspec.yaml

# Verify class names
grep -rn "class <ClassName>" ~/.pub-cache/hosted/ lib/
```

## 5. Close the Loop

After implementation, verify the chosen option actually solved the problem:
- Run `flutter analyze` — zero warnings
- Run `flutter test` on the affected feature
- Confirm the constraints from the input are satisfied
