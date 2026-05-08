# Input Schema — pa-widget

## Parameters

| Parameter | Type | Required | Values | Description |
|---|---|---|---|---|
| `WIDGET_TYPE` | enum | Yes | `Card`, `TextField`, `Button`, `Chip`, `ListItem`, `Sheet`, `Banner` | Category of widget being built |
| `NAME` | PascalCase string | Yes | — | Widget class name (e.g. `PatternCard`) |
| `FEATURE` | string | Yes | Feature folder name or `shared` | Where the widget lives (e.g. `transformer`, `pattern_library`, `shared`) |
| `READS_PROVIDER` | enum | Yes | `yes`, `no` | Whether the widget reads Riverpod provider state |
| `PROPS` | List of `name: Type` | Yes | — | Constructor parameters — required and optional |

## Props Format

```
PROPS:
  - propName: Type          # required prop
  - propName: Type?         # optional prop (trailing ?)
  - onTap: VoidCallback?    # callback prop
```

## Derived Values

| Derived | Rule | Example |
|---|---|---|
| `name_snake` | PascalCase → snake_case | `PatternCard` → `pattern_card` |
| File path | `lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart` | — |
| Base class | `READS_PROVIDER: yes` → `ConsumerWidget`, else `StatelessWidget` | — |

## Example Input: Simple Card

```
WIDGET_TYPE: Card
NAME: PatternCard
FEATURE: pattern_library
READS_PROVIDER: no
PROPS:
  - pattern: PromptPattern
  - onTap: VoidCallback?
```

## Example Input: Provider-Connected Result

```
WIDGET_TYPE: Card
NAME: PromptResultCard
FEATURE: transformer
READS_PROVIDER: yes
PROPS: []
```

## Example Input: Chip with Selection

```
WIDGET_TYPE: Chip
NAME: CategoryChip
FEATURE: shared
READS_PROVIDER: no
PROPS:
  - label: String
  - isSelected: bool
  - onTap: VoidCallback
```
