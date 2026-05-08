import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: PromptApp()));
}

class PromptApp extends StatelessWidget {
  const PromptApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prompt App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(child: Text('Prompt App')),
      ),
    );
  }
}
