import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../app/state/app_state_manager.dart';
import '../../expense/presentations/add_expense_screen.dart';
import '../../expense/presentations/widgets/modals/expense_detail_sheet.dart';
import '../../profile/presentations/notifications_screen.dart';
import '../../receipt_scanner/presentations/receipt_scanner_screen.dart';
import 'widgets/cards/neo_hero_card.dart';
import 'widgets/cards/neo_insight_card.dart';
import 'widgets/tiles/neo_transaction_tile.dart';

class HomeDashboardScreen extends StatefulWidget {
  final AppStateManager state;

  const HomeDashboardScreen({super.key, required this.state});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _selectedBillFilter = 0; // 0: All Bills, 1: Need Actions

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.state,
      builder: (context, _) {
        final recentExpenses = widget.state.recentExpenses;
        final billExpenses = _selectedBillFilter == 0
            ? recentExpenses
            : recentExpenses.where((e) => e.amount >= 200000 || e.categoryId == 'bills').toList();

        return Scaffold(
          backgroundColor: AppColors.surfaceWhite,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Top Blue Gradient Canvas Area
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1D4ED8), // Royal Blue Deep Top
                        Color(0xFF2563EB), // Royal Blue
                        Color(0xFF3B82F6), // Cobalt Blue
                        Color(0xFF60A5FA), // Sky Blue
                        Color(0xFF93C5FD), // Soft Sky Blue
                        Color(0xFFE2E8F0), // Transition to surface
                        Colors.white,
                      ],
                      stops: [0.0, 0.2, 0.45, 0.7, 0.88, 0.96, 1.0],
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Header + Balance + Quick Actions
                          NeoHeroCard(
                            totalSpent: widget.state.totalSpentThisMonth,
                            totalBudget: widget.state.totalBudget,
                            onScanReceipt: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ReceiptScannerScreen(state: widget.state),
                                ),
                              );
                            },
                            onAddExpense: () {
                              AddExpenseScreen.show(context, state: widget.state);
                            },
                            onViewJars: () {
                              widget.state.setTab(2); // Switch to Jars tab
                            },
                            onNotificationTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => NotificationsScreen(state: widget.state),
                                ),
                              );
                            },
                            onSearchTap: () {
                              widget.state.setTab(1); // Switch to Transactions tab
                            },
                          ),
                          const SizedBox(height: 24),

                          // Smart "Bill negotiator" / AI Advisor Card
                          NeoInsightCard(
                            title: 'Bill negotiator',
                            description:
                                'We found a way to cut your AT&T Fiber bill by \$12/month without changing your speed.',
                            actionText: 'Start negotiation',
                            onTap: () {
                              _showNegotiatorDetails(context);
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom Section: "Bills & Payments" Title & Filters
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bills & Payments',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Filter Pills: [All Bills] [Need Actions]
                      Row(
                        children: [
                          _buildFilterPill(
                            index: 0,
                            title: 'All Bills',
                            isSelected: _selectedBillFilter == 0,
                          ),
                          const SizedBox(width: 8),
                          _buildFilterPill(
                            index: 1,
                            title: 'Need Actions',
                            isSelected: _selectedBillFilter == 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Bills & Payments List
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        // Sample bills matching the screenshot look & feel
                        _buildBillItem(
                          title: 'Internet – FiberLink',
                          subtitle: 'Due Sep 18 · 2 days left',
                          amount: 10.99,
                          icon: Icons.wifi_rounded,
                          iconBg: const Color(0xFFE0F2FE),
                          iconFg: const Color(0xFF0284C7),
                          isDollar: true,
                        ),
                        const Divider(height: 1, indent: 70, color: Color(0xFFF1F5F9)),
                        _buildBillItem(
                          title: 'Electricity – PowerGrid',
                          subtitle: 'Due Sep 18 · 2 days left',
                          amount: 120.75,
                          icon: Icons.bolt_rounded,
                          iconBg: const Color(0xFFEFF6FF),
                          iconFg: const Color(0xFF2563EB),
                          isDollar: true,
                        ),
                        const Divider(height: 1, indent: 70, color: Color(0xFFF1F5F9)),
                        _buildBillItem(
                          title: 'Water – AquaPure',
                          subtitle: 'Due Sep 22 · 6 days left',
                          amount: 45.00,
                          icon: Icons.water_drop_rounded,
                          iconBg: const Color(0xFFE0F7FA),
                          iconFg: const Color(0xFF00ACC1),
                          isDollar: true,
                        ),

                        // Additional transactions from state
                        for (int i = 0; i < billExpenses.take(4).length; i++) ...[
                          const Divider(height: 1, indent: 70, color: Color(0xFFF1F5F9)),
                          Builder(
                            builder: (ctx) {
                              final expense = billExpenses[i];
                              final cat = widget.state.getCategoryById(expense.categoryId);
                              final jar = widget.state.getJarById(expense.jarId);

                              return NeoTransactionTile(
                                title: expense.title,
                                subtitle: '${DateFormatter.formatRelative(expense.dateTime)}${jar != null ? ' · ${jar.name}' : ''}',
                                amount: expense.amount,
                                icon: cat.icon,
                                iconBg: cat.backgroundColor,
                                iconFg: cat.foregroundColor,
                                hasReceipt: expense.hasReceipt,
                                onTap: () {
                                  ExpenseDetailSheet.show(
                                    context,
                                    expense: expense,
                                    state: widget.state,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Spacing for Navigation Bar
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterPill({
    required int index,
    required String title,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBillFilter = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.inkCta : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF4B5563),
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildBillItem({
    required String title,
    required String subtitle,
    required double amount,
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
    bool isDollar = false,
  }) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Chi tiết hoá đơn: $title'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Icon Chip
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Icon(icon, color: iconFg, size: 22),
              ),
            ),
            const SizedBox(width: 14),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              isDollar ? '\$${amount.toStringAsFixed(2)}' : CurrencyFormatter.formatVND(amount),
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

  void _showNegotiatorDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Material(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: Padding(
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
              const SizedBox(height: 20),
              const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Color(0xFF0284C7), size: 22),
                  SizedBox(width: 8),
                  Text(
                    'AI Bill Negotiator',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'AI đã phân tích lịch sử hoá đơn Internet và đề xuất gói cước tiết kiệm hơn 12\$/tháng (hoặc 250.000đ/tháng) với cùng băng thông.',
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.inkCta,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Bắt đầu tối ưu gói cước', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
