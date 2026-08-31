import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';

class SpendingJarModel {
  final String id;
  final String name;
  final double budget;
  final double spent;
  final JarPeriod period;
  final List<String> linkedCategoryIds;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;

  const SpendingJarModel({
    required this.id,
    required this.name,
    required this.budget,
    this.spent = 0.0,
    this.period = JarPeriod.monthly,
    this.linkedCategoryIds = const [],
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  SpendingJarModel copyWith({
    String? id,
    String? name,
    double? budget,
    double? spent,
    JarPeriod? period,
    List<String>? linkedCategoryIds,
    IconData? icon,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return SpendingJarModel(
      id: id ?? this.id,
      name: name ?? this.name,
      budget: budget ?? this.budget,
      spent: spent ?? this.spent,
      period: period ?? this.period,
      linkedCategoryIds: linkedCategoryIds ?? this.linkedCategoryIds,
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  static List<SpendingJarModel> get sampleJars => [
        const SpendingJarModel(
          id: 'jar_food',
          name: 'Ăn uống hàng ngày',
          budget: 2000000.0,
          spent: 1450000.0,
          period: JarPeriod.monthly,
          linkedCategoryIds: ['food', 'groceries'],
          icon: Icons.fastfood_outlined,
          backgroundColor: AppColors.tintFoodBg,
          foregroundColor: AppColors.tintFoodFg,
        ),
        const SpendingJarModel(
          id: 'jar_shopping',
          name: 'Mua sắm & Quần áo',
          budget: 1500000.0,
          spent: 1250000.0,
          period: JarPeriod.monthly,
          linkedCategoryIds: ['shopping'],
          icon: Icons.shopping_bag_outlined,
          backgroundColor: AppColors.tintShoppingBg,
          foregroundColor: AppColors.tintShoppingFg,
        ),
        const SpendingJarModel(
          id: 'jar_transport',
          name: 'Đi lại & Grab/Xăng',
          budget: 800000.0,
          spent: 420000.0,
          period: JarPeriod.monthly,
          linkedCategoryIds: ['transport'],
          icon: Icons.directions_car_outlined,
          backgroundColor: AppColors.tintTransportBg,
          foregroundColor: AppColors.tintTransportFg,
        ),
        const SpendingJarModel(
          id: 'jar_entertainment',
          name: 'Giải trí & Cafe',
          budget: 500000.0,
          spent: 380000.0,
          period: JarPeriod.monthly,
          linkedCategoryIds: ['entertainment'],
          icon: Icons.sports_esports_outlined,
          backgroundColor: AppColors.tintEntertainmentBg,
          foregroundColor: AppColors.tintEntertainmentFg,
        ),
        const SpendingJarModel(
          id: 'jar_personal',
          name: 'Cá nhân & Chăm sóc',
          budget: 700000.0,
          spent: 250000.0,
          period: JarPeriod.monthly,
          linkedCategoryIds: ['health', 'other'],
          icon: Icons.face_retouching_natural_outlined,
          backgroundColor: AppColors.tintHealthBg,
          foregroundColor: AppColors.tintHealthFg,
        ),
      ];
}
