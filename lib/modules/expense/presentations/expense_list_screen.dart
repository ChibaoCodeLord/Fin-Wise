import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/chips/neo_filter_chip.dart';
import '../../app/state/app_state_manager.dart';
import '../../home/presentations/widgets/tiles/neo_transaction_tile.dart';
import '../models/expense_model.dart';
import 'add_expense_screen.dart';
import 'widgets/modals/expense_detail_sheet.dart';

class ExpenseListScreen extends StatefulWidget {
  final AppStateManager state;

  const ExpenseListScreen({super.key, required this.state});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  String _searchQuery = '';
  String _selectedCategoryId = 'all';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ExpenseModel> _getFilteredExpenses(List<ExpenseModel> allExpenses) {
    return allExpenses.where((exp) {
      final matchesCat = _selectedCategoryId == 'all' || exp.categoryId == _selectedCategoryId;
      if (!matchesCat) return false;

      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      final matchTitle = exp.title.toLowerCase().contains(query);
      final matchMerchant = exp.merchant.toLowerCase().contains(query);
      final matchNote = exp.note?.toLowerCase().contains(query) ?? false;
      final matchItem = exp.items.any((it) => it.name.toLowerCase().contains(query));

      return matchTitle || matchMerchant || matchNote || matchItem;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.state,
      builder: (context, _) {
        final filteredExpenses = _getFilteredExpenses(widget.state.recentExpenses);
        final totalFiltered = filteredExpenses.fold(0.0, (sum, e) => sum + e.amount);

        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: AppBar(
            title: const Text('Lịch sử chi tiêu'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_rounded, color: AppColors.textPrimary, size: 26),
                onPressed: () => AddExpenseScreen.show(context, state: widget.state),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderHairline),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) => setState(() => _searchQuery = val.trim()),
                          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                          decoration: const InputDecoration(
                            hintText: 'Tìm theo tên, cửa hàng, sản phẩm...',
                            hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 13),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      if (_searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                          child: const Icon(Icons.cancel, color: AppColors.textSecondary, size: 18),
                        ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    NeoFilterChip(
                      label: 'Tất cả',
                      isSelected: _selectedCategoryId == 'all',
                      onTap: () => setState(() => _selectedCategoryId = 'all'),
                    ),
                    const SizedBox(width: 8),
                    ...widget.state.categories.map((cat) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: NeoFilterChip(
                          label: cat.name,
                          icon: cat.icon,
                          isSelected: _selectedCategoryId == cat.id,
                          onTap: () => setState(() => _selectedCategoryId = cat.id),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${filteredExpenses.length} giao dịch',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Tổng: ${CurrencyFormatter.formatVND(totalFiltered)}',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filteredExpenses.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.receipt_long_outlined, size: 64, color: AppColors.textTertiary.withValues(alpha: 0.5)),
                            const SizedBox(height: 12),
                            const Text(
                              'Không tìm thấy giao dịch nào',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
                        itemCount: filteredExpenses.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final expense = filteredExpenses[index];
                          final category = widget.state.getCategoryById(expense.categoryId);
                          final jar = widget.state.getJarById(expense.jarId);

                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.surfaceWhite,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.borderHairline.withValues(alpha: 0.8)),
                            ),
                            child: NeoTransactionTile(
                              title: expense.title,
                              subtitle: DateFormatter.formatRelative(expense.dateTime),
                              amount: expense.amount,
                              icon: category.icon,
                              iconBg: category.backgroundColor,
                              iconFg: category.foregroundColor,
                              hasReceipt: expense.hasReceipt,
                              jarName: jar?.name,
                              onTap: () {
                                ExpenseDetailSheet.show(
                                  context,
                                  expense: expense,
                                  state: widget.state,
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
