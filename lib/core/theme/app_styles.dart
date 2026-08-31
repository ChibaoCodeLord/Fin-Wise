import 'package:flutter/material.dart';

/// Standard Radii, Shadows and Paddings for FinWise Neo-Bank design
class AppStyles {
  // Border Radii
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 14.0;
  static const double radiusIconChip = 12.0; // 12px for icon chips
  static const double radiusCard = 24.0; // 24-28px for cards
  static const double radiusSheet = 28.0; // 28px for modal bottom sheets
  static const double radiusPill = 9999.0; // Full pill radius

  static const BorderRadius borderPill = BorderRadius.all(Radius.circular(radiusPill));
  static const BorderRadius borderCard = BorderRadius.all(Radius.circular(radiusCard));
  static const BorderRadius borderSheet = BorderRadius.only(
    topLeft: Radius.circular(radiusSheet),
    topRight: Radius.circular(radiusSheet),
  );
  static const BorderRadius borderIconChip = BorderRadius.all(Radius.circular(radiusIconChip));

  // Box Shadows
  static const List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: Color(0x14000000), // rgba(0,0,0,0.08)
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowModal = [
    BoxShadow(
      color: Color(0x1F000000), // rgba(0,0,0,0.12)
      offset: Offset(0, 20),
      blurRadius: 40,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowButton = [
    BoxShadow(
      color: Color(0x280B0E17),
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  // Paddings
  static const EdgeInsets paddingPage = EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
  static const EdgeInsets paddingCard = EdgeInsets.all(20.0);
  static const EdgeInsets paddingSheet = EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0);
}
