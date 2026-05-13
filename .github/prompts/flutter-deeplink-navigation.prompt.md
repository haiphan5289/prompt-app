---
agent: Flutter Deeplink Navigation Specialist
always: Follow GoRouter patterns, proper parameter parsing, navigation safety
description: "Implement deeplink navigation for Flutter app with GoRouter, parameter extraction, and navigation guards."
---

## Prompt Activation

**You are an expert Flutter developer following the Deeplink Navigation Pattern.**

# Flutter Deeplink Navigation - Generic Deeplink Handling

You are an expert Flutter developer specializing in **deeplink navigation** and **URL routing** within the **Prompt App**.

We are going to **implement deeplink handling** with **GoRouter**, proper **parameter extraction**, and **navigation guards** following Flutter best practices.

## Context Understanding

The **Deeplink Navigation Pattern** handles:
- Universal Links / App Links configuration
- Deep URL parsing and route matching
- Parameter extraction from URLs
- Navigation guards (authentication, permissions)
- Fallback handling for unknown routes
- Testing deeplink flows

## Required Information

When implementing deeplink support, you need:

1. **Deeplink URL**: `promptapp://feature/{path}` or `https://promptapp.com/{path}`
2. **Feature Name**: The target feature (e.g., pattern, history, favorites)
3. **Target Screen**: The screen to navigate to
4. **Parameters**: Query params or path params
5. **Guards**: Auth required? Permission checks?

## Deeplink Implementation Workflow

### Step 1: Configure Platform Support

#### **Android (`android/app/src/main/AndroidManifest.xml`)**
```xml
<manifest>
  <application>
    <activity android:name=".MainActivity">
      <!-- Deep Links -->
      <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data
          android:scheme="promptapp"
          android:host="feature" />
      </intent-filter>
      
      <!-- App Links (HTTPS) -->
      <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data
          android:scheme="https"
          android:host="promptapp.com" />
      </intent-filter>
    </activity>
  </application>
</manifest>
```

#### **iOS (`ios/Runner/Info.plist`)**
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLName</key>
    <string>com.promptapp</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>promptapp</string>
    </array>
  </dict>
</array>

<!-- Associated Domains for Universal Links -->
<key>com.apple.developer.associated-domains</key>
<array>
  <string>applinks:promptapp.com</string>
</array>
```

### Step 2: Add GoRouter with Deeplink Support

```dart
// lib/core/navigation/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App router with deeplink support.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    
    // Deeplink handling
    redirect: (context, state) {
      // Add authentication guards here
      // Example: Check if user is logged in
      return null; // null = allow navigation
    },
    
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      
      // Pattern detail deeplink
      // promptapp://pattern/{patternId}
      GoRoute(
        path: '/pattern/:patternId',
        builder: (context, state) {
          final patternId = state.pathParameters['patternId']!;
          return PatternDetailScreen(patternId: patternId);
        },
      ),
      
      // History with filters
      // promptapp://history?filter=recent&limit=20
      GoRoute(
        path: '/history',
        builder: (context, state) {
          final filter = state.uri.queryParameters['filter'];
          final limit = int.tryParse(
            state.uri.queryParameters['limit'] ?? '50',
          );
          return HistoryScreen(
            filter: filter,
            limit: limit,
          );
        },
      ),
      
      // Transformer with pre-filled pattern
      // promptapp://transform?pattern=chain-of-thought
      GoRoute(
        path: '/transform',
        builder: (context, state) {
          final patternName = state.uri.queryParameters['pattern'];
          return TransformerScreen(
            initialPattern: patternName,
          );
        },
      ),
      
      // Fallback for unknown routes
      GoRoute(
        path: '/404',
        builder: (context, state) => const NotFoundScreen(),
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
```

### Step 3: Handle Incoming Deeplinks

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uni_links/uni_links.dart';

import 'core/navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
  }

  /// Handle deeplinks while app is running.
  void _handleIncomingLinks() {
    uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _navigateFromDeeplink(uri);
      }
    });
  }

  /// Handle deeplink that launched the app.
  Future<void> _handleInitialUri() async {
    try {
      final uri = await getInitialUri();
      if (uri != null) {
        _navigateFromDeeplink(uri);
      }
    } catch (e) {
      debugPrint('Failed to get initial URI: $e');
    }
  }

  /// Navigate based on deeplink URI.
  void _navigateFromDeeplink(Uri uri) {
    final router = ref.read(appRouterProvider);
    
    // Parse URI and extract route
    final path = uri.path;
    final queryParams = uri.queryParameters;
    
    // Build route with query params
    final route = queryParams.isEmpty
        ? path
        : '$path?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}';
    
    // Navigate
    router.push(route);
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    
    return MaterialApp.router(
      title: 'Prompt App',
      routerConfig: router,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
```

### Step 4: Add Navigation Guards

```dart
// lib/core/navigation/navigation_guards.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Check if user is authenticated.
bool isAuthenticated() {
  // TODO: Check actual auth state
  return true;
}

/// Redirect to login if not authenticated.
String? authGuard(BuildContext context, GoRouterState state) {
  if (!isAuthenticated()) {
    return '/login?redirect=${state.uri}';
  }
  return null;
}

/// Example: Protected route with auth guard
GoRoute(
  path: '/favorites',
  redirect: authGuard,
  builder: (context, state) => const FavoritesScreen(),
)
```

### Step 5: Create Deeplink Utilities

```dart
// lib/core/navigation/deeplink_utils.dart

/// Deeplink utility functions.
class DeeplinkUtils {
  /// Opens a pattern detail screen via deeplink.
  static String patternDetailDeeplink(String patternId) {
    return '/pattern/$patternId';
  }

  /// Opens history with filters via deeplink.
  static String historyDeeplink({
    String? filter,
    int? limit,
  }) {
    final params = <String, String>{};
    if (filter != null) params['filter'] = filter;
    if (limit != null) params['limit'] = limit.toString();
    
    final query = params.isEmpty
        ? ''
        : '?${params.entries.map((e) => '${e.key}=${e.value}').join('&')}';
    
    return '/history$query';
  }

  /// Opens transformer with pre-selected pattern.
  static String transformerDeeplink({String? pattern}) {
    return pattern != null
        ? '/transform?pattern=$pattern'
        : '/transform';
  }

  /// Parses pattern ID from URI.
  static String? parsePatternId(Uri uri) {
    if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'pattern') {
      return uri.pathSegments[1];
    }
    return null;
  }
}
```

## Testing Deeplinks

### **Test on Android (ADB)**
```bash
# Test deep link
adb shell am start -W -a android.intent.action.VIEW \
  -d "promptapp://pattern/chain-of-thought" \
  com.example.promptapp

# Test app link
adb shell am start -W -a android.intent.action.VIEW \
  -d "https://promptapp.com/history?filter=recent" \
  com.example.promptapp
```

### **Test on iOS (Simulator)**
```bash
# Test deep link
xcrun simctl openurl booted "promptapp://pattern/chain-of-thought"

# Test universal link
xcrun simctl openurl booted "https://promptapp.com/history?filter=recent"
```

### **Unit Tests**
```dart
void main() {
  group('DeeplinkUtils', () {
    test('patternDetailDeeplink generates correct path', () {
      final deeplink = DeeplinkUtils.patternDetailDeeplink('chain-of-thought');
      expect(deeplink, '/pattern/chain-of-thought');
    });

    test('historyDeeplink with filters generates correct query', () {
      final deeplink = DeeplinkUtils.historyDeeplink(
        filter: 'recent',
        limit: 20,
      );
      expect(deeplink, '/history?filter=recent&limit=20');
    });

    test('parsePatternId extracts ID from URI', () {
      final uri = Uri.parse('promptapp://pattern/example-id');
      final patternId = DeeplinkUtils.parsePatternId(uri);
      expect(patternId, 'example-id');
    });
  });
}
```

---

## Best Practices

1. ✅ **Always validate parameters** from deeplinks
2. ✅ **Use navigation guards** for protected routes
3. ✅ **Provide fallback** for unknown routes
4. ✅ **Log deeplink events** for analytics
5. ✅ **Test on both platforms** (iOS and Android)
6. ✅ **Handle initial URI** (app launched from link)
7. ✅ **Handle runtime URIs** (app already running)
8. ✅ **Use GoRouter's redirect** for auth/permission checks

---

**Use this pattern when:**
- Adding deeplink support to Flutter app
- Need to navigate from external sources (web, email, push notifications)
- Want to share specific app content via URLs
- Building marketing campaigns with app links
- Supporting universal links (iOS) or app links (Android)
