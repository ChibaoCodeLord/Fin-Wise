import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../analysis/presentations/spending_analysis_screen.dart';
import '../../budget/presentations/spending_jars_screen.dart';
import '../../expense/presentations/expense_list_screen.dart';
import '../../home/presentations/home_dashboard_screen.dart';
import '../../profile/presentations/profile_screen.dart';
import '../../receipt_scanner/presentations/receipt_scanner_screen.dart';
import '../state/app_state_manager.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final AppStateManager _state = AppStateManager.instance;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _state,
      builder: (context, _) {
        final screens = [
          HomeDashboardScreen(state: _state),
          ExpenseListScreen(state: _state),
          SpendingJarsScreen(state: _state),
          SpendingAnalysisScreen(state: _state),
          ProfileScreen(state: _state),
        ];

        return Scaffold(
          body: IndexedStack(
            index: _state.selectedTab,
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: AppColors.surfaceWhite,
              border: Border(
                top: BorderSide(
                  color: AppColors.borderHairline,
                  width: 1.0,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.home_rounded, Icons.home_outlined, 'Trang chủ'),
                    _buildNavItem(1, Icons.receipt_long_rounded, Icons.receipt_long_outlined, 'Lịch sử'),
                    _buildScanCenterButton(),
                    _buildNavItem(2, Icons.savings_rounded, Icons.savings_outlined, 'Hũ chi tiêu'),
                    _buildNavItem(3, Icons.insert_chart_rounded, Icons.insert_chart_outlined, 'Báo cáo'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final isSelected = _state.selectedTab == index;

    return InkWell(
      onTap: () => _state.setTab(index),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: isSelected ? AppColors.inkCta : AppColors.textTertiary,
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.inkCta : AppColors.textTertiary,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanCenterButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReceiptScannerScreen(state: _state),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.inkCta,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x330B0E17),
              offset: Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.document_scanner_rounded,
              color: AppColors.surfaceWhite,
              size: 18,
            ),
            SizedBox(width: 6),
            Text(
              'Quét OCR',
              style: TextStyle(
                color: AppColors.surfaceWhite,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
