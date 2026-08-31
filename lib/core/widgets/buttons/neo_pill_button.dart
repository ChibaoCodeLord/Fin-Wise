import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';

enum NeoPillVariant { primary, secondary, outline, danger }

class NeoPillButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final NeoPillVariant variant;
  final double? height;
  final double? width;

  const NeoPillButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.variant = NeoPillVariant.primary,
    this.height = 54,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Border? border;

    switch (variant) {
      case NeoPillVariant.primary:
        bgColor = AppColors.inkCta;
        textColor = AppColors.surfaceWhite;
        break;
      case NeoPillVariant.secondary:
        bgColor = AppColors.surfaceMuted;
        textColor = AppColors.textPrimary;
        break;
      case NeoPillVariant.outline:
        bgColor = Colors.transparent;
        textColor = AppColors.textPrimary;
        border = Border.all(color: AppColors.borderHairline, width: 1.5);
        break;
      case NeoPillVariant.danger:
        bgColor = AppColors.dangerLight;
        textColor = AppColors.dangerRed;
        break;
    }

    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: Material(
        color: bgColor,
        borderRadius: AppStyles.borderPill,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: AppStyles.borderPill,
          splashColor: Colors.white.withValues(alpha: 0.15),
          highlightColor: Colors.white.withValues(alpha: 0.08),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppStyles.borderPill,
              border: border,
              boxShadow: variant == NeoPillVariant.primary && onPressed != null
                  ? AppStyles.shadowButton
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(textColor),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: textColor, size: 20),
                        const SizedBox(width: 10),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
