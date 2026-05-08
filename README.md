# Prompt App

Type a simple prompt. Get a powerful one back.

---

## Overview

Most people know *what* they want from an AI — they just don't know *how to ask for it*. Learning prompt engineering takes time most people don't have.

**Prompt App** removes that gap. You type a rough, natural-language prompt. The app runs it through a curated library of **prompt patterns** — proven structural frameworks that automatically add role, context, constraints, output format, and chain-of-thought instructions. The result is a well-architected prompt ready to paste into any AI tool.

```
User types:    "summarize this article"

App outputs:   "You are an expert analyst. Read the following article and produce
                a structured summary with: (1) the core argument in one sentence,
                (2) three key supporting points, (3) any notable limitations or
                biases. Be concise. Format as bullet points."
```

No prompt engineering knowledge required. The patterns do the work.

---

## Features

- **Prompt Transformer** — Paste any simple prompt; the app enhances it using a selected pattern
- **Pattern Library** — A curated set of prompt patterns (Role + Task, Chain-of-Thought, Few-Shot, RISEN, CATO, etc.)
- **One-tap Copy** — Copy the enhanced prompt directly into ChatGPT, Claude, Gemini, or any AI tool
- **History** — Review your original vs. enhanced prompts side by side
- **Pattern Preview** — See what each pattern does before applying it

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State management | TBD |
| Storage | TBD |
| AI integration | TBD |

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / Xcode (for device targets)

### Run the app

```bash
flutter pub get
flutter run
```

### Build

```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web
```

---

## How to Prompt Effectively

Good prompts follow a consistent structure. Use this as a mental model every time you write one.

### The CATO Framework

| Element | What it means | Example |
|---|---|---|
| **C**ontext | Who you are and the background | "I'm a Flutter developer building a login screen." |
| **A**ction | What you want the AI to do | "Write a reusable TextFormField widget." |
| **T**one | Style or format of the response | "Keep it concise, use comments for each prop." |
| **O**utput | How the answer should look | "Return only the widget code, no explanation." |

---

### 10 Rules for Better Prompts

1. **Be specific, not vague.**
   - Bad: `"Write some code for me."`
   - Good: `"Write a Flutter widget that displays a user avatar with a fallback initials placeholder."`

2. **Give context about yourself.**
   Tell the AI your role, skill level, or constraints. It changes the answer significantly.
   ```
   I'm a junior Flutter developer. Explain this as simply as possible.
   ```

3. **State the output format.**
   Ask for code blocks, bullet points, tables, or step-by-step instructions if that's what you need.
   ```
   Return the answer as a numbered list.
   ```

4. **Break complex tasks into steps.**
   Instead of one giant prompt, guide the AI through smaller sub-tasks and build on the output.

5. **Use examples (few-shot prompting).**
   Show the AI one or two examples of what a good response looks like.
   ```
   Convert the following to snake_case:
   - "My Variable Name" → "my_variable_name"
   - "HelloWorld" → ?
   ```

6. **Assign a role.**
   ```
   You are a senior iOS engineer. Review this Swift code for memory leaks.
   ```

7. **Constrain the scope.**
   If you want a short answer, say so. If you want depth, say so.
   ```
   Answer in under 3 sentences.
   ```

8. **Iterate — don't rewrite from scratch.**
   Build on previous responses rather than starting a new prompt each time.
   ```
   That's good, but make the function handle null values.
   ```

9. **Ask for alternatives.**
   ```
   Give me 3 different approaches and briefly explain the trade-offs of each.
   ```

10. **Check your assumptions.**
    If the AI makes a guess about something, call it out.
    ```
    You assumed I'm using REST. I'm actually using GraphQL — please redo the example.
    ```

---

### Prompt Templates

#### Code Generation
```
You are a [language] expert.
Write a [type of code] that [does X].
Requirements:
- [requirement 1]
- [requirement 2]
Return only the code with inline comments. No explanation needed.
```

#### Code Review
```
Review the following [language] code for [bugs / performance / security / style].
Point out issues with line references and suggest fixes.
[paste code here]
```

#### Explain a Concept
```
Explain [concept] to me as if I'm a [beginner / senior engineer / product manager].
Use an analogy and a short code example.
```

#### Debug Help
```
I'm getting this error in [language/framework]:
[paste error]

Here's the relevant code:
[paste code]

What's causing it and how do I fix it?
```

#### Write Content
```
Write a [type: blog post / tweet / email] about [topic].
Audience: [who will read this]
Tone: [professional / casual / technical]
Length: [word count or "short / medium / long"]
```

---

## Project Structure

```
prompt-app/
├── lib/
│   ├── main.dart
│   ├── screens/
│   ├── widgets/
│   ├── models/
│   └── services/
├── assets/
├── test/
└── pubspec.yaml
```

---

## Contributing

1. Fork the repo
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Commit your changes: `git commit -m "feat: add your feature"`
4. Push and open a PR against `main`

---

## License

MIT
