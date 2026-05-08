# Examples — pa-semantic-filter

## Example 1: PRD with revenue targets and competitive references

**Input (raw):**
```
Feature: Prompt History

We need this to compete with Jasper and increase our 30-day retention from 22% to 40%.
Target launch: Q2 2026. Approved by the product team.

User Stories:
- As a user, I want to see my last 50 transformed prompts so I can reuse them.
- As a user, I want to tap a history item to copy it to the clipboard.

Acceptance Criteria:
- [ ] History list shows at most 50 items, oldest evicted when full.
- [ ] Empty-input transformations are not saved.
- [ ] History persists across app restarts.

Performance: History screen must load in under 300ms on a mid-range Android device.
```

**Output:**
```markdown
## Filtered Feature Spec: Prompt History

### User Stories
- As a user, I want to see my last 50 transformed prompts so I can reuse them.
- As a user, I want to tap a history item to copy it to the clipboard.

### Acceptance Criteria
- [ ] History list shows at most 50 items, oldest evicted when full.
- [ ] Empty-input transformations are not saved.
- [ ] History persists across app restarts.

### Technical Constraints
- History screen must load in under 300ms on a mid-range Android device.

---
**Removed:** competitive references, retention targets, launch dates, personnel attribution
**Safe to pass to:** pa-feature-pipeline, pa-ai-document, pa-chain-of-thought
```

---

## Example 2: Ticket with OKRs mixed into functional requirements

**Input (raw):**
```
Add a "Copy Enhanced Prompt" button to the transformer screen.
This supports our Q3 OKR of 10K daily active users.
The button should appear below the output text field.
Tapping it copies the text and shows a "Copied!" snackbar for 2 seconds.
Error: if clipboard is unavailable, show an error snackbar instead.
```

**Output:**
```markdown
## Filtered Feature Spec: Copy Enhanced Prompt Button

### Functional Requirements
- Add a "Copy Enhanced Prompt" button below the output text field on the transformer screen.
- Tapping the button copies the enhanced prompt text to the clipboard.
- A "Copied!" snackbar is shown for 2 seconds after a successful copy.

### UI/UX Specifications
- Button appears below the output text field.
- Success feedback: "Copied!" snackbar, 2-second duration.

### Acceptance Criteria
- [ ] Button is visible on transformer screen below output field.
- [ ] Tapping copies text and shows "Copied!" snackbar for 2s.
- [ ] If clipboard is unavailable, an error snackbar is shown instead.

---
**Removed:** OKR metrics
**Safe to pass to:** pa-feature-pipeline, pa-ai-document, pa-chain-of-thought
```

---

## Example 3: Input with no sensitive content

**Input (raw):**
```
Add offline support for the pattern library. Patterns should be bundled as assets
and loaded from disk when the network is unavailable. A "Offline mode" badge
should appear in the app bar when offline.
```

**Output:**
```markdown
## Filtered Feature Spec: Offline Pattern Library

### Functional Requirements
- Patterns should be bundled as assets and loaded from disk when the network is unavailable.

### UI/UX Specifications
- Display an "Offline mode" badge in the app bar when the device is offline.

### Technical Constraints
- Pattern library must function fully without network access.

---
**Removed:** nothing
**Safe to pass to:** pa-feature-pipeline, pa-ai-document, pa-chain-of-thought
```
