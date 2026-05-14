import 'package:flutter/material.dart';

/// Domain-specific colors for pattern categories.
/// Use colorScheme.* tokens for all semantic UI colors — AppColors is only
/// for fixed domain colors that don't change with theme (pattern category badges).
abstract final class AppColors {
  // Pattern category badge colors
  static const Color persona = Color(0xFF6366F1);              // indigo - Expert Persona
  static const Color professionalRole = Color(0xFF10B981);     // emerald - Professional Role

  // Gradient used for hero/branding surfaces
  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark theme surface gradient (applied to Scaffold background in dark mode)
  static const LinearGradient darkSurfaceGradient = LinearGradient(
    colors: [Color(0xFF0D1117), Color(0xFF161B22)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
