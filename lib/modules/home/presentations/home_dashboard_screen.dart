import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../app/state/app_state_manager.dart';
import '../../budget/presentations/widgets/cards/neo_jar_progress_card.dart';
import '../../expense/presentations/add_expense_screen.dart';
import '../../expense/presentations/widgets/modals/expense_detail_sheet.dart';
import '../../profile/presentations/notifications_screen.dart';
import '../../receipt_scanner/presentations/receipt_scanner_screen.dart';
import 'widgets/cards/neo_hero_card.dart';
import 'widgets/cards/neo_insight_card.dart';
import 'widgets/tiles/neo_transaction_tile.dart';

class HomeDashboardScreen extends StatelessWidget {
  final AppStateManager state;

  const HomeDashboardScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final recentExpenses = state.recentExpenses.take(5).toList();
        final topJars = state.jars.take(3).toList();
        final latestInsight = state.insights.isNotEmpty ? state.insights.first : null;

        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Top App Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Avatar & Greeting
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.inkCta,
                                border: Border.all(color: AppColors.surfaceWhite, width: 2),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x1A000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'CB',
                                  style: TextStyle(
                                    color: AppColors.surfaceWhite,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Xin chào,',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  'Chí Bảo 👋',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Notification Bell
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => NotificationsScreen(state: state),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(22),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceWhite,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.borderHairline),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  Icons.notifications_none_rounded,
                                  color: AppColors.textPrimary,
                                  size: 22,
                                ),
                                Positioned(
                                  top: 10,
                                  right: 11,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.dangerRed,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Hero Balance Card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: NeoHeroCard(
                      totalSpent: state.totalSpentThisMonth,
                      totalBudget: state.totalBudget,
                      onScanReceipt: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ReceiptScannerScreen(state: state),
                          ),
                        );
                      },
                      onAddExpense: () {
                        AddExpenseScreen.show(context, state: state);
                      },
                      onViewJars: () {
                        state.setTab(2); // Go to Jars tab
                      },
                    ),
                  ),
                ),

                // Smart Insight Card
                if (latestInsight != null)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
                      child: NeoInsightCard(
                        title: latestInsight.title,
                        description: latestInsight.description,
                        icon: latestInsight.icon,
                        onTap: () {
                          state.setTab(3); // Go to Analysis tab
                        },
                      ),
                    ),
                  ),

                // Spending Jars Snapshot Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hũ chi tiêu nổi bật',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                        InkWell(
                          onTap: () => state.setTab(2), // Go to Budget Jars Tab
                          borderRadius: BorderRadius.circular(12),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                Text(
                                  'Xem tất cả',
                                  style: TextStyle(
                                    color: AppColors.iconTintFg,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(
                                  Icons.chevron_right,
                                  size: 16,
                                  color: AppColors.iconTintFg,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Spending Jars Snapshot Cards
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: topJars.map((jar) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: NeoJarProgressCard(
                            name: jar.name,
                            budget: jar.budget,
                            spent: jar.spent,
                            icon: jar.icon,
                            iconBg: jar.backgroundColor,
                            iconFg: jar.foregroundColor,
                            onTap: () => state.setTab(2),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Recent Transactions Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Giao dịch gần đây',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                        InkWell(
                          onTap: () => state.setTab(1), // Go to Expense List Tab
                          borderRadius: BorderRadius.circular(12),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                Text(
                                  'Lịch sử',
                                  style: TextStyle(
                                    color: AppColors.iconTintFg,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(
                                  Icons.chevron_right,
                                  size: 16,
                                  color: AppColors.iconTintFg,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Recent Transactions List (Flat List Rows)
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderHairline.withValues(alpha: 0.8)),
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < recentExpenses.length; i++) ...[
                          Builder(
                            builder: (ctx) {
                              final expense = recentExpenses[i];
                              final category = state.getCategoryById(expense.categoryId);
                              final jar = state.getJarById(expense.jarId);

                              return NeoTransactionTile(
                                title: expense.title,
                                subtitle: DateFormatter.formatRelative(expense.dateTime),
                                amount: expense.amount,
                                icon: category.icon,
                                iconBg: category.backgroundColor,
                                iconFg: category.foregroundColor,
                                hasReceipt: expense.hasReceipt,
                                jarName: jar?.name,
                                onTap: () {
                                  ExpenseDetailSheet.show(context, expense: expense, state: state);
                                },
                              );
                            },
                          ),
                          if (i < recentExpenses.length - 1)
                            const Divider(
                              indent: 74,
                              endIndent: 16,
                              height: 1,
                              color: AppColors.borderHairline,
                            ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Extra padding for bottom navigation bar
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
