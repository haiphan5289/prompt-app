# Input Schema — pa-figma-implement

## Parameters

| Parameter | Type | Required | Values | Description |
|---|---|---|---|---|
| `FIGMA_URL` | URL string | Yes* | Figma frame URL or frame ID | The Figma design to implement |
| `TARGET` | enum | Yes | `Screen`, `Widget`, `Component` | What level of UI is being implemented |
| `NAME` | PascalCase string | Yes | — | Class name to generate (e.g. `TransformerScreen`) |
| `FEATURE` | string | Yes | Feature folder name | Feature folder (e.g. `transformer`, `pattern_library`) |
| `DESCRIPTION` | string | No | — | Optional: description if Figma MCP is unavailable |

*If Figma MCP is unavailable, `FIGMA_URL` is still useful for reference but a screenshot or description substitutes.

## TARGET Values

| Value | Description | Output |
|---|---|---|
| `Screen` | A full screen with `Scaffold` | `lib/features/{{feature}}/presentation/screens/{{name_snake}}_screen.dart` |
| `Widget` | A reusable widget component | `lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart` |
| `Component` | A small, atomic UI element | `lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart` |

## Example Inputs

### Full screen from Figma URL

```
FIGMA_URL: https://www.figma.com/file/abc123/Prompt-App?node-id=42-100
TARGET: Screen
NAME: TransformerScreen
FEATURE: transformer
```

### Widget from screenshot

```
FIGMA_URL: (not available)
TARGET: Widget
NAME: PatternSelectorRow
FEATURE: transformer
DESCRIPTION: Horizontal scrollable row of filter chips. Selected chip has purple-ish background. Unselected chip is light grey. Labels are short category names.
```

### Component

```
FIGMA_URL: https://www.figma.com/file/abc123?node-id=55-200
TARGET: Component
NAME: PromptHistoryItem
FEATURE: history
```

## Design Information Needed (when no MCP)

If Figma MCP is unavailable, ask the user to provide:
1. Screenshot or verbal description
2. Colors (background, text, accent, border)
3. Text sizes and weights (map to hierarchy: hero, title, body, caption)
4. Pixel spacing between elements
5. Which elements are interactive (tap, long-press, swipe, input)
6. What states exist (normal, loading, empty, error, selected, disabled)
