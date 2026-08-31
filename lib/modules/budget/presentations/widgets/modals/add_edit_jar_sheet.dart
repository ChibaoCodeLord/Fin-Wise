import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/buttons/neo_pill_button.dart';
import '../../../../../core/widgets/modals/neo_bottom_sheet.dart';
import '../../../../app/state/app_state_manager.dart';
import '../../../models/spending_jar_model.dart';

class AddEditJarSheet extends StatefulWidget {
  final SpendingJarModel? existingJar;
  final AppStateManager state;

  const AddEditJarSheet({
    super.key,
    this.existingJar,
    required this.state,
  });

  static Future<void> show(
    BuildContext context, {
    SpendingJarModel? existingJar,
    required AppStateManager state,
  }) {
    return NeoBottomSheet.show(
      context: context,
      title: existingJar == null ? 'Tạo hũ chi tiêu mới' : 'Chỉnh sửa hũ chi tiêu',
      child: AddEditJarSheet(existingJar: existingJar, state: state),
    );
  }

  @override
  State<AddEditJarSheet> createState() => _AddEditJarSheetState();
}

class _AddEditJarSheetState extends State<AddEditJarSheet> {
  late TextEditingController _nameController;
  late TextEditingController _budgetController;
  JarPeriod _period = JarPeriod.monthly;
  int _selectedIconIndex = 0;

  final List<dynamic> _icons = [
    HugeIcons.strokeRoundedRestaurant01,
    HugeIcons.strokeRoundedShoppingBag01,
    HugeIcons.strokeRoundedCar01,
    HugeIcons.strokeRoundedGameController01,
    HugeIcons.strokeRoundedUserCheck01,
    HugeIcons.strokeRoundedHome01,
    HugeIcons.strokeRoundedAirplane01,
    HugeIcons.strokeRoundedBook01,
    HugeIcons.strokeRoundedHealth,
    HugeIcons.strokeRoundedPiggyBank,
    HugeIcons.strokeRoundedCoffee02,
    HugeIcons.strokeRoundedWallet01,
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existingJar?.name ?? '');
    _budgetController = TextEditingController(
      text: widget.existingJar != null ? widget.existingJar!.budget.toInt().toString() : '',
    );
    _period = widget.existingJar?.period ?? JarPeriod.monthly;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final budget = double.tryParse(_budgetController.text.trim()) ?? 0.0;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập tên hũ chi tiêu')),
      );
      return;
    }
    if (budget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập ngân sách hợp lệ')),
      );
      return;
    }

    if (widget.existingJar == null) {
      final newJar = SpendingJarModel(
        id: 'jar_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        budget: budget,
        spent: 0.0,
        period: _period,
        icon: _icons[_selectedIconIndex],
        backgroundColor: AppColors.iconTintBg,
        foregroundColor: AppColors.iconTintFg,
      );
      widget.state.addJar(newJar);
    } else {
      final updated = widget.existingJar!.copyWith(
        name: name,
        budget: budget,
        period: _period,
        icon: _icons[_selectedIconIndex],
      );
      widget.state.updateJar(updated);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tên hũ chi tiêu',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceMutedLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderHairline),
          ),
          child: TextField(
            controller: _nameController,
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
            decoration: const InputDecoration(
              hintText: 'Ví dụ: Ăn uống, Tiền nhà, Du lịch...',
              hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 13),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Ngân sách định mức (VNĐ)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceMutedLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderHairline),
          ),
          child: TextField(
            controller: _budgetController,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            decoration: const InputDecoration(
              hintText: 'Ví dụ: 2000000',
              hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 13),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Chu kỳ ngân sách',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Row(
          children: JarPeriod.values.map((p) {
            final isSelected = _period == p;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () => setState(() => _period = p),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.inkCta : AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      p.label,
                      style: TextStyle(
                        color: isSelected ? AppColors.surfaceWhite : AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 18),
        const Text(
          'Biểu tượng hũ',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(_icons.length, (index) {
            final isSelected = _selectedIconIndex == index;
            final icon = _icons[index];

            Widget iconWidget;
            if (icon is IconData) {
              iconWidget = Icon(
                icon,
                size: 20,
                color: isSelected ? AppColors.surfaceWhite : AppColors.textPrimary,
              );
            } else {
              iconWidget = HugeIcon(
                icon: icon,
                size: 20,
                color: isSelected ? AppColors.surfaceWhite : AppColors.textPrimary,
              );
            }

            return GestureDetector(
              onTap: () => setState(() => _selectedIconIndex = index),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.inkCta : AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: iconWidget,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 28),
        NeoPillButton(
          text: widget.existingJar == null ? 'Tạo hũ chi tiêu' : 'Lưu thay đổi',
          onPressed: _save,
        ),
      ],
    );
  }
}
