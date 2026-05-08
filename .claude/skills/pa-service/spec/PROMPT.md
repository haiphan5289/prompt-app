# Execution Workflow — pa-service

## Step 1: Determine if a Service is needed

Ask: does this feature make an HTTP call?
- YES → continue
- NO → stop. Use DataSource directly. Services are only for network calls.

Use cases that require a Service:
- Calling Claude / OpenAI / Gemini API for pattern suggestions or auto-enhancement
- Fetching remote pattern library updates from a backend
- Sending analytics/feedback to a server

## Step 2: Parse Input

Read the input fields:
- `NAME` — PascalCase base name (e.g. `PatternSuggestion`)
- `ENDPOINT` — base URL or description
- `OPERATIONS` — list of operations, each with `name`, `method`, `request`, `response`
- `FEATURE` — target feature folder (e.g. `transformer`, `pattern_library`)

Derive:
- `name_snake` = snake_case of NAME (e.g. `pattern_suggestion`)
- `nameCamel` = camelCase of NAME (e.g. `patternSuggestion`)

## Step 3: Generate Domain Interface

Create `lib/features/{{feature}}/domain/services/{{name_snake}}_service.dart`:

```dart
abstract interface class {{Name}}Service {
  Future<{{ResponseModel}}> {{operation}}({{RequestModel}} request);
}
```

- One method per operation
- All methods return `Future<T>` — never `Stream` or `Observable`
- Method signature uses request/response model types

## Step 4: Generate Service Implementation

Create `lib/features/{{feature}}/data/services/{{name_snake}}_service_impl.dart`:

```dart
import 'package:dio/dio.dart';

class {{Name}}ServiceImpl implements {{Name}}Service {
  const {{Name}}ServiceImpl({required this.dio});

  final Dio dio;

  @override
  Future<{{ResponseModel}}> {{operation}}({{RequestModel}} request) async {
    final response = await dio.post(
      '{{endpoint}}',
      data: request.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer ${const String.fromEnvironment('API_KEY')}',
          'Content-Type': 'application/json',
        },
      ),
    );
    return {{ResponseModel}}.fromJson(response.data as Map<String, dynamic>);
  }
}
```

Note: For AI API calls, prefer `package:anthropic_sdk_dart` if available instead of raw Dio.

## Step 5: Generate Request / Response Models

Create `lib/features/{{feature}}/data/models/{{operation_snake}}_request.dart`:

```dart
class {{Operation}}Request {
  const {{Operation}}Request({required this./* fields */});
  final /* Type field */;

  Map<String, dynamic> toJson() => {/* field: value pairs */};
}
```

Create `lib/features/{{feature}}/data/models/{{operation_snake}}_response.dart`:

```dart
class {{Operation}}Response {
  const {{Operation}}Response({required this./* fields */});
  final /* Type field */;

  factory {{Operation}}Response.fromJson(Map<String, dynamic> json) =>
      {{Operation}}Response(
        /* field: json['key'] as Type */
      );
}
```

## Step 6: Generate Riverpod Providers

In `lib/features/{{feature}}/data/providers/{{name_snake}}_providers.dart` (or a shared `dio_provider.dart`):

```dart
@riverpod
Dio dio(DioRef ref) => Dio(BaseOptions(connectTimeout: const Duration(seconds: 10)));

@riverpod
{{Name}}Service {{nameCamel}}Service({{Name}}ServiceRef ref) =>
    {{Name}}ServiceImpl(dio: ref.watch(dioProvider));
```

## Step 7: Register in Notifier

In the feature Notifier, inject the service and call it inside `AsyncValue.guard()`:

```dart
final result = await AsyncValue.guard(
  () => ref.read({{nameCamel}}ServiceProvider).{{operation}}(request),
);
```

## Step 8: Verify

- [ ] `flutter analyze` passes with no errors
- [ ] Domain interface is in `domain/services/`
- [ ] Implementation is in `data/services/`
- [ ] Models are in `data/models/`
- [ ] No API key is hardcoded
- [ ] All methods return `Future<T>`
