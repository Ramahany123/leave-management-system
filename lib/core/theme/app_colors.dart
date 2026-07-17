import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Navy Shades
  static const Color navy900 = Color(0xFF1A365D); // Primary University Blue
  static const Color navy700 = Color(0xFF2B4C7E);
  static const Color navy100 = Color(0xFFE2E8F0);

  // Slate Neutrals (Light & Dark mode backgrounds/surfaces)
  static const Color slate900 = Color(0xFF0F172A); // Dark mode background / Primary text
  static const Color slate800 = Color(0xFF1E293B); // Dark mode card surface
  static const Color slate500 = Color(0xFF64748B); // Secondary text / Icons
  static const Color slate200 = Color(0xFFE2E8F0); // Card borders / Dividers
  static const Color slate50  = Color(0xFFF8FAFC); // Light mode screen background
  static const Color white    = Colors.white;

  // Semantic Status Colors (Leave Requests)
  static const Color successGreen = Color(0xFF10B981); // Approved
  static const Color errorRed     = Color(0xFFEF4444); // Rejected / Destructive
  static const Color pendingAmber = Color(0xFFF59E0B); // Pending Manager Action
}
