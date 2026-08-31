import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/buttons/neo_pill_button.dart';
import '../../../core/widgets/modals/neo_bottom_sheet.dart';
import '../../../core/widgets/modals/neo_success_modal.dart';
import '../../app/state/app_state_manager.dart';
import '../models/expense_model.dart';
import 'widgets/tiles/neo_radio_tile.dart';

class AddExpenseScreen extends StatefulWidget {
  final AppStateManager state;

  const AddExpenseScreen({super.key, required this.state});

  static Future<void> show(BuildContext context, {required AppStateManager state}) {
    return NeoBottomSheet.show(
      context: context,
      title: 'Thêm chi tiêu mới',
      child: AddExpenseScreen(state: state),
    );
  }

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String _amountStr = '0';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _merchantController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  late String _selectedCategoryId;
  late String _selectedJarId;
  PaymentMethod _selectedPayment = PaymentMethod.creditCard;

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.state.categories.first.id;
    _selectedJarId = widget.state.jars.first.id;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _merchantController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onKeyPress(String val) {
    setState(() {
      if (val == 'C') {
        _amountStr = '0';
      } else if (val == 'DEL') {
        if (_amountStr.length > 1) {
          _amountStr = _amountStr.substring(0, _amountStr.length - 1);
        } else {
          _amountStr = '0';
        }
      } else if (val == '000') {
        if (_amountStr != '0' && _amountStr.length < 9) {
          _amountStr += '000';
        }
      } else {
        if (_amountStr == '0') {
          _amountStr = val;
        } else if (_amountStr.length < 10) {
          _amountStr += val;
        }
      }
    });
  }

  void _submit() {
    final amount = double.tryParse(_amountStr) ?? 0.0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số tiền chi tiêu hợp lệ!')),
      );
      return;
    }

    final title = _titleController.text.trim().isNotEmpty
        ? _titleController.text.trim()
        : (_merchantController.text.trim().isNotEmpty
            ? _merchantController.text.trim()
            : widget.state.getCategoryById(_selectedCategoryId).name);

    final expense = ExpenseModel(
      id: 'exp_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      merchant: _merchantController.text.trim().isNotEmpty
          ? _merchantController.text.trim()
          : title,
      amount: amount,
      categoryId: _selectedCategoryId,
      jarId: _selectedJarId,
      dateTime: DateTime.now(),
      paymentMethod: _selectedPayment,
      note: _noteController.text.trim(),
    );

    widget.state.addExpense(expense);
    Navigator.of(context).pop();

    NeoSuccessModal.show(
      context: context,
      title: 'Đã thêm chi tiêu!',
      message: 'Khoản chi ${CurrencyFormatter.formatVND(amount)} đã được ghi nhận vào sổ.',
      detailsWidget: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Nội dung', style: TextStyle(color: AppColors.textSecondary)),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Hũ chi tiêu', style: TextStyle(color: AppColors.textSecondary)),
              Text(
                widget.state.getJarById(_selectedJarId)?.name ?? 'Mặc định',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
      onAction: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final amount = double.tryParse(_amountStr) ?? 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                'Số tiền chi tiêu',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                CurrencyFormatter.formatVND(amount),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildNumericKeypad(),
        const SizedBox(height: 20),
        const Text(
          'Tên khoản chi / Mục đích',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        _buildInputField(
          controller: _titleController,
          hintText: 'Ví dụ: Ăn trưa văn phòng, Cà phê...',
          icon: Icons.edit_note_rounded,
        ),
        const SizedBox(height: 14),
        const Text(
          'Cửa hàng / Người nhận',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        _buildInputField(
          controller: _merchantController,
          hintText: 'Ví dụ: Highlands, Grab, WinMart...',
          icon: Icons.storefront_outlined,
        ),
        const SizedBox(height: 18),
        const Text(
          'Chọn danh mục',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.state.categories.map((cat) {
            final isSelected = _selectedCategoryId == cat.id;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategoryId = cat.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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
                            size: 15,
                            color: isSelected ? AppColors.surfaceWhite : cat.foregroundColor,
                          )
                        : HugeIcon(
                            icon: cat.icon,
                            size: 15,
                            color: isSelected ? AppColors.surfaceWhite : cat.foregroundColor,
                          ),
                    const SizedBox(width: 6),
                    Text(
                      cat.name,
                      style: TextStyle(
                        color: isSelected ? AppColors.surfaceWhite : AppColors.textPrimary,
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
        const Text(
          'Hũ chi tiêu',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: widget.state.jars.map((jar) {
            return NeoRadioTile<String>(
              value: jar.id,
              groupValue: _selectedJarId,
              title: jar.name,
              subtitle: 'Còn lại: ${CurrencyFormatter.formatVND(jar.budget - jar.spent)}',
              leadingIcon: jar.icon,
              onChanged: (val) => setState(() => _selectedJarId = val),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
        const Text(
          'Phương thức thanh toán',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: PaymentMethod.values.map((pm) {
            return NeoRadioTile<PaymentMethod>(
              value: pm,
              groupValue: _selectedPayment,
              title: pm.title,
              subtitle: pm.subtitle,
              leadingIcon: Icons.account_balance_wallet_outlined,
              onChanged: (val) => setState(() => _selectedPayment = val),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        NeoPillButton(
          text: 'Xác nhận thêm chi tiêu',
          onPressed: _submit,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceMutedLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderHairline),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 13),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumericKeypad() {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['000', '0', 'DEL'],
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderHairline),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: keys.map((row) {
          return Row(
            children: row.map((k) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () => _onKeyPress(k),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: k == 'DEL' ? AppColors.surfaceMuted : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: k == 'DEL'
                          ? const Icon(Icons.backspace_outlined, size: 18, color: AppColors.textPrimary)
                          : Text(
                              k,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
