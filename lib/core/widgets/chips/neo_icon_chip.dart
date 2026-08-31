import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';

class NeoIconChip extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double iconSize;
  final double borderRadius;

  const NeoIconChip({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.size = 44.0,
    this.iconSize = 22.0,
    this.borderRadius = AppStyles.radiusIconChip,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.iconTintBg;
    final fg = iconColor ?? AppColors.iconTintFg;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Icon(
          icon,
          color: fg,
          size: iconSize,
        ),
      ),
    );
  }
}
