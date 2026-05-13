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

### Phase 1 — MVP

| # | Feature | Description |
|---|---|---|
| 1 | **Prompt Transformer** | Input field → select pattern → display enhanced prompt |
| 2 | **Pattern Library** | Browse curated patterns (Role+Task, Chain-of-Thought, Few-Shot, RISEN, CATO) |
| 3 | **Pattern Preview** | See what a pattern does before applying, with before/after example |
| 4 | **One-tap Copy** | Copy enhanced prompt to clipboard with confirmation feedback |

### Phase 2 — Extended

| # | Feature | Description |
|---|---|---|
| 5 | **History** | List of past transforms with original vs enhanced side by side |
| 6 | **Favorite Patterns** | Star patterns for quick access |
| 7 | **Share Enhanced Prompt** | Share directly to other apps via system share sheet |
| 8 | **Pattern Categories** | Filter patterns by use case: Code, Writing, Analysis, Debug |
| 9 | **History Search** | Full-text search across past transforms |
| 10 | **History Export** | Export history as text or JSON |
| 11 | **Onboarding** | First-run walkthrough explaining the transformer concept |
| 12 | **Dark Mode** | Full Material 3 dark theme support |
| 13 | **Custom Patterns** | Define your own pattern templates |

### Future — AI Integration

| # | Feature | Description |
|---|---|---|
| 14 | **AI Pattern Suggestion** | Auto-select the best pattern based on input intent |
| 15 | **Live Preview** | Run the enhanced prompt against an LLM and show the result inline |
| 16 | **Pattern Ratings** | Users rate which enhanced prompts got better AI results |

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.10+ (Dart 3) |
| State management | Riverpod 2 |
| AI integration | Google Gemini `gemini-1.5-flash` via HTTP (free tier) |
| Architecture | Clean Architecture (Feature-first) |
| Development workflow | OpenSpec + Claude AI Skills |

---

## Development Workflow

This project uses **OpenSpec** for structured feature development and **Claude AI Skills** for implementation assistance.

### OpenSpec Workflow

OpenSpec provides a systematic approach to building features:

1. **Propose** — Design a feature with all artifacts (proposal, design, tasks)
   ```
   /openspec-propose [feature-name]
   ```

2. **Apply** — Implement the tasks from the change
   ```
   /openspec-apply-change [change-name]
   ```

3. **Explore** — Think through problems before coding
   ```
   /openspec-explore
   ```

4. **Archive** — Finalize completed changes
   ```
   /openspec-archive-change [change-name]
   ```

Changes are stored in `openspec/changes/[change-name]/` with artifacts like `proposal.md`, `design.md`, and `tasks.md`.

### Claude AI Skills & Agents

This project includes specialized skills for Flutter development:

**Core Skills:**
- `pa-flutter-expert-skill` — Flutter/Riverpod architecture patterns
- `pa-scaffold` — Generate boilerplate (screens, widgets, use cases)
- `pa-feature-pipeline` — End-to-end feature development
- `pa-bugfix-skill` — Debug and fix Flutter issues
- `pa-review-code` — Code review checklist
- `pa-unittest` — Generate widget and unit tests
- `pa-prompt-pattern-design` — Design new prompt patterns

**Agents:**
- `pa-flutter-expert` — Primary implementation agent
- `pa-prompt-engineer` — Prompt pattern domain expert
- `pa-quality-engineer` — QE validation after implementation

**Screen Development:**
- `new-screen-plan` — Plan new screens (requirements + architecture)
- `new-screen-build` — Build new screens (scaffolding + implementation)
- `update-screen` — Modify existing screens

See [.claude/CLAUDE.md](.claude/CLAUDE.md) for complete skill reference.

### AI-Assisted Development

This project leverages Claude AI with custom skills for:

- **Code Generation**: Auto-generate boilerplate (UseCases, Repositories, Screens)
- **Feature Planning**: Structured proposals with OpenSpec
- **Code Review**: Automated checks for architecture compliance
- **Testing**: Generate widget and unit tests
- **Documentation**: Auto-generate feature docs with diagrams
- **Debugging**: Trace issues through Clean Architecture layers

**Example workflows:**
```
# Generate a new use case across all layers
/pa-generate-usecase [UseCase Name]

# Plan and build a complete screen
/new-screen-plan [ScreenName] [description]
/new-screen-build [ScreenName]

# Review code for architecture compliance
/pa-review-code [file-path]

# Generate test coverage
/pa-unittest [file-path]
```

All skills follow Clean Architecture patterns and Riverpod best practices.

---

## Quick Links

| Resource | Purpose |
|---|---|
| [.claude/CLAUDE.md](.claude/CLAUDE.md) | Claude context, skills, and agents reference |
| [.github/skills/](.github/skills/) | OpenSpec workflow skills (propose, apply, explore, archive) |
| [lib/features/transformer/FEATURE.md](lib/features/transformer/presentation/screens/FEATURE.md) | Transformer screen architecture and flow diagrams |
| [SETUP.md](SETUP.md) | Detailed setup instructions |

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.10.0` — [install guide](https://docs.flutter.dev/get-started/install)
- Dart SDK `>=3.0.0` (bundled with Flutter)
- Xcode (iOS) or Android Studio (Android)
- A **free** [Google Gemini API key](https://aistudio.google.com) for AI responses

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Generate iOS/Android platform folders (first time only)

If the `ios/` or `android/` folder is missing, run:

```bash
flutter create --org com.haiphan --project-name prompt_app .
```

> This only adds platform folders. It does not overwrite any Dart code in `lib/`.

### 3. Run the app

**Get a free Gemini API key:**
1. Go to [aistudio.google.com](https://aistudio.google.com)
2. Sign in with Google → **Get API key** → **Create API key**
3. Copy the key (format: `AIza...`)

**With AI enabled:**
```bash
flutter run --dart-define=GEMINI_API_KEY=AIza-your-key-here
```

**UI-only (no API key):**
```bash
flutter run
```

> Without a key the app runs normally. Submitting a prompt will show a retry button with a 401 error.

**Target a specific device:**
```bash
# List connected devices
flutter devices

# Run on a specific device
flutter run -d <device-id> --dart-define=GEMINI_API_KEY=AIza-your-key-here
```

### 4. Physical iPhone setup

To run on a physical iPhone:
1. Connect iPhone via USB
2. Go to **Settings → Privacy & Security → Developer Mode** and enable it
3. iPhone will restart — confirm enabling Developer Mode
4. Run `flutter run -d <your-iphone-device-id>`

### Build

```bash
# Android APK
flutter build apk --dart-define=GEMINI_API_KEY=AIza-your-key-here

# iOS
flutter build ios --dart-define=GEMINI_API_KEY=AIza-your-key-here

# macOS
flutter build macos --dart-define=GEMINI_API_KEY=AIza-your-key-here
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
├── .github/
│   ├── skills/               ← OpenSpec skills (propose, apply, explore, archive)
│   ├── prompts/              ← Reusable prompt templates
│   └── workflows/            ← CI/CD pipelines
├── .claude/
│   ├── CLAUDE.md             ← Claude context and skill reference
│   ├── skills/               ← Flutter-specific AI skills
│   └── agents/               ← Specialized agents (flutter-expert, prompt-engineer)
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── network/          ← Gemini/OpenAI HTTP client
│   │   └── theme/            ← AppTheme, AppColors, AppSpacing
│   ├── features/
│   │   └── transformer/
│   │       ├── domain/       ← PromptPattern entity, UseCases, Repository interface
│   │       ├── data/         ← AIRepositoryImpl, datasource, Riverpod providers
│   │       └── presentation/ ← TransformerNotifier, TransformerScreen
│   └── shared/
│       └── widgets/          ← CopyButton, reusable components
├── openspec/
│   └── changes/              ← OpenSpec change artifacts (proposal, design, tasks)
├── test/
└── pubspec.yaml
```

**Key Directories:**
- `.github/` — OpenSpec skills and CI workflows
- `.claude/` — Claude AI skills and agents for development
- `lib/features/` — Feature-first Clean Architecture modules
- `openspec/changes/` — Structured feature proposals and tasks

---

## Contributing

### Development Process

This project follows a structured development workflow:

1. **Start with OpenSpec Propose**
   ```
   /openspec-propose [feature-name]
   ```
   Creates a complete proposal with design and tasks.

2. **Implement with OpenSpec Apply**
   ```
   /openspec-apply-change [feature-name]
   ```
   Works through the task list systematically.

3. **Use AI Skills for Implementation**
   - Generate scaffolding: `/pa-scaffold`
   - Create screens: `/new-screen-plan` then `/new-screen-build`
   - Review code: `/pa-review-code`
   - Add tests: `/pa-unittest`

4. **Archive when complete**
   ```
   /openspec-archive-change [feature-name]
   ```

### Git Workflow

1. Fork the repo
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Follow the OpenSpec workflow for implementation
4. Commit your changes: `git commit -m "feat: add your feature"`
5. Push and open a PR against `main`

### Code Standards

- **Architecture**: Clean Architecture with feature-first structure
- **State Management**: Riverpod 2 AsyncNotifiers
- **UI**: Material 3 design system with theme tokens
- **Testing**: Widget tests for screens, unit tests for use cases
- **Documentation**: Update FEATURE.md for significant features

See [.claude/skills/pa-review-code/](.claude/skills/pa-review-code/) for the complete checklist.

---

## License

MIT
