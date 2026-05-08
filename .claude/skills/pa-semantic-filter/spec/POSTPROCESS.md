# Post-Process — pa-semantic-filter

Steps to take after the filtered spec is produced.

## 1. Review the EVAL checklist

Check all 23 items in spec/EVAL.md. If any stripping or preservation failures are found, re-run the filter with a corrected pass.

## 2. Pass to downstream skill

Choose the appropriate next skill based on intent:

| Goal | Downstream skill |
|---|---|
| Implement the feature end-to-end | `pa-feature-pipeline` |
| Write a feature document | `pa-ai-document` |
| Generate reasoning/approach | `pa-chain-of-thought` (if available) |
| Fetch and update Jira ticket | `pa-jira-patch` |

Copy the entire "Filtered Feature Spec" block as the input to the downstream skill.

## 3. Archive (optional)

If the original raw input needs to be retained for audit purposes, save it to a private location outside the repository — never commit raw PRDs containing sensitive data.
