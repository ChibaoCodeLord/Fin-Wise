import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../buttons/neo_pill_button.dart';

class NeoSuccessModal extends StatelessWidget {
  final String title;
  final String message;
  final Widget? detailsWidget;
  final String buttonText;
  final VoidCallback onAction;

  const NeoSuccessModal({
    super.key,
    required this.title,
    required this.message,
    this.detailsWidget,
    this.buttonText = 'Về trang chủ',
    required this.onAction,
  });

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    Widget? detailsWidget,
    String buttonText = 'Về trang chủ',
    VoidCallback? onAction,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.scrimDim,
      builder: (ctx) => NeoSuccessModal(
        title: title,
        message: message,
        detailsWidget: detailsWidget,
        buttonText: buttonText,
        onAction: () {
          Navigator.of(ctx).pop();
          if (onAction != null) {
            onAction();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: AppStyles.borderSheet,
        boxShadow: AppStyles.shadowModal,
      ),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Notch
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderHairline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 28),

            // Iconic White Tick in Black Circle
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.inkCta,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x280B0E17),
                    offset: Offset(0, 8),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.surfaceWhite,
                size: 38,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),

            // Description / Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),

            if (detailsWidget != null) ...[
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: detailsWidget,
              ),
            ],

            const SizedBox(height: 28),

            // CTA Button
            NeoPillButton(
              text: buttonText,
              onPressed: onAction,
            ),
          ],
        ),
      ),
    );
  }
}
