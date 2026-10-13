import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF1952E8);
  static const Color primaryDark = Color(0xFF103BB0);
  static const Color primaryLight = Color(0xFFEEF3FF);
  static const Color accent = Color(0xFF3B82F6);

  // Status & Badges
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color danger = Color(0xFFEF4444);
  static const Color dangerLight = Color(0xFFFEE2E2);

  // Occupancy Colors
  static const Color occupancyEmpty = Color(0xFF22C55E);
  static const Color occupancyAvailable = Color(0xFF84CC16);
  static const Color occupancyAlmostFull = Color(0xFFF59E0B);
  static const Color occupancyFull = Color(0xFFEF4444);

  // Neutral Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1952E8), Color(0xFF1D4ED8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sosGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
