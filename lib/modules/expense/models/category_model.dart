import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  static const List<CategoryModel> defaultCategories = [
    CategoryModel(
      id: 'food',
      name: 'Ăn uống',
      icon: Icons.restaurant_rounded,
      backgroundColor: AppColors.tintFoodBg,
      foregroundColor: AppColors.tintFoodFg,
    ),
    CategoryModel(
      id: 'groceries',
      name: 'Đi chợ & Siêu thị',
      icon: Icons.local_grocery_store_outlined,
      backgroundColor: Color(0xFFECFDF5),
      foregroundColor: Color(0xFF059669),
    ),
    CategoryModel(
      id: 'shopping',
      name: 'Mua sắm',
      icon: Icons.shopping_bag_outlined,
      backgroundColor: AppColors.tintShoppingBg,
      foregroundColor: AppColors.tintShoppingFg,
    ),
    CategoryModel(
      id: 'transport',
      name: 'Đi lại & Xăng xe',
      icon: Icons.directions_car_filled_outlined,
      backgroundColor: AppColors.tintTransportBg,
      foregroundColor: AppColors.tintTransportFg,
    ),
    CategoryModel(
      id: 'bills',
      name: 'Hoá đơn & Tiện ích',
      icon: Icons.receipt_outlined,
      backgroundColor: AppColors.tintBillsBg,
      foregroundColor: AppColors.tintBillsFg,
    ),
    CategoryModel(
      id: 'health',
      name: 'Sức khoẻ & Mỹ phẩm',
      icon: Icons.spa_outlined,
      backgroundColor: AppColors.tintHealthBg,
      foregroundColor: AppColors.tintHealthFg,
    ),
    CategoryModel(
      id: 'entertainment',
      name: 'Giải trí & Phim ảnh',
      icon: Icons.movie_filter_outlined,
      backgroundColor: AppColors.tintEntertainmentBg,
      foregroundColor: AppColors.tintEntertainmentFg,
    ),
    CategoryModel(
      id: 'other',
      name: 'Chi tiêu khác',
      icon: Icons.category_outlined,
      backgroundColor: AppColors.tintOtherBg,
      foregroundColor: AppColors.tintOtherFg,
    ),
  ];

  static CategoryModel getById(String id) {
    return defaultCategories.firstWhere(
      (c) => c.id == id,
      orElse: () => defaultCategories.last,
    );
  }
}
