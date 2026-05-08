# Quality Checklist — pa-service

Run these checks after generating a service. All items must pass.

## Architecture

- [ ] 1. Service interface is in `domain/services/` — not in `data/`
- [ ] 2. Service implementation is in `data/services/` — not in `domain/`
- [ ] 3. Domain interface imports only domain-layer types (no `package:dio`, no Flutter)
- [ ] 4. Implementation imports `package:dio/dio.dart` only in data layer
- [ ] 5. Request/response models are in `data/models/`

## Code Quality

- [ ] 6. Service class uses `const` constructor
- [ ] 7. `Dio` is injected via constructor — never instantiated inside the class
- [ ] 8. Implementation method signature exactly matches the interface
- [ ] 9. Interface uses `abstract interface class` syntax (Dart 3+)
- [ ] 10. All methods return `Future<T>` — no `Stream`, no `Observable`

## Security

- [ ] 11. No API key is hardcoded as a string literal
- [ ] 12. API keys use `String.fromEnvironment('API_KEY')` exclusively
- [ ] 13. No credentials or tokens are stored in model fields

## Request Model

- [ ] 14. Request model has `const` constructor
- [ ] 15. `toJson()` includes all required fields
- [ ] 16. Optional fields use `if (field != null)` guard in `toJson()`
- [ ] 17. Field types match the API schema (String, int, double, bool)

## Response Model

- [ ] 18. Response model has `const` constructor
- [ ] 19. `fromJson()` factory casts each field explicitly (e.g. `as String`, `as num`)
- [ ] 20. Numeric fields use `(json['x'] as num).toDouble()` — not `as double`

## Riverpod Provider

- [ ] 21. `dioProvider` configures `connectTimeout` (10 seconds minimum)
- [ ] 22. Service provider returns `{{Name}}ServiceImpl`, injecting `dioProvider`
- [ ] 23. Providers use `@riverpod` annotation (code generation)
- [ ] 24. `part '{{name_snake}}_providers.g.dart'` directive present

## Error Handling

- [ ] 25. No try/catch inside the service — let Dio exceptions propagate
- [ ] 26. Notifier that calls the service wraps with `AsyncValue.guard()`

## Analysis

- [ ] 27. `flutter analyze` passes with zero errors on all generated files
- [ ] 28. No unused imports
