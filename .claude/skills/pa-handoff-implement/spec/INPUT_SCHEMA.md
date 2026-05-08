# Input Schema — Handoff Implement

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `HANDOFF` | string | yes | Inline spec text, file path, or URL of the handoff document (Notion, Figma, PRD, inline description) |
| `FEATURE` | string | yes | Feature folder name or feature area (e.g., `transformer`, `pattern_library`, `history`) |
| `SCOPE` | enum | yes | `UI only` / `full-stack` / `domain only` — determines which layers to touch |

## Scope Values

| Value | Meaning |
|---|---|
| `UI only` | Only presentation layer — widgets, screens, notifier state reads. No new UseCases or repositories. |
| `full-stack` | All layers — domain, data, DI, and presentation. May add new UseCases, repositories, and providers. |
| `domain only` | Domain and data layers only — new entities, UseCases, repository interfaces and implementations. No UI yet. |

## Accepted Handoff Formats

- Inline text description (pasted directly)
- Path to a markdown file
- Notion page URL (fetched via tool)
- Figma comment block (copied text)
- PRD bullet points

## Example Invocations

```
HANDOFF: "Result screen should show the original prompt above the enhanced version.
          Both should be selectable text. Add a distinct copy button for each."
FEATURE: transformer
SCOPE: full-stack
```

```
HANDOFF: /docs/specs/history-filter.md
FEATURE: history
SCOPE: full-stack
```

```
HANDOFF: "PatternCard should show a 'Popular' badge for patterns with usageCount > 100"
FEATURE: pattern_library
SCOPE: UI only
```
