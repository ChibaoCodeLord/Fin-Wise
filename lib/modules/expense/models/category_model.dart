import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/theme/app_colors.dart';

class CategoryModel {
  final String id;
  final String name;
  final dynamic icon;
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
      icon: HugeIcons.strokeRoundedRestaurant01,
      backgroundColor: AppColors.tintFoodBg,
      foregroundColor: AppColors.tintFoodFg,
    ),
    CategoryModel(
      id: 'groceries',
      name: 'Đi chợ & Siêu thị',
      icon: HugeIcons.strokeRoundedShoppingCart01,
      backgroundColor: Color(0xFFECFDF5),
      foregroundColor: Color(0xFF059669),
    ),
    CategoryModel(
      id: 'shopping',
      name: 'Mua sắm',
      icon: HugeIcons.strokeRoundedShoppingBag01,
      backgroundColor: AppColors.tintShoppingBg,
      foregroundColor: AppColors.tintShoppingFg,
    ),
    CategoryModel(
      id: 'transport',
      name: 'Đi lại & Xăng xe',
      icon: HugeIcons.strokeRoundedCar01,
      backgroundColor: AppColors.tintTransportBg,
      foregroundColor: AppColors.tintTransportFg,
    ),
    CategoryModel(
      id: 'bills',
      name: 'Hoá đơn & Tiện ích',
      icon: HugeIcons.strokeRoundedInvoice01,
      backgroundColor: AppColors.tintBillsBg,
      foregroundColor: AppColors.tintBillsFg,
    ),
    CategoryModel(
      id: 'health',
      name: 'Sức khoẻ & Mỹ phẩm',
      icon: HugeIcons.strokeRoundedHealth,
      backgroundColor: AppColors.tintHealthBg,
      foregroundColor: AppColors.tintHealthFg,
    ),
    CategoryModel(
      id: 'entertainment',
      name: 'Giải trí & Phim ảnh',
      icon: HugeIcons.strokeRoundedGameController01,
      backgroundColor: AppColors.tintEntertainmentBg,
      foregroundColor: AppColors.tintEntertainmentFg,
    ),
    CategoryModel(
      id: 'other',
      name: 'Chi tiêu khác',
      icon: HugeIcons.strokeRoundedGrid,
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
