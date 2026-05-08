# Examples — pa-alternative-approaches

## Example 1: History Storage Strategy

**Input:**
```
PROBLEM: How should we store prompt history?
CONTEXT: history feature, data layer
COMPLEXITY: Medium
CONSTRAINTS: offline-first, no SQL
```

**Options generated:**

### Option 1: Hive (Typed Box)
Core idea: Store `HistoryEntry` objects in a typed Hive box with `@HiveType` annotations.
Score: 5 — already used for patterns, zero extra deps, offline-first by design.

### Option 2: SharedPreferences (JSON list)
Core idea: Serialize `HistoryEntry` to JSON and store as a string list.
Score: 3 — no schema, brittle for large lists, no indexing.

### Option 3: In-memory + export
Core idea: Keep history in a Riverpod `StateNotifier`, export to JSON file on demand.
Score: 2 — lost on app restart, no persistence.

**Recommendation:** Option 1 (Hive) — aligns with existing pattern_library storage, typed, offline-first.

---

## Example 2: AI API Integration

**Input:**
```
PROBLEM: How should we call the AI API from the transformer?
CONTEXT: transformer, service layer
COMPLEXITY: Complex
CONSTRAINTS: must support multiple providers (OpenAI, Anthropic), offline fallback
```

**Options generated:**

### Option 1: Abstract AIService interface + provider-specific impls
Core idea: Define `AIService` interface in domain; `OpenAIServiceImpl` / `AnthropicServiceImpl` in data; switch via env var.
Score: 5 — Clean Architecture compliant, testable with mocks, provider-agnostic.

### Option 2: Single Dio client with base URL config
Core idea: One Dio instance, swap `baseUrl` based on config flag.
Score: 3 — simpler but couples response parsing to one schema.

### Option 3: Flutter package (e.g. `langchain_dart`)
Core idea: Use a high-level LLM framework that abstracts providers.
Score: 2 — heavy dependency, less control, overkill for MVP.

**Decision framework:**
```
If multi-provider support required now → Option 1
If MVP with single provider → Option 2
Default → Option 1 (future-safe)
```

---

## Example 3: Template Engine

**Input:**
```
PROBLEM: How should we implement {{variable}} substitution in prompt templates?
CONTEXT: transformer, domain layer
COMPLEXITY: Simple
CONSTRAINTS: no external packages, offline
```

**Options:**

### Option 1: String.replaceAll
```dart
String apply(String template, String input) =>
    template.replaceAll('{{userInput}}', input.trim());
```
Score: 5 — zero deps, fast, testable.

### Option 2: Regex-based substitution
```dart
final result = template.replaceAllMapped(
  RegExp(r'\{\{(\w+)\}\}'),
  (m) => variables[m.group(1)] ?? m.group(0)!,
);
```
Score: 4 — supports multiple variables, slightly more complex.

### Option 3: Mustache package
Score: 2 — unnecessary dependency for simple substitution.

**Recommendation:** Option 1 for single `{{userInput}}` variable; Option 2 if multi-variable templates are needed.
