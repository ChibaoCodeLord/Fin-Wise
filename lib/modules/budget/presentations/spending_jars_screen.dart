import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/buttons/neo_pill_button.dart';
import '../../app/state/app_state_manager.dart';
import 'widgets/cards/neo_jar_progress_card.dart';
import 'widgets/modals/add_edit_jar_sheet.dart';

class SpendingJarsScreen extends StatelessWidget {
  final AppStateManager state;

  const SpendingJarsScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final totalBudget = state.totalBudget;
        final totalSpent = state.totalSpentThisMonth;
        final remaining = (totalBudget - totalSpent).clamp(0.0, double.infinity);
        final ratio = totalBudget > 0 ? (totalSpent / totalBudget).clamp(0.0, 1.5) : 0.0;
        final percent = (ratio * 100).toInt();

        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: AppBar(
            title: const Text('Hũ chi tiêu (Budget Jars)'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.textPrimary, size: 24),
                onPressed: () => AddEditJarSheet.show(context, state: state),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: AppColors.cardAccentGradient,
                  borderRadius: AppStyles.borderCard,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x331E3A8A),
                      offset: Offset(0, 10),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TỔNG NGÂN SÁCH CÁC HŨ',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: AppStyles.borderPill,
                          ),
                          child: Text(
                            'Đã chi $percent%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      CurrencyFormatter.formatVND(totalBudget),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.6,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: [
                          Container(
                            height: 6,
                            width: double.infinity,
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                          FractionallySizedBox(
                            widthFactor: ratio > 1.0 ? 1.0 : ratio,
                            child: Container(
                              height: 6,
                              color: ratio >= 1.0
                                  ? AppColors.dangerRed
                                  : (ratio >= 0.8 ? AppColors.warningAmber : const Color(0xFF60A5FA)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Đã chi: ${CurrencyFormatter.formatVND(totalSpent)}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Còn lại: ${CurrencyFormatter.formatVND(remaining)}',
                          style: const TextStyle(
                            color: Color(0xFF93C5FD),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Danh sách ${state.jars.length} hũ chi tiêu',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => AddEditJarSheet.show(context, state: state),
                    icon: const Icon(Icons.add, size: 18, color: AppColors.inkCta),
                    label: const Text(
                      'Thêm hũ',
                      style: TextStyle(color: AppColors.inkCta, fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...state.jars.map((jar) {
                final jarExpenses = state.expenses.where((e) => e.jarId == jar.id).toList();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: NeoJarProgressCard(
                    name: jar.name,
                    budget: jar.budget,
                    spent: jar.spent,
                    icon: jar.icon,
                    iconBg: jar.backgroundColor,
                    iconFg: jar.foregroundColor,
                    transactionCount: jarExpenses.length,
                    onTap: () {
                      _showJarOptionsModal(context, jar);
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showJarOptionsModal(BuildContext context, dynamic jar) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Material(
        color: AppColors.surfaceWhite,
        borderRadius: AppStyles.borderSheet,
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderHairline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                jar.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 4),
              Text(
                'Ngân sách: ${CurrencyFormatter.formatVND(jar.budget)} | Đã dùng: ${CurrencyFormatter.formatVND(jar.spent)}',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.edit_outlined, color: AppColors.textPrimary),
                title: const Text('Chỉnh sửa định mức & tên hũ', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.of(ctx).pop();
                  AddEditJarSheet.show(context, existingJar: jar, state: state);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: AppColors.dangerRed),
                title: const Text('Xoá hũ chi tiêu này', style: TextStyle(color: AppColors.dangerRed, fontWeight: FontWeight.w600)),
                onTap: () {
                  state.deleteJar(jar.id);
                  Navigator.of(ctx).pop();
                },
              ),
              const SizedBox(height: 12),
              NeoPillButton(
                text: 'Đóng',
                variant: NeoPillVariant.secondary,
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
