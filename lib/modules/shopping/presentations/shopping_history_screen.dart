import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../app/state/app_state_manager.dart';
import '../models/shopping_item_model.dart';

class ShoppingHistoryScreen extends StatefulWidget {
  final AppStateManager state;

  const ShoppingHistoryScreen({super.key, required this.state});

  @override
  State<ShoppingHistoryScreen> createState() => _ShoppingHistoryScreenState();
}

class _ShoppingHistoryScreenState extends State<ShoppingHistoryScreen> {
  String _itemSearchQuery = '';
  final TextEditingController _itemSearchController = TextEditingController();

  @override
  void dispose() {
    _itemSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.state,
      builder: (context, _) {
        final allItems = widget.state.allPurchasedItems;
        final filteredItems = allItems.where((it) {
          if (_itemSearchQuery.isEmpty) return true;
          final q = _itemSearchQuery.toLowerCase();
          return it.name.toLowerCase().contains(q) ||
              (it.merchant?.toLowerCase().contains(q) ?? false);
        }).toList();

        final topMerchants = widget.state.topMerchants;

        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: AppBar(
            title: const Text('Lịch sử mua sắm & Sản phẩm'),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
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
                        controller: _itemSearchController,
                        onChanged: (val) => setState(() => _itemSearchQuery = val.trim()),
                        style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                        decoration: const InputDecoration(
                          hintText: 'Tra cứu sản phẩm đã mua (ví dụ: Sữa, Áo thun...)',
                          hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Thống kê theo cửa hàng',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: topMerchants.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final m = topMerchants[index];
                    return Container(
                      width: 150,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.borderHairline),
                        boxShadow: AppStyles.shadowSoft,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.iconTintBg,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.storefront, size: 16, color: AppColors.iconTintFg),
                              ),
                              Text(
                                '#${index + 1}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m.key,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                CurrencyFormatter.formatVND(m.value),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sản phẩm đã trích xuất từ OCR',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.iconTintBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${filteredItems.length} món',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.iconTintFg,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderHairline),
                ),
                child: Column(
                  children: [
                    if (filteredItems.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: Text(
                            'Chưa có sản phẩm nào được quét',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    else
                      for (int i = 0; i < filteredItems.length; i++) ...[
                        _buildItemTile(filteredItems[i]),
                        if (i < filteredItems.length - 1)
                          const Divider(height: 1, color: AppColors.borderHairline),
                      ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItemTile(ShoppingItemModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.shopping_bag_outlined, size: 18, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (item.merchant != null) ...[
                      Text(
                        item.merchant!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(' • ', style: TextStyle(color: AppColors.textTertiary, fontSize: 11)),
                    ],
                    if (item.purchaseDate != null)
                      Text(
                        DateFormatter.formatDayMonth(item.purchaseDate!),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyFormatter.formatVND(item.totalPrice),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'SL: ${item.quantity}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
