# Examples — Flipped Interaction

---

## Example 1: Vague Pattern Request (LOW priority)

**Input:**
```
REQUEST: "Add something to help users who don't know which pattern to use"
PRIORITY: low
```

**Output:**
```
Before I implement this, I have 4 quick questions:

1. Should the app automatically suggest a pattern based on what the user typed, or should it show a "guide me" flow where the user answers a few questions?
2. Which screen should this appear on — the transformer input screen, or a separate onboarding/discovery screen?
3. Does this need to persist (e.g., remember the user's preferred pattern) or is it session-only?
4. Do you have a specific pattern category in mind, or should all patterns be eligible for suggestion?
```

---

## Example 2: Partially Clear Feature Request (MEDIUM priority)

**Input:**
```
REQUEST: "Add auto-select for patterns"
CONTEXT: PatternSelectorRow exists. User currently picks manually.
```

**Output:**
```
Before I implement this, I have 3 quick questions:

1. Should the suggestion be applied automatically (no user action) or require the user to tap an "Auto" chip to accept it?
2. What logic drives the suggestion — keyword matching against the user's input, or something else?
3. What should happen when no pattern matches the input — fallback to the first pattern, or leave the selector empty?
```

---

## Example 3: Clear Feature, One Blocking Question (HIGH priority)

**Input:**
```
REQUEST: "Add a copy button to the result card"
PRIORITY: high
```

**Output:**
```
Before I implement this, I have 1 quick question:

1. Should copying show a confirmation (e.g., a SnackBar "Copied!"), or is silent copy acceptable?
```

---

## Example 4: New Prompt Pattern Request (MEDIUM priority)

**Input:**
```
REQUEST: "Add a chain-of-thought pattern to the library"
PRIORITY: medium
```

**Output:**
```
Before I implement this, I have 3 quick questions:

1. Do you have a template string in mind, or should I design one?
2. What is a concrete example — a simple user input and what the enhanced output should look like?
3. Which category should this pattern appear under in the pattern library?
```
