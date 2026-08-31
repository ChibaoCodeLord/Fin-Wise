import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../../core/widgets/chips/neo_icon_chip.dart';

class NeoTransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final double amount;
  final IconData icon;
  final Color? iconBgColor;
  final Color? iconFgColor;
  final Color? iconBg;
  final Color? iconFg;
  final bool hasReceipt;
  final String? jarName;
  final VoidCallback? onTap;

  const NeoTransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    this.iconBgColor,
    this.iconFgColor,
    this.iconBg,
    this.iconFg,
    this.hasReceipt = false,
    this.jarName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Icon Chip
            NeoIconChip(
              icon: icon,
              backgroundColor: iconBg ?? iconBgColor,
              iconColor: iconFg ?? iconFgColor,
            ),
            const SizedBox(width: 14),

            // Merchant / Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasReceipt) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.iconTintBg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.receipt_long,
                                size: 11,
                                color: AppColors.iconTintFg,
                              ),
                              SizedBox(width: 2),
                              Text(
                                'OCR',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.iconTintFg,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (jarName != null && jarName!.isNotEmpty) ...[
                        const Text(
                          ' • ',
                          style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
                        ),
                        Text(
                          jarName!,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Amount (Right aligned)
            Text(
              '-${CurrencyFormatter.formatVND(amount)}',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
