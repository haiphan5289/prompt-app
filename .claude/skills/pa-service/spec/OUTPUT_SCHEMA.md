# Output Schema — pa-service

## Generated Files

For each service, the following files are produced:

| File | Layer | Description |
|---|---|---|
| `lib/features/{{feature}}/domain/services/{{name_snake}}_service.dart` | Domain | Abstract interface — contract only, no Dio import |
| `lib/features/{{feature}}/data/services/{{name_snake}}_service_impl.dart` | Data | Dio-based implementation of the interface |
| `lib/features/{{feature}}/data/models/{{operation_snake}}_request.dart` | Data | Request model with `toJson()` |
| `lib/features/{{feature}}/data/models/{{operation_snake}}_response.dart` | Data | Response model with `fromJson()` factory |
| `lib/features/{{feature}}/data/providers/{{name_snake}}_providers.dart` | Data | Riverpod `@riverpod` providers for Dio + Service |

Note: if multiple operations exist, one request and one response model is generated per operation.

## File Count

- Minimum: 5 files (1 interface + 1 impl + 1 request + 1 response + 1 provider)
- For N operations: 3 + (2 × N) files

## Structure Example

```
lib/features/transformer/
├── domain/
│   └── services/
│       └── pattern_suggestion_service.dart        ← interface
└── data/
    ├── models/
    │   ├── suggest_pattern_request.dart            ← request model
    │   └── suggest_pattern_response.dart           ← response model
    ├── services/
    │   └── pattern_suggestion_service_impl.dart    ← implementation
    └── providers/
        └── pattern_suggestion_providers.dart       ← riverpod providers
```

## Interface Contract

The domain interface must:
- Use `abstract interface class` syntax (Dart 3+)
- Declare only method signatures — no fields, no constructors
- Import only domain-layer types (no Dio, no Flutter)

## Implementation Contract

The implementation must:
- Declare `const` constructor
- Accept `Dio` via constructor injection
- Use `String.fromEnvironment('API_KEY')` for secrets — never hardcode
- Cast response data with `as Map<String, dynamic>`
- Not cache, store, or transform responses beyond `fromJson`

## Provider Contract

Providers must use `@riverpod` code generation:
- `dioProvider` — returns a configured `Dio` instance with `connectTimeout`
- `{{nameCamel}}ServiceProvider` — returns `{{Name}}ServiceImpl` injecting `dioProvider`
