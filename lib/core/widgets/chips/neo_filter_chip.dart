import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';

class NeoFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final dynamic icon;

  const NeoFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isSelected ? AppColors.surfaceWhite : AppColors.textSecondary;

    Widget? iconWidget;
    if (icon != null) {
      if (icon is IconData) {
        iconWidget = Icon(icon as IconData, size: 15, color: iconColor);
      } else {
        iconWidget = HugeIcon(icon: icon, size: 15, color: iconColor);
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.inkCta : AppColors.surfaceMuted,
          borderRadius: AppStyles.borderPill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconWidget != null) ...[
              iconWidget,
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.surfaceWhite : AppColors.textSecondary,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
