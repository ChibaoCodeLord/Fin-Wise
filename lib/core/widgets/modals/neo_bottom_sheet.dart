import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';

class NeoBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomCta;
  final VoidCallback? onClose;
  final double? maxHeightFactor;

  const NeoBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.bottomCta,
    this.onClose,
    this.maxHeightFactor = 0.88,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    Widget? bottomCta,
    bool isScrollControlled = true,
    double maxHeightFactor = 0.88,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.scrimDim,
      builder: (ctx) => NeoBottomSheet(
        title: title,
        bottomCta: bottomCta,
        maxHeightFactor: maxHeightFactor,
        onClose: () => Navigator.of(ctx).pop(),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * (maxHeightFactor ?? 0.88),
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: AppStyles.borderSheet,
        boxShadow: AppStyles.shadowModal,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle / Notch indicator
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderHairline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header: Title & Close Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onClose ?? () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceMuted,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.borderHairline),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: child,
              ),
            ),

            // Bottom CTA
            if (bottomCta != null)
              Container(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                decoration: const BoxDecoration(
                  color: AppColors.surfaceWhite,
                  border: Border(top: BorderSide(color: AppColors.borderHairline)),
                ),
                child: bottomCta!,
              ),
          ],
        ),
      ),
    );
  }
}
