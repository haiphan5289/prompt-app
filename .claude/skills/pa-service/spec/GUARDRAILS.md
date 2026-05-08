# Guardrails — pa-service

## When NOT to Generate a Service

Do not generate a Service if the feature:
- Only reads from local storage (Hive, SharedPreferences, in-memory)
- Only performs pure computation (pattern transformation, string processing)
- Only manages in-app state (Riverpod Notifier state changes)

In those cases, use DataSource directly — Services are exclusively for HTTP calls.

## Prohibited Patterns

### Hardcoded API Keys

```dart
// NEVER
headers: {'Authorization': 'Bearer sk-ant-abc123'}
const apiKey = 'sk-ant-abc123';

// ALWAYS
headers: {'Authorization': 'Bearer ${const String.fromEnvironment('API_KEY')}'}
```

### Stateful Service

```dart
// NEVER — services must be stateless
class MyServiceImpl implements MyService {
  final List<Response> _cache = [];  // prohibited: local state
  String? _lastResult;               // prohibited: local state
}
```

### Streams in Service Interface

```dart
// NEVER
Stream<MyResponse> watchData();      // prohibited in Service interface
Observable<MyResponse> getData();    // prohibited

// ALWAYS
Future<MyResponse> getData();
```

### Dio Instantiated Inside Service

```dart
// NEVER
Future<MyResponse> fetch() async {
  final dio = Dio();                 // prohibited: instantiation inside method
}

// ALWAYS — inject via constructor
class MyServiceImpl implements MyService {
  const MyServiceImpl({required this.dio});
  final Dio dio;
}
```

### Wrong Layer Imports

```dart
// NEVER in domain interface
import 'package:dio/dio.dart';       // Dio must not appear in domain layer
import 'package:flutter/material.dart'; // Flutter must not appear in domain layer

// NEVER in data layer
import '../domain/datasources/...'; // datasources are domain-internal concerns
```

### Catching Errors in Service

```dart
// NEVER — service must propagate exceptions
Future<MyResponse> fetch() async {
  try {
    final response = await dio.get(...);
    return MyResponse.fromJson(response.data);
  } catch (e) {
    return MyResponse.empty();      // prohibited: swallowing errors
  }
}

// CORRECT — let exceptions propagate; Notifier handles them
Future<MyResponse> fetch() async {
  final response = await dio.get(...);
  return MyResponse.fromJson(response.data as Map<String, dynamic>);
}
```

## Verified Dart/Flutter Symbols

Only use these verified class names — do not invent variants:

| Symbol | Package | Notes |
|---|---|---|
| `Dio` | `package:dio/dio.dart` | HTTP client |
| `BaseOptions` | `package:dio/dio.dart` | Constructor config |
| `Options` | `package:dio/dio.dart` | Per-request options |
| `Response` | `package:dio/dio.dart` | Dio response type |
| `@riverpod` | `package:riverpod_annotation/riverpod_annotation.dart` | Code-gen annotation |
| `AsyncValue.guard` | `package:flutter_riverpod/flutter_riverpod.dart` | Safe async wrapper |
| `String.fromEnvironment` | Dart core | Environment variable access |

## AI SDK Preference

For calls to Claude / Anthropic API, prefer `package:anthropic_sdk_dart` over raw Dio if the package is already in `pubspec.yaml`. Do not add new dependencies without confirming with the user.
