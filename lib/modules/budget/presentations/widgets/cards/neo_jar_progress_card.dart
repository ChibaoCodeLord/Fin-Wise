import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../../core/widgets/chips/neo_icon_chip.dart';

class NeoJarProgressCard extends StatelessWidget {
  final String name;
  final double budget;
  final double spent;
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final int transactionCount;
  final VoidCallback? onTap;

  const NeoJarProgressCard({
    super.key,
    required this.name,
    required this.budget,
    required this.spent,
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    this.transactionCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = (budget - spent);
    final ratio = budget > 0 ? (spent / budget) : 0.0;
    final percent = (ratio * 100).toInt();

    Color statusColor;
    Color statusBg;
    String statusText;

    if (ratio >= 1.0) {
      statusColor = AppColors.dangerRed;
      statusBg = AppColors.dangerLight;
      statusText = ratio > 1.0 ? 'Vượt ngân sách' : 'Hết ngân sách';
    } else if (ratio >= 0.8) {
      statusColor = AppColors.warningAmber;
      statusBg = AppColors.warningLight;
      statusText = 'Sắp hết ($percent%)';
    } else {
      statusColor = AppColors.successGreen;
      statusBg = AppColors.successLight;
      statusText = '$percent%';
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ratio >= 1.0
              ? AppColors.dangerRed.withValues(alpha: 0.4)
              : (ratio >= 0.8 ? AppColors.warningAmber.withValues(alpha: 0.4) : AppColors.borderHairline),
          width: ratio >= 0.8 ? 1.5 : 1.0,
        ),
        boxShadow: AppStyles.shadowSoft,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    NeoIconChip(
                      icon: icon,
                      backgroundColor: iconBg,
                      iconColor: iconFg,
                      size: 42,
                      iconSize: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (transactionCount > 0)
                            Text(
                              '$transactionCount giao dịch',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: AppStyles.borderPill,
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      CurrencyFormatter.formatVND(spent),
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      'Mục tiêu: ${CurrencyFormatter.formatVND(budget)}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: [
                      Container(
                        height: 6,
                        width: double.infinity,
                        color: AppColors.surfaceMuted,
                      ),
                      FractionallySizedBox(
                        widthFactor: (ratio > 1.0 ? 1.0 : ratio.clamp(0.0, 1.0)),
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      remaining >= 0
                          ? 'Còn lại: ${CurrencyFormatter.formatVND(remaining)}'
                          : 'Vượt: ${CurrencyFormatter.formatVND(remaining.abs())}',
                      style: TextStyle(
                        color: remaining >= 0 ? AppColors.textSecondary : AppColors.dangerRed,
                        fontSize: 12,
                        fontWeight: remaining >= 0 ? FontWeight.w400 : FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
