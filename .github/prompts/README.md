# Flutter Prompts - Prompt App

This directory contains reusable prompt templates for Flutter development with Clean Architecture and Riverpod.

## Available Prompts

### Core Development Prompts

| Prompt | Description | Use When |
|--------|-------------|----------|
| [flutter-generate-usecase](flutter-generate-usecase.prompt.md) | Auto-generate UseCase through Clean Architecture layers | Creating new UseCases with repository calls |
| [flutter-handle-usecase](flutter-handle-usecase.prompt.md) | Add UseCase execution method to existing Notifier | Adding new methods to existing Notifiers |
| [flutter-repository-generation](flutter-repository-generation.prompt.md) | Generate Repository interface + implementation with datasources | Creating data layer for a feature |
| [flutter-module-generation](flutter-module-generation.prompt.md) | Generate complete feature module (all layers at once) | Starting a new feature from scratch |
| [flutter-widget-generation](flutter-widget-generation.prompt.md) | Generate Material 3 widgets with theming | Creating reusable UI components |
| [flutter-scaffold](flutter-scaffold.prompt.md) | Generate barebone files with proper structure and TODOs | Quick file scaffolding with guided implementation |
| [flutter-service-generation](flutter-service-generation.prompt.md) | Auto-generate API service layer with Dio + error handling | Integrating with REST APIs |

### Navigation & Integration

| Prompt | Description | Use When |
|--------|-------------|----------|
| [flutter-deeplink-navigation](flutter-deeplink-navigation.prompt.md) | Implement deeplink navigation with GoRouter | Adding deeplink support, universal links |
| [flutter-tool-integration](flutter-tool-integration.prompt.md) | Systematic problem-solving with Flutter tools | Debugging, profiling, complex problem-solving |

### Planning & Analysis Prompts

| Prompt | Description | Use When |
|--------|-------------|----------|
| [flutter-input-collection](flutter-input-collection.prompt.md) | Collect input from user to clarify requirements | Requirements are unclear or ambiguous |
| [flutter-recipe-pattern](flutter-recipe-pattern.prompt.md) | Complete partial requirements into implementation recipes | Have partial specs that need completion |
| [flutter-flipped-interaction](flutter-flipped-interaction.prompt.md) | Ask clarifying questions before implementing | Feature requirements are unclear or complex |
| [flutter-chain-of-thought](flutter-chain-of-thought.prompt.md) | Step-by-step technical analysis and design | Breaking down complex problems systematically |
| [flutter-alternative-approaches](flutter-alternative-approaches.prompt.md) | Generate 3-5 alternative solutions with pros/cons | Evaluating different implementation strategies |
| [flutter-question-refinement](flutter-question-refinement.prompt.md) | Transform vague questions into precise technical queries | Questions are ambiguous or need clarification |

### Quality & Testing Prompts

| Prompt | Description | Use When |
|--------|-------------|----------|
| [flutter-fact-checklist](flutter-fact-checklist.prompt.md) | Extract actionable facts from PRDs into development checklists | Analyzing PRDs, converting requirements to tasks |
| [flutter-architecture-review](flutter-architecture-review.prompt.md) | Code review for architecture compliance | Reviewing PRs or auditing code quality |
| [flutter-unittest-generation](flutter-unittest-generation.prompt.md) | Generate unit tests and widget tests | Adding test coverage to features |
| [flutter-cognitive-verifier](flutter-cognitive-verifier.prompt.md) | Verify comprehensive feature context before implementation | Starting complex features, ensuring requirements are clear |
| [flutter-semantic-filter](flutter-semantic-filter.prompt.md) | Filter PRD content for Flutter-relevant technical specs | Analyzing PRDs with mixed business/technical content |

### Learning & Communication

| Prompt | Description | Use When |
|--------|-------------|----------|
| [flutter-example-based-learning](flutter-example-based-learning.prompt.md) | Learn Flutter patterns through practical examples | Teaching, code review, learning new patterns |
| [flutter-tail-pattern](flutter-tail-pattern.prompt.md) | Reinforce context at end of every response | Long conversations, maintaining consistency |
| [flutter-audience-persona](flutter-audience-persona.prompt.md) | Tailor explanations to specific audiences | Teaching different skill levels, documentation |
| [flutter-persona-pattern](flutter-persona-pattern.prompt.md) | Activate expert Flutter developer persona | Need context-aware development assistance |

## OpenSpec Prompts

| Prompt | Description |
|--------|-------------|
| [opsx-propose](opsx-propose.prompt.md) | Propose a new change with all artifacts |
| [opsx-apply](opsx-apply.prompt.md) | Implement tasks from an OpenSpec change |
| [opsx-explore](opsx-explore.prompt.md) | Explore ideas before committing to implementation |
| [opsx-archive](opsx-archive.prompt.md) | Archive completed changes |

---

## 📊 Statistics

- **Total Active Prompts**: 28 (24 Flutter + 4 OpenSpec)
- **Original iOS Prompts**: 41 (backed up in `prompts-backup/`)
- **Total Lines**: ~100,000+ lines of Flutter-specific guidance

---

## Quick Usage Examples

### 1. Start a New Feature (Complete Module)
```
Follow instructions in flutter-module-generation.prompt.md:
- Feature: history
- Entity: HistoryItem
- Description: Display and manage prompt transformation history
- Data source: Local (Hive)
```

**Generates:** 15 files across all Clean Architecture layers

---

### 2. Generate a UseCase Only
```
Follow instructions in flutter-generate-usecase.prompt.md:
- Feature: transformer
- UseCase: TransformPromptUseCase
- Input: (String rawPrompt, PromptPattern pattern)
- Output: String
```

**Generates:** UseCase → Repository → Provider wiring

---

### 3. Generate Repository with Caching
```
Follow instructions in flutter-repository-generation.prompt.md:
- Feature: history
- Repository: HistoryRepository
- Data sources: Remote (API) + Local (Hive cache)
- Caching strategy: Cache-aside with 5-minute TTL
```

**Generates:** Interface, Implementation, Remote/Local datasources

---

### 4. Generate Tests
```
Follow instructions in flutter-unittest-generation.prompt.md:
- Test type: UseCase unit test
- Class: TransformPromptUseCase
- Mock dependencies: PromptPattern
```

**Generates:** Test file with Given-When-Then structure

---

### 5. Review Code Quality
```
Follow instructions in flutter-architecture-review.prompt.md:
- Review scope: Single file or full PR
- Focus areas: Architecture, Riverpod, Performance, Testing
```

**Output:** Structured issue report with severity levels

---

### 6. Compare Implementation Approaches
```
Follow instructions in flutter-alternative-approaches.prompt.md:
- Problem: How to store history data?
- Context: 50 items max, needs persistence
```

**Output:** 3-5 solutions with pros/cons, comparison matrix, recommendation

---

### 7. Generate Material 3 Widgets
```
Follow instructions in flutter-widget-generation.prompt.md:
- Widget type: ResultCard
- Props: TransformerResult result
- Components: Card, Chip, CopyButton
```

**Generates:** Stateless/Consumer widget with theme tokens

---

### 8. Full Feature Workflow
```
1. Use flutter-flipped-interaction to clarify requirements
2. Use flutter-chain-of-thought to design the solution
3. Use flutter-module-generation to scaffold files
4. Use opsx-apply to implement tasks
5. Use flutter-unittest-generation to add tests
6. Use flutter-architecture-review to validate code
```

---

## Pattern Integration

These prompts integrate with the Claude AI skills in `.claude/skills/`:
- `pa-flutter-expert-skill` — References these prompts for implementation
- `pa-scaffold` — Uses module/widget generation patterns
- `pa-review-code` — Uses architecture review checklist
- `pa-unittest` — Uses test generation templates

## Prompt Categories Summary

### 🏗️ **Generation (Scaffolding)**
- `flutter-module-generation` — Complete feature (15 files)
- `flutter-generate-usecase` — UseCase layer
- `flutter-repository-generation` — Repository + datasources
- `flutter-widget-generation` — UI components

### 📋 **Planning & Analysis**
- `flutter-flipped-interaction` — Ask-first pattern
- `flutter-chain-of-thought` — 8-step analysis
- `flutter-alternative-approaches` — Solution comparison

### ✅ **Quality Assurance**
- `flutter-architecture-review` — 6-dimension review
- `flutter-unittest-generation` — Test scaffolding

### 🎯 **Developer Tools**
- `flutter-persona-pattern` — Expert mode activation

### 🔄 **Workflow (OpenSpec)**
- `opsx-propose` — Feature proposals
- `opsx-apply` — Task implementation
- `opsx-explore` — Problem exploration
- `opsx-archive` — Change archival

## Customization Guide

To adapt a prompt for your specific needs:

1. **Copy the template**
2. **Modify "Context Understanding"** section for your domain
3. **Update "Architecture Requirements"** with your patterns
4. **Add domain-specific examples**
5. **Update file paths** to match your structure

## File Naming Convention

All Flutter prompts follow this pattern:
```
flutter-{category}-{action}.prompt.md
```

Examples:
- `flutter-generate-usecase.prompt.md`
- `flutter-architecture-review.prompt.md`
- `flutter-unittest-generation.prompt.md`

## Automation Folder

The `automation/` folder contains MCP server configurations for advanced workflows. See `automation/README.md` for details.

---

**Total Prompts:** 14 (10 Flutter-specific + 4 OpenSpec workflow)
