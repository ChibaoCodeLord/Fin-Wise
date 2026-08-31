import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../analysis/presentations/spending_analysis_screen.dart';
import '../../budget/presentations/spending_jars_screen.dart';
import '../../expense/presentations/expense_list_screen.dart';
import '../../home/presentations/home_dashboard_screen.dart';
import '../../profile/presentations/profile_screen.dart';
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
          SpendingJarsScreen(state: _state),
          ExpenseListScreen(state: _state),
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
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xFFF1F5F9),
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
                    _buildNavItem(0, Icons.home_filled, Icons.home_outlined, 'Home'),
                    _buildNavItem(1, Icons.credit_card_rounded, Icons.credit_card_outlined, 'Cards'),
                    _buildNavItem(2, Icons.access_time_filled_rounded, Icons.access_time_rounded, 'Activity'),
                    _buildNavItem(3, Icons.insert_chart_rounded, Icons.insert_chart_outlined_rounded, 'Analytics'),
                    _buildNavItem(4, Icons.settings_rounded, Icons.settings_outlined, 'Settings'),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected && index == 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.inkCta,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.home_filled,
                  color: Colors.white,
                  size: 18,
                ),
              )
            else
              Icon(
                isSelected ? activeIcon : inactiveIcon,
                color: isSelected ? AppColors.inkCta : const Color(0xFF94A3B8),
                size: 22,
              ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.inkCta : const Color(0xFF94A3B8),
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
