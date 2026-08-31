import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/buttons/neo_pill_button.dart';
import '../../../core/widgets/modals/neo_success_modal.dart';
import '../../app/state/app_state_manager.dart';
import '../../expense/presentations/widgets/tiles/neo_radio_tile.dart';
import '../models/receipt_model.dart';

class ReceiptReviewScreen extends StatefulWidget {
  final ReceiptModel receipt;
  final AppStateManager state;

  const ReceiptReviewScreen({
    super.key,
    required this.receipt,
    required this.state,
  });

  @override
  State<ReceiptReviewScreen> createState() => _ReceiptReviewScreenState();
}

class _ReceiptReviewScreenState extends State<ReceiptReviewScreen> {
  late TextEditingController _merchantController;
  late TextEditingController _noteController;
  late String _selectedCategoryId;
  late String _selectedJarId;
  PaymentMethod _selectedPayment = PaymentMethod.creditCard;

  @override
  void initState() {
    super.initState();
    _merchantController = TextEditingController(text: widget.receipt.merchantName);
    _noteController = TextEditingController(text: 'Quét tự động từ hoá đơn');
    _selectedCategoryId = widget.receipt.suggestedCategoryId;

    if (widget.receipt.suggestedJarId != null &&
        widget.state.jars.any((j) => j.id == widget.receipt.suggestedJarId)) {
      _selectedJarId = widget.receipt.suggestedJarId!;
    } else {
      _selectedJarId = widget.state.jars.first.id;
    }
  }

  @override
  void dispose() {
    _merchantController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _saveExpense() {
    final updatedReceipt = ReceiptModel(
      id: widget.receipt.id,
      merchantName: _merchantController.text.trim(),
      address: widget.receipt.address,
      dateTime: widget.receipt.dateTime,
      totalAmount: widget.receipt.totalAmount,
      subtotal: widget.receipt.subtotal,
      tax: widget.receipt.tax,
      discount: widget.receipt.discount,
      paymentMethod: _selectedPayment.title,
      items: widget.receipt.items,
      suggestedCategoryId: _selectedCategoryId,
      suggestedJarId: _selectedJarId,
    );

    widget.state.processReceiptScan(
      updatedReceipt,
      categoryId: _selectedCategoryId,
      jarId: _selectedJarId,
      paymentMethod: _selectedPayment,
      note: _noteController.text.trim(),
    );

    NeoSuccessModal.show(
      context: context,
      title: 'Đã lưu khoản chi!',
      message: 'Hoá đơn từ "${_merchantController.text.trim()}" đã được thêm vào ngân sách thành công.',
      detailsWidget: Column(
        children: [
          _buildSummaryRow('Tổng tiền', CurrencyFormatter.formatVND(widget.receipt.totalAmount), isBold: true),
          const SizedBox(height: 6),
          _buildSummaryRow('Hũ ngân sách', widget.state.getJarById(_selectedJarId)?.name ?? 'Mặc định'),
          const SizedBox(height: 6),
          _buildSummaryRow('Số mặt hàng', '${widget.receipt.items.length} món'),
        ],
      ),
      buttonText: 'Về trang chủ',
      onAction: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
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
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.state.categories;
    final jars = widget.state.jars;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Kiểm tra hoá đơn OCR'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.iconTintBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: AppColors.iconTintFg, size: 18),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'AI đã trích xuất 100% dữ liệu hoá đơn. Vui lòng kiểm tra lại trước khi lưu.',
                            style: TextStyle(
                              color: AppColors.iconTintFg,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderHairline),
                      boxShadow: AppStyles.shadowSoft,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CỬA HÀNG / ĐƠN VỊ',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _merchantController,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                        ),
                        if (widget.receipt.address != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.receipt.address!,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                        const Divider(height: 24, color: AppColors.borderHairline),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormatter.formatDateTime(widget.receipt.dateTime),
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              CurrencyFormatter.formatVND(widget.receipt.totalAmount),
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Chi tiết sản phẩm đã nhận diện',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderHairline),
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < widget.receipt.items.length; i++) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceMuted,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${widget.receipt.items[i].quantity}x',
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.receipt.items[i].name,
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Đơn giá: ${CurrencyFormatter.formatVND(widget.receipt.items[i].unitPrice)}',
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  CurrencyFormatter.formatVND(widget.receipt.items[i].totalPrice),
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (i < widget.receipt.items.length - 1)
                            const Divider(height: 1, color: AppColors.borderHairline),
                        ],
                        if (widget.receipt.discount > 0 || widget.receipt.tax > 0) ...[
                          const Divider(height: 1, color: AppColors.borderHairline),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                if (widget.receipt.tax > 0)
                                  _buildSummaryRow('Thuế VAT', CurrencyFormatter.formatVND(widget.receipt.tax)),
                                if (widget.receipt.discount > 0) ...[
                                  const SizedBox(height: 4),
                                  _buildSummaryRow(
                                    'Giảm giá khuyến mãi',
                                    '-${CurrencyFormatter.formatVND(widget.receipt.discount)}',
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Danh mục chi tiêu',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: categories.map((cat) {
                      final isSelected = _selectedCategoryId == cat.id;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryId = cat.id;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.inkCta : AppColors.surfaceWhite,
                            borderRadius: AppStyles.borderPill,
                            border: Border.all(
                              color: isSelected ? AppColors.inkCta : AppColors.borderHairline,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              cat.icon is IconData
                                  ? Icon(
                                      cat.icon as IconData,
                                      size: 16,
                                      color: isSelected ? AppColors.surfaceWhite : cat.foregroundColor,
                                    )
                                  : HugeIcon(
                                      icon: cat.icon,
                                      size: 16,
                                      color: isSelected ? AppColors.surfaceWhite : cat.foregroundColor,
                                    ),
                              const SizedBox(width: 6),
                              Text(
                                cat.name,
                                style: TextStyle(
                                  color: isSelected ? AppColors.surfaceWhite : AppColors.textPrimary,
                                  fontSize: 13,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Trừ vào hũ chi tiêu nào?',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: jars.map((jar) {
                      return NeoRadioTile<String>(
                        value: jar.id,
                        groupValue: _selectedJarId,
                        title: jar.name,
                        subtitle: 'Còn lại: ${CurrencyFormatter.formatVND(jar.budget - jar.spent)}',
                        leadingIcon: jar.icon,
                        onChanged: (val) {
                          setState(() {
                            _selectedJarId = val;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Phương thức thanh toán',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: PaymentMethod.values.map((pm) {
                      return NeoRadioTile<PaymentMethod>(
                        value: pm,
                        groupValue: _selectedPayment,
                        title: pm.title,
                        subtitle: pm.subtitle,
                        leadingIcon: Icons.payment,
                        onChanged: (val) {
                          setState(() {
                            _selectedPayment = val;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ghi chú',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderHairline),
                    ),
                    child: TextField(
                      controller: _noteController,
                      style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                      decoration: const InputDecoration(
                        hintText: 'Nhập ghi chú thêm nếu cần...',
                        hintStyle: TextStyle(color: AppColors.textTertiary),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            decoration: const BoxDecoration(
              color: AppColors.surfaceWhite,
              border: Border(top: BorderSide(color: AppColors.borderHairline)),
            ),
            child: NeoPillButton(
              text: 'Lưu khoản chi',
              icon: Icons.check_circle_outline,
              onPressed: _saveExpense,
            ),
          ),
        ],
      ),
    );
  }
}
