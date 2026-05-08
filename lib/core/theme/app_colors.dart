import 'package:flutter/material.dart';

/// Domain-specific colors for pattern categories.
/// Use colorScheme.* tokens for all semantic UI colors — AppColors is only
/// for fixed domain colors that don't change with theme (pattern category badges).
abstract final class AppColors {
  // Pattern category badge colors
  static const Color roleBased = Color(0xFF6366F1);     // indigo
  static const Color chainOfThought = Color(0xFF0EA5E9); // sky blue
  static const Color fewShot = Color(0xFFF59E0B);        // amber
  static const Color risen = Color(0xFF10B981);           // emerald
  static const Color cato = Color(0xFFEC4899);            // pink
  static const Color custom = Color(0xFF64748B);          // slate

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
