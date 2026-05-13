---
agent: Flutter API Service Generator
always: Generate API service layer with Dio, error handling, and type-safe responses
description: "Auto-generate Flutter service classes for API integration with proper error handling, request/response models, and Dio configuration."
---

## Prompt Activation

**You are an expert Flutter API service specialist.**

# Flutter Service Generation - API Integration Layer

You are an expert Flutter developer specializing in **API service layer generation** within the **Prompt App**.

We are going to **generate production-ready API services** with **Dio**, proper **error handling**, and **type-safe responses** following **Clean Architecture** patterns.

## Context Understanding

The **Service Generation Pattern** handles:
- API service classes with Dio HTTP client
- Request/response model mapping
- Error handling and transformation
- Interceptors for auth, logging, retry
- Type-safe method signatures
- Base URL and endpoint management

## Service Structure

```
lib/features/{feature}/data/
├── services/
│   └── {name}_service.dart          ← API service interface + impl
├── models/
│   ├── {name}_request_model.dart    ← Request DTOs
│   └── {name}_response_model.dart   ← Response DTOs
└── providers/
    └── {feature}_providers.dart     ← Dio + Service providers
```

---

## Service Templates

### 1. Basic API Service

```dart
// lib/features/{feature}/data/services/{name}_service.dart
import 'package:dio/dio.dart';

import '../models/{name}_request_model.dart';
import '../models/{name}_response_model.dart';

/// API service for [{feature}] operations.
/// 
/// Handles all HTTP requests related to [{description}].
class {Name}Service {
  const {Name}Service(this._dio);

  final Dio _dio;

  /// Fetches [{resource}] from the API.
  /// 
  /// Returns [{Response}Model] on success.
  /// Throws [DioException] if request fails.
  Future<{Response}Model> fetch{Resource}({
    required {RequestParam} {param},
  }) async {
    try {
      final response = await _dio.get(
        '/api/v1/{endpoint}',
        queryParameters: {
          'param': {param},
        },
      );

      return {Response}Model.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Creates a new [{resource}].
  Future<{Response}Model> create{Resource}({
    required {Request}Model request,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/{endpoint}',
        data: request.toJson(),
      );

      return {Response}Model.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Updates an existing [{resource}].
  Future<{Response}Model> update{Resource}({
    required String id,
    required {Request}Model request,
  }) async {
    try {
      final response = await _dio.put(
        '/api/v1/{endpoint}/$id',
        data: request.toJson(),
      );

      return {Response}Model.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Deletes a [{resource}].
  Future<void> delete{Resource}(String id) async {
    try {
      await _dio.delete('/api/v1/{endpoint}/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Gets all [{resource}s].
  Future<List<{Response}Model>> getAll{Resource}s() async {
    try {
      final response = await _dio.get('/api/v1/{endpoint}');

      final list = response.data as List;
      return list
          .map((json) => {Response}Model.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handles Dio errors and converts to custom exceptions.
  Exception _handleError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data?['message'] ?? 'Unknown error';

      switch (statusCode) {
        case 400:
          return BadRequestException(message);
        case 401:
          return UnauthorizedException(message);
        case 403:
          return ForbiddenException(message);
        case 404:
          return NotFoundException(message);
        case 500:
          return ServerException(message);
        default:
          return ApiException('HTTP $statusCode: $message');
      }
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return TimeoutException('Connection timeout');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return TimeoutException('Receive timeout');
    } else if (error.type == DioExceptionType.connectionError) {
      return NetworkException('No internet connection');
    } else {
      return ApiException('Network error: ${error.message}');
    }
  }
}

/// Custom API exceptions
class ApiException implements Exception {
  const ApiException(this.message);
  final String message;

  @override
  String toString() => 'ApiException: $message';
}

class BadRequestException extends ApiException {
  const BadRequestException(String message) : super(message);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException(String message) : super(message);
}

class ForbiddenException extends ApiException {
  const ForbiddenException(String message) : super(message);
}

class NotFoundException extends ApiException {
  const NotFoundException(String message) : super(message);
}

class ServerException extends ApiException {
  const ServerException(String message) : super(message);
}

class TimeoutException extends ApiException {
  const TimeoutException(String message) : super(message);
}

class NetworkException extends ApiException {
  const NetworkException(String message) : super(message);
}
```

---

### 2. Request Model

```dart
// lib/features/{feature}/data/models/{name}_request_model.dart
import 'package:json_annotation/json_annotation.dart';

part '{name}_request_model.g.dart';

/// Request model for [{operation}].
@JsonSerializable()
class {Name}RequestModel {
  const {Name}RequestModel({
    required this.field1,
    this.field2,
  });

  @JsonKey(name: 'field_1')
  final String field1;

  @JsonKey(name: 'field_2')
  final int? field2;

  Map<String, dynamic> toJson() => _${Name}RequestModelToJson(this);

  factory {Name}RequestModel.fromJson(Map<String, dynamic> json) =>
      _${Name}RequestModelFromJson(json);
}
```

---

### 3. Response Model

```dart
// lib/features/{feature}/data/models/{name}_response_model.dart
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/{entity}.dart';

part '{name}_response_model.g.dart';

/// Response model for [{operation}].
@JsonSerializable()
class {Name}ResponseModel {
  const {Name}ResponseModel({
    required this.id,
    required this.field1,
    this.field2,
  });

  final String id;

  @JsonKey(name: 'field_1')
  final String field1;

  @JsonKey(name: 'field_2')
  final int? field2;

  factory {Name}ResponseModel.fromJson(Map<String, dynamic> json) =>
      _${Name}ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _${Name}ResponseModelToJson(this);

  /// Converts to domain entity.
  {Entity} toEntity() {
    return {Entity}(
      id: id,
      field1: field1,
      field2: field2,
    );
  }
}
```

---

### 4. Dio Configuration & Providers

```dart
// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Configures and provides Dio instance for API calls.
class DioClient {
  static Dio create({
    required String baseUrl,
    String? apiKey,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (apiKey != null) 'Authorization': 'Bearer $apiKey',
        },
      ),
    );

    // Add interceptors
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }

    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(RetryInterceptor(dio: dio));

    return dio;
  }
}

/// Interceptor for adding auth tokens.
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // TODO: Add auth token from secure storage
    // final token = await getAuthToken();
    // options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}

/// Interceptor for retrying failed requests.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      final attempt = err.requestOptions.extra['retryCount'] as int? ?? 0;

      if (attempt < maxRetries) {
        await Future.delayed(retryDelay * (attempt + 1));

        err.requestOptions.extra['retryCount'] = attempt + 1;

        try {
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }
    }

    handler.next(err);
  }
}
```

---

### 5. Provider Registration

```dart
// lib/features/{feature}/data/providers/{feature}_providers.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../services/{name}_service.dart';

/// Provides configured Dio instance.
final dioProvider = Provider<Dio>((ref) {
  return DioClient.create(
    baseUrl: const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.example.com',
    ),
    apiKey: const String.fromEnvironment('API_KEY'),
  );
});

/// Provides {Name}Service.
final {name}ServiceProvider = Provider<{Name}Service>((ref) {
  return {Name}Service(ref.watch(dioProvider));
});
```

---

## Example: AI Service for Prompt App

```dart
// lib/core/network/ai_service.dart
import 'package:dio/dio.dart';

class AIService {
  const AIService(this._dio);

  final Dio _dio;

  /// Sends a prompt to Gemini API and gets the response.
  Future<String> chat(String prompt) async {
    try {
      final response = await _dio.post(
        '/v1beta/models/gemini-1.5-flash:generateContent',
        data: {
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        },
      );

      final candidates = response.data['candidates'] as List;
      final content = candidates.first['content'];
      final parts = content['parts'] as List;
      final text = parts.first['text'] as String;

      return text;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid API key');
      } else if (e.response?.statusCode == 429) {
        throw Exception('Rate limit exceeded');
      } else {
        throw Exception('Failed to get AI response: ${e.message}');
      }
    }
  }
}
```

---

## Code Generation

After creating models, run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates:
- `{name}_request_model.g.dart`
- `{name}_response_model.g.dart`

---

## Best Practices

1. ✅ **Use json_serializable** for model serialization
2. ✅ **Handle all DioException types** properly
3. ✅ **Add retry logic** for transient failures
4. ✅ **Log requests/responses** in debug mode
5. ✅ **Use const constructors** where possible
6. ✅ **Add timeouts** (connect + receive)
7. ✅ **Centralize base URL** in environment variables
8. ✅ **Create custom exception types** for clarity

---

**Use this pattern when:**
- Integrating with REST APIs
- Need type-safe API calls
- Want centralized error handling
- Building features that call external services
- Need retry and timeout logic
