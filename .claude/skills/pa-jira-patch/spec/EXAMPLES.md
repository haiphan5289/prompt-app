# Examples — pa-jira-patch

## Example 1: Read mode — fetch ticket before implementing

**Input:**
```
JIRA: PA-42
MODE: read
```

**Output:**
```
## Ticket: PA-42
Title: Add prompt history screen
Priority: P2
Status: In Progress
Labels: history, flutter

### Acceptance Criteria
- [ ] History list shows at most 50 items
- [ ] Oldest entry is evicted when limit is exceeded
- [ ] Tapping an item copies the prompt to clipboard
- [ ] Empty-input transformations are not saved

### Technical Notes
Use Hive or SharedPreferences for local persistence. Keep the repository interface in domain, implementation in data.

### Recommendation
Pass to: pa-semantic-filter → pa-feature-pipeline
```

---

## Example 2: Update mode — patch ticket after implementation

**Input:**
```
JIRA: PA-42
MODE: update
PR_URL: https://github.com/org/prompt-app/pull/88
STATUS: In Review
NOTES: Implemented history screen with Hive persistence. HistoryNotifier manages state via Riverpod code-gen.
```

**Comment posted to PA-42:**
```markdown
## Implementation Complete

**PR:** https://github.com/org/prompt-app/pull/88
**Changes:**
- lib/features/history/domain/entities/history_entry.dart: new HistoryEntry entity
- lib/features/history/domain/usecases/get_history_use_case.dart: new GetHistoryUseCase
- lib/features/history/data/repositories/history_repository_impl.dart: Hive-backed implementation
- lib/features/history/presentation/screens/history_screen.dart: new HistoryScreen widget
- lib/features/history/presentation/notifiers/history_notifier.dart: new HistoryNotifier

**Test plan:**
- [ ] Open app, transform 3 prompts, navigate to history — all 3 appear
- [ ] Transform with empty input — item does not appear in history
- [ ] Add 51 items — oldest is evicted, list stays at 50
- [ ] flutter test passes

**Acceptance criteria status:**
- [x] History list shows at most 50 items — implemented in history_repository_impl.dart
- [x] Oldest entry is evicted when limit is exceeded — implemented in history_repository_impl.dart
- [x] Tapping an item copies the prompt to clipboard — implemented in history_screen.dart
- [x] Empty-input transformations are not saved — enforced in history_notifier.dart
```

**Terminal confirmation:**
```
Comment added: 10045
Ticket status transitioned to: In Review
```

---

## Example 3: Read mode — MCP unavailable

**Input:**
```
JIRA: PA-55
MODE: read
```

**Output (MCP unavailable):**
```
Atlassian MCP not available. To perform this action manually:
Read mode: Open PA-55 in your Jira browser and extract:
  - Summary, Priority, Status, Labels
  - Acceptance criteria (look for checklist in description)
  - Any implementation hints in the Technical Notes field
Then pass the extracted content through pa-semantic-filter before implementing.
```
