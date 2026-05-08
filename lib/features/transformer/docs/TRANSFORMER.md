# Transformer Feature

Transforms a simple user prompt into a well-structured AI prompt using a selected pattern, then runs it through ChatGPT and returns the AI response in-app.

---

## User Flow

```
User types raw prompt
        ↓
Select a pattern (Role-based, CoT, Few-Shot, RISEN, CATO…)
        ↓
TransformPromptUseCase → applies template → enhanced prompt
        ↓
RunPromptUseCase → POST /chat/completions (gpt-4o-mini)
        ↓
AI response displayed in-app
```

---

## Architecture

```
lib/features/transformer/
├── domain/
│   ├── entities/
│   │   └── prompt_pattern.dart         ← Pattern entity + transform(rawPrompt)
│   ├── repositories/
│   │   └── ai_repository.dart          ← abstract interface (no deps)
│   └── usecases/
│       ├── transform_prompt_use_case.dart  ← applies pattern template
│       └── run_prompt_use_case.dart        ← calls AI via repository
├── data/
│   ├── datasources/
│   │   └── ai_remote_datasource.dart   ← wraps OpenAIClient
│   ├── repositories/
│   │   └── ai_repository_impl.dart     ← implements AIRepository
│   └── providers/
│       └── ai_providers.dart           ← Riverpod wiring (all providers)
├── presentation/
│   ├── notifiers/
│   │   └── transformer_notifier.dart   ← state: rawPrompt, pattern, result, aiResponse
│   └── screens/
│       └── transformer_screen.dart     ← main UI
└── docs/
    └── TRANSFORMER.md                  ← this file
```

---

## Clean Architecture Rules

| Layer | What it can import | What it cannot import |
|---|---|---|
| `domain/` | Pure Dart only | Flutter, Riverpod, http, SharedPreferences |
| `data/` | domain/, core/network/, packages | presentation/ |
| `presentation/` | domain/, flutter_riverpod | data/ directly |

---

## State Shape (TransformerNotifier)

```dart
// AsyncValue<TransformerResult>
class TransformerResult {
  final String rawPrompt;
  final PromptPattern pattern;
  final String enhancedPrompt;
  final String? aiResponse;    // null until RunPromptUseCase completes
}
```

---

## OpenAI Integration

| Property | Value |
|---|---|
| Endpoint | `POST https://api.openai.com/v1/chat/completions` |
| Model | `gpt-4o-mini` |
| Timeout | 30 seconds |
| Auth | `Bearer $OPENAI_API_KEY` |
| Error type | `OpenAIException(statusCode, message)` |

### Inject API key at build time

```bash
# Development
flutter run --dart-define=OPENAI_API_KEY=sk-...

# Build
flutter build apk --dart-define=OPENAI_API_KEY=sk-...
```

The key is read via `String.fromEnvironment('OPENAI_API_KEY')` in [ai_providers.dart](../data/providers/ai_providers.dart) — never hardcoded.

---

## Adding a New Pattern

1. Create a new `PromptPattern` constant in `domain/entities/prompt_pattern.dart`
2. Define the `template` string with `{{rawPrompt}}` placeholder
3. Add it to the pattern list in `PatternRepository`

No changes needed to the UseCase, notifier, or UI — the template drives everything.

---

## Related Files

| File | Purpose |
|---|---|
| [lib/core/network/openai_client.dart](../../../../core/network/openai_client.dart) | Raw HTTP client |
| [lib/core/theme/app_colors.dart](../../../../core/theme/app_colors.dart) | Pattern category badge colors |
| [lib/shared/widgets/copy_button.dart](../../../../shared/widgets/copy_button.dart) | Copy enhanced prompt / AI response |
