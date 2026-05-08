# Input Schema — pa-design-system

## Parameters

| Parameter | Type | Required | Values | Description |
|---|---|---|---|---|
| `TASK` | enum | Yes | See below | The design system task being performed |
| `SCREEN` | string | Conditional | Screen name | Target screen name (when implementing a screen) |
| `COMPONENTS` | List of strings | Conditional | — | List of component types needed in the screen |
| `WIDGET_TYPE` | enum | Conditional | See component guide | The specific widget pattern to implement |
| `FEATURE` | string | Conditional | Feature folder name | Feature folder (e.g. `transformer`, `pattern_library`) |

## TASK Values

| Value | Description |
|---|---|
| `implement_screen` | Build a full screen using design system patterns |
| `implement_component` | Build a single component (card, input, chip, etc.) |
| `select_component` | Pick the right Material component for a need |
| `apply_typography` | Map text elements to correct textTheme tokens |
| `apply_iconography` | Select the correct icon constant |
| `audit_design` | Review existing UI for design system violations |

## Example Inputs

### Full screen implementation

```
TASK: implement_screen
SCREEN: TransformerScreen
FEATURE: transformer
COMPONENTS: [PromptInput, PatternSelector, TransformButton, ResultCard]
```

### Single component

```
TASK: implement_component
WIDGET_TYPE: ResultCard
FEATURE: transformer
```

### Component selection question

```
TASK: select_component
NEED: multi-line text input that grows with content
```

### Icon selection

```
TASK: apply_iconography
ACTION: copy to clipboard
```
