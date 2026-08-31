import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/chips/neo_filter_chip.dart';
import '../../../core/widgets/chips/neo_icon_chip.dart';
import '../../app/state/app_state_manager.dart';

class SpendingAnalysisScreen extends StatefulWidget {
  final AppStateManager state;

  const SpendingAnalysisScreen({super.key, required this.state});

  @override
  State<SpendingAnalysisScreen> createState() => _SpendingAnalysisScreenState();
}

class _SpendingAnalysisScreenState extends State<SpendingAnalysisScreen> {
  AnalysisPeriod _selectedPeriod = AnalysisPeriod.monthly;
  int _touchedPieIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.state,
      builder: (context, _) {
        final totalSpent = widget.state.totalSpentThisMonth;
        final categoryMap = widget.state.categoryBreakdown;
        final topMerchants = widget.state.topMerchants;
        final avgPerDay = totalSpent > 0 ? totalSpent / 30 : 0.0;

        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: AppBar(
            title: const Text('Phân tích chi tiêu'),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: AnalysisPeriod.values.map((period) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: NeoFilterChip(
                      label: period.title,
                      isSelected: _selectedPeriod == period,
                      onTap: () => setState(() => _selectedPeriod = period),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Tổng chi tiêu',
                      value: CurrencyFormatter.formatVND(totalSpent),
                      subtitle: 'Tháng 8/2026',
                      icon: Icons.payments_outlined,
                      iconBg: AppColors.iconTintBg,
                      iconFg: AppColors.iconTintFg,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Trung bình/ngày',
                      value: CurrencyFormatter.formatVND(avgPerDay),
                      subtitle: 'Dựa trên 30 ngày',
                      icon: Icons.calendar_today_outlined,
                      iconBg: const Color(0xFFF0FDF4),
                      iconFg: const Color(0xFF16A34A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: AppStyles.borderCard,
                  border: Border.all(color: AppColors.borderHairline),
                  boxShadow: AppStyles.shadowSoft,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Xu hướng chi tiêu theo tuần',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'VNĐ',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 180,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 2000000,
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                  CurrencyFormatter.formatVND(rod.toY),
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                );
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (val, meta) {
                                  final titles = ['T1', 'T2', 'T3', 'T4'];
                                  final index = val.toInt();
                                  if (index >= 0 && index < titles.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        titles[index],
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          barGroups: [
                            _buildBarGroup(0, 850000),
                            _buildBarGroup(1, 1450000),
                            _buildBarGroup(2, 650000),
                            _buildBarGroup(3, 1120000, isCurrent: true),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: AppStyles.borderCard,
                  border: Border.all(color: AppColors.borderHairline),
                  boxShadow: AppStyles.shadowSoft,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phân bổ theo danh mục',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 140,
                          height: 140,
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection == null) {
                                      _touchedPieIndex = -1;
                                      return;
                                    }
                                    _touchedPieIndex =
                                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                                  });
                                },
                              ),
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 3,
                              centerSpaceRadius: 40,
                              sections: _generatePieSections(categoryMap, totalSpent),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: categoryMap.entries.map((entry) {
                              final cat = widget.state.getCategoryById(entry.key);
                              final pct = totalSpent > 0 ? (entry.value / totalSpent * 100).toInt() : 0;

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: cat.foregroundColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        cat.name,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      '$pct%',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: AppStyles.borderCard,
                  border: Border.all(color: AppColors.borderHairline),
                  boxShadow: AppStyles.shadowSoft,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cửa hàng chi tiêu nhiều nhất',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...topMerchants.take(5).map((m) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMuted,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.storefront_outlined, size: 18, color: AppColors.textPrimary),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                m.key,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Text(
                              CurrencyFormatter.formatVND(m.value),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderHairline),
        boxShadow: AppStyles.shadowSoft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NeoIconChip(
            icon: icon,
            backgroundColor: iconBg,
            iconColor: iconFg,
            size: 38,
            iconSize: 18,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 11, color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y, {bool isCurrent = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isCurrent ? AppColors.inkCta : const Color(0xFF60A5FA),
          width: 24,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _generatePieSections(Map<String, double> map, double total) {
    if (map.isEmpty || total <= 0) {
      return [
        PieChartSectionData(
          color: AppColors.surfaceMuted,
          value: 1,
          title: '',
          radius: 20,
        ),
      ];
    }

    int index = 0;
    return map.entries.map((entry) {
      final isTouched = index == _touchedPieIndex;
      final cat = widget.state.getCategoryById(entry.key);
      final radius = isTouched ? 28.0 : 22.0;
      index++;

      return PieChartSectionData(
        color: cat.foregroundColor,
        value: entry.value,
        title: '',
        radius: radius,
      );
    }).toList();
  }
}
