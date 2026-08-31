import 'package:flutter/material.dart';

/// FinWise Design Tokens based on FinWise_Design_Style_Plan.md
class AppColors {
  // Hero Gradient
  static const Color gradientTop = Color(0xFF1D4ED8); // Vibrant Royal Blue
  static const Color gradientMid = Color(0xFF3B82F6); // Cobalt Blue
  static const Color gradientBottom = Color(0xFF60A5FA); // Sky Blue
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientTop, gradientMid, gradientBottom],
  );

  static const LinearGradient royalBlueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1E40AF), // Deep Blue Top
      Color(0xFF2563EB), // Royal Blue
      Color(0xFF3B82F6), // Vibrant Blue
      Color(0xFF60A5FA), // Light Blue
      Color(0xFFE0EEFE), // Soft transition to white
    ],
    stops: [0.0, 0.25, 0.55, 0.8, 1.0],
  );

  static const LinearGradient cardAccentGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF3B6FE0), Color(0xFF1E3A8A)],
  );

  // Surfaces & Backgrounds
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF3F4F6);
  static const Color surfaceMutedLight = Color(0xFFF9FAFB);
  static const Color backgroundLight = Color(0xFFF8F9FB);

  // CTA & Action Buttons
  static const Color inkCta = Color(0xFF0B0E17); // Signature pill button black
  static const Color inkCtaSecondary = Color(0xFF1F2937);

  // Icon Chip Tints
  static const Color iconTintBg = Color(0xFFEAF2FE); // Soft blue chip bg
  static const Color iconTintFg = Color(0xFF3B6FE0); // Blue chip icon

  // Category Soft Tints
  static const Color tintFoodBg = Color(0xFFFEF2F2);
  static const Color tintFoodFg = Color(0xFFEF4444);

  static const Color tintShoppingBg = Color(0xFFFDF4FF);
  static const Color tintShoppingFg = Color(0xFFA855F7);

  static const Color tintTransportBg = Color(0xFFEFF6FF);
  static const Color tintTransportFg = Color(0xFF3B82F6);

  static const Color tintBillsBg = Color(0xFFFEFCE8);
  static const Color tintBillsFg = Color(0xFFEAB308);

  static const Color tintHealthBg = Color(0xFFF0FDF4);
  static const Color tintHealthFg = Color(0xFF10B981);

  static const Color tintEntertainmentBg = Color(0xFFFFF1F2);
  static const Color tintEntertainmentFg = Color(0xFFF43F5E);

  static const Color tintOtherBg = Color(0xFFF3F4F6);
  static const Color tintOtherFg = Color(0xFF6B7280);

  // Typography Colors
  static const Color textPrimary = Color(0xFF0B0E17); // Black
  static const Color textOnGradient = Color(0xFFFFFFFF); // White
  static const Color textSecondary = Color(0xFF6B7280); // Gray
  static const Color textTertiary = Color(0xFF9CA3AF); // Light gray

  // Borders & Dividers
  static const Color borderHairline = Color(0xFFE5E7EB);
  static const Color borderStrong = Color(0xFF0B0E17);

  // Status & Alerts
  static const Color successGreen = Color(0xFF1B8A62);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color dangerRed = Color(0xFFDC2626);
  static const Color dangerLight = Color(0xFFFEE2E2);

  // Overlay
  static const Color scrimDim = Color(0x66000000);
}
