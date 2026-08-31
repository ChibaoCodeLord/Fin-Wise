import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/buttons/neo_pill_button.dart';
import '../../../core/widgets/modals/neo_bottom_sheet.dart';
import '../../app/state/app_state_manager.dart';
import '../../shopping/presentations/shopping_history_screen.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatefulWidget {
  final AppStateManager state;

  const ProfileScreen({super.key, required this.state});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _biometricsEnabled = true;
  bool _ocrAutoCategory = true;
  bool _budgetAlerts = true;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.state,
      builder: (context, _) {
        final totalSpent = widget.state.totalSpentThisMonth;
        final totalBudget = widget.state.totalBudget;

        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: AppBar(
            title: const Text('Cá nhân & Cài đặt'),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NotificationsScreen(state: widget.state),
                    ),
                  );
                },
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: AppStyles.borderCard,
                  border: Border.all(color: AppColors.borderHairline),
                  boxShadow: AppStyles.shadowSoft,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.inkCta,
                      ),
                      child: const Center(
                        child: Text(
                          'CB',
                          style: TextStyle(
                            color: AppColors.surfaceWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nguyễn Chí Bảo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'chibao.dev@finwise.vn',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.iconTintBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Gói Pro Premium',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.iconTintFg,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Báo cáo tự động tháng 8/2026',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.borderHairline),
                ),
                child: Column(
                  children: [
                    _buildReportRow('Tổng ngân sách thiết lập', CurrencyFormatter.formatVND(totalBudget)),
                    const Divider(height: 20, color: AppColors.borderHairline),
                    _buildReportRow('Tổng chi thực tế', CurrencyFormatter.formatVND(totalSpent)),
                    const Divider(height: 20, color: AppColors.borderHairline),
                    _buildReportRow('Số giao dịch đã ghi', '${widget.state.expenses.length} giao dịch'),
                    const Divider(height: 20, color: AppColors.borderHairline),
                    _buildReportRow('Hoá đơn đã quét OCR', '${widget.state.expenses.where((e) => e.hasReceipt).length} hoá đơn'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Tính năng nâng cao',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Material(
                color: AppColors.surfaceWhite,
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.borderHairline),
                  ),
                  child: Column(
                    children: [
                      _buildNavTile(
                        icon: HugeIcons.strokeRoundedShoppingBag01,
                        title: 'Lịch sử mua sắm & Sản phẩm OCR',
                        subtitle: 'Xem chi tiết các mặt hàng đã bóc tách từ hoá đơn',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ShoppingHistoryScreen(state: widget.state),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, color: AppColors.borderHairline),
                      _buildNavTile(
                        icon: HugeIcons.strokeRoundedFileDownload,
                        title: 'Xuất dữ liệu thu chi (Excel/PDF)',
                        subtitle: 'Xuất báo cáo thuế & sao kê định dạng chuẩn',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Đang chuẩn bị file Excel/PDF chi tiêu...')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Cài đặt & Bảo mật',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Material(
                color: AppColors.surfaceWhite,
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.borderHairline),
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: _biometricsEnabled,
                        onChanged: (val) => setState(() => _biometricsEnabled = val),
                        title: const Text('Khoá ứng dụng bằng FaceID / PIN', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: const Text('Bảo vệ riêng tư số dư khi mở app', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        activeThumbColor: AppColors.inkCta,
                      ),
                      const Divider(height: 1, color: AppColors.borderHairline),
                      SwitchListTile(
                        value: _ocrAutoCategory,
                        onChanged: (val) => setState(() => _ocrAutoCategory = val),
                        title: const Text('Tự động gợi ý hũ qua AI OCR', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: const Text('Nhận diện ngành hàng và đề xuất phân bổ', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        activeThumbColor: AppColors.inkCta,
                      ),
                      const Divider(height: 1, color: AppColors.borderHairline),
                      SwitchListTile(
                        value: _budgetAlerts,
                        onChanged: (val) => setState(() => _budgetAlerts = val),
                        title: const Text('Cảnh báo vượt hạn mức (80% & 100%)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: const Text('Gửi thông báo đẩy khi hũ sắp cạn', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        activeThumbColor: AppColors.inkCta,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              NeoPillButton(
                text: 'Đăng xuất tài khoản',
                variant: NeoPillVariant.outline,
                onPressed: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReportRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildNavTile({
    required dynamic icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    Widget iconWidget = icon is IconData
        ? Icon(icon, color: AppColors.iconTintFg, size: 20)
        : HugeIcon(icon: icon, color: AppColors.iconTintFg, size: 20);

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.iconTintBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: iconWidget,
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textTertiary),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    NeoBottomSheet.show(
      context: context,
      title: 'Đăng xuất',
      child: Column(
        children: [
          const Text(
            'Bạn có chắc chắn muốn đăng xuất khỏi tài khoản FinWise trên thiết bị này?',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 24),
          NeoPillButton(
            text: 'Đăng xuất',
            variant: NeoPillVariant.danger,
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 12),
          NeoPillButton(
            text: 'Huỷ bỏ',
            variant: NeoPillVariant.secondary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
