import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/utils/currency_formatter.dart';

class NeoHeroCard extends StatelessWidget {
  final double totalSpent;
  final double totalBudget;
  final VoidCallback onScanReceipt;
  final VoidCallback onAddExpense;
  final VoidCallback onViewJars;

  const NeoHeroCard({
    super.key,
    required this.totalSpent,
    required this.totalBudget,
    required this.onScanReceipt,
    required this.onAddExpense,
    required this.onViewJars,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = (totalBudget - totalSpent).clamp(0.0, double.infinity);
    final percentage = totalBudget > 0 ? (totalSpent / totalBudget).clamp(0.0, 1.5) : 0.0;
    final percentInt = (percentage * 100).toInt();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: AppStyles.borderCard,
        boxShadow: const [
          BoxShadow(
            color: Color(0x3D10193B),
            offset: Offset(0, 16),
            blurRadius: 36,
            spreadRadius: -4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header: Label & Month Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: AppColors.textOnGradient,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Chi tiêu tháng này',
                    style: TextStyle(
                      color: AppColors.textOnGradient.withValues(alpha: 0.85),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: AppStyles.borderPill,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Đã dùng $percentInt%',
                  style: const TextStyle(
                    color: AppColors.textOnGradient,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Total Spent Big Number
          Text(
            CurrencyFormatter.formatVND(totalSpent),
            style: const TextStyle(
              color: AppColors.textOnGradient,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.8,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),

          // Budget Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                Container(
                  height: 6,
                  width: double.infinity,
                  color: Colors.white.withValues(alpha: 0.18),
                ),
                FractionallySizedBox(
                  widthFactor: (percentage > 1.0 ? 1.0 : percentage),
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: percentage >= 1.0
                          ? AppColors.dangerRed
                          : (percentage >= 0.8 ? AppColors.warningAmber : const Color(0xFF60A5FA)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Budget breakdown row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ngân sách: ${CurrencyFormatter.formatVND(totalBudget)}',
                style: TextStyle(
                  color: AppColors.textOnGradient.withValues(alpha: 0.75),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Còn lại: ${CurrencyFormatter.formatVND(remaining)}',
                style: TextStyle(
                  color: remaining > 0 ? const Color(0xFF93C5FD) : const Color(0xFFFCA5A5),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // Action Buttons: Scan OCR & Add Expense
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Material(
                  color: AppColors.surfaceWhite,
                  borderRadius: AppStyles.borderPill,
                  child: InkWell(
                    onTap: onScanReceipt,
                    borderRadius: AppStyles.borderPill,
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.document_scanner_outlined,
                            color: AppColors.inkCta,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Quét hoá đơn OCR',
                            style: TextStyle(
                              color: AppColors.inkCta,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Material(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: AppStyles.borderPill,
                  child: InkWell(
                    onTap: onAddExpense,
                    borderRadius: AppStyles.borderPill,
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_rounded,
                            color: AppColors.textOnGradient,
                            size: 20,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Thêm chi',
                            style: TextStyle(
                              color: AppColors.textOnGradient,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
