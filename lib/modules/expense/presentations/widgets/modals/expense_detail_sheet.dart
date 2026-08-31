import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../../core/utils/date_formatter.dart';
import '../../../../../core/widgets/buttons/neo_pill_button.dart';
import '../../../../../core/widgets/chips/neo_icon_chip.dart';
import '../../../../../core/widgets/modals/neo_bottom_sheet.dart';
import '../../../../app/state/app_state_manager.dart';
import '../../../models/expense_model.dart';

class ExpenseDetailSheet extends StatelessWidget {
  final ExpenseModel expense;
  final AppStateManager state;

  const ExpenseDetailSheet({
    super.key,
    required this.expense,
    required this.state,
  });

  static Future<void> show(
    BuildContext context, {
    required ExpenseModel expense,
    required AppStateManager state,
  }) {
    return NeoBottomSheet.show(
      context: context,
      title: 'Chi tiết khoản chi',
      child: ExpenseDetailSheet(expense: expense, state: state),
    );
  }

  @override
  Widget build(BuildContext context) {
    final category = state.getCategoryById(expense.categoryId);
    final jar = state.getJarById(expense.jarId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surfaceMutedLight,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderHairline),
          ),
          child: Column(
            children: [
              NeoIconChip(
                icon: category.icon,
                backgroundColor: category.backgroundColor,
                iconColor: category.foregroundColor,
                size: 54,
                iconSize: 26,
              ),
              const SizedBox(height: 12),
              Text(
                expense.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '-${CurrencyFormatter.formatVND(expense.amount)}',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              if (expense.hasReceipt) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.iconTintBg,
                    borderRadius: AppStyles.borderPill,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.document_scanner_outlined, size: 13, color: AppColors.iconTintFg),
                      SizedBox(width: 4),
                      Text(
                        'Đã xác thực qua OCR hoá đơn',
                        style: TextStyle(
                          fontSize: 11,
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
        ),
        const SizedBox(height: 20),

        const Text(
          'Thông tin giao dịch',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderHairline),
          ),
          child: Column(
            children: [
              _buildRow('Thời gian', DateFormatter.formatDateTime(expense.dateTime)),
              const Divider(height: 20, color: AppColors.borderHairline),
              _buildRow('Danh mục', category.name),
              const Divider(height: 20, color: AppColors.borderHairline),
              _buildRow('Hũ ngân sách', jar?.name ?? 'Mặc định'),
              const Divider(height: 20, color: AppColors.borderHairline),
              _buildRow('Thanh toán bằng', expense.paymentMethod.title),
              if (expense.note != null && expense.note!.isNotEmpty) ...[
                const Divider(height: 20, color: AppColors.borderHairline),
                _buildRow('Ghi chú', expense.note!),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),

        if (expense.items.isNotEmpty) ...[
          Text(
            'Sản phẩm trong hoá đơn (${expense.items.length} món)',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderHairline),
            ),
            child: Column(
              children: [
                for (int i = 0; i < expense.items.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          '${expense.items[i].quantity}x',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            expense.items[i].name,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          CurrencyFormatter.formatVND(expense.items[i].totalPrice),
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i < expense.items.length - 1)
                    const Divider(height: 1, color: AppColors.borderHairline),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],

        NeoPillButton(
          text: 'Xoá khoản chi này',
          variant: NeoPillVariant.danger,
          icon: Icons.delete_outline_rounded,
          onPressed: () {
            state.deleteExpense(expense.id);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đã xoá khoản chi và hoàn tiền vào hũ ngân sách!'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
