import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class NeoRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final Widget? trailing;
  final ValueChanged<T> onChanged;

  const NeoRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.trailing,
    required this.onChanged,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceWhite : AppColors.surfaceMutedLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.inkCta : AppColors.borderHairline,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 4),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            if (leadingIcon != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.iconTintBg : AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  leadingIcon,
                  size: 20,
                  color: isSelected ? AppColors.iconTintFg : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 14),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.inkCta : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.inkCta : AppColors.borderHairline,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: AppColors.surfaceWhite,
                      )
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
