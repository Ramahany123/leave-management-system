import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primaryBlue = Color(
    0xff1A365D,
  ); // Trustworthy University Blue
  static const Color backgroundLight = Color(
    0xffF8FAFC,
  ); // Light cool gray to reduce eye strain

  // Base Colors
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Color(
    0xff0F172A,
  ); // Softer, corporate slate-black for text
  static const Color greyColor = Color(
    0xff64748B,
  ); // Cool slate grey for secondary text

  // Semantic / Status Colors (Crucial for a Leave System)
  static const Color successGreen = Color(
    0xff10B981,
  ); // Soft green for "Approved"
  static const Color errorRed = Color(
    0xffEF4444,
  ); // Soft red for "Rejected" or Destructive actions
  static const Color pendingYellow = Color(
    0xffF59E0B,
  ); // Warm yellow for "Pending"
}
