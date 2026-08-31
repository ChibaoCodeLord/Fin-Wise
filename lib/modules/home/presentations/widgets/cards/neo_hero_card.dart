import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/utils/currency_formatter.dart';

class NeoHeroCard extends StatefulWidget {
  final double totalSpent;
  final double totalBudget;
  final VoidCallback onScanReceipt;
  final VoidCallback onAddExpense;
  final VoidCallback onViewJars;
  final VoidCallback onNotificationTap;
  final VoidCallback onSearchTap;

  const NeoHeroCard({
    super.key,
    required this.totalSpent,
    required this.totalBudget,
    required this.onScanReceipt,
    required this.onAddExpense,
    required this.onViewJars,
    required this.onNotificationTap,
    required this.onSearchTap,
  });

  @override
  State<NeoHeroCard> createState() => _NeoHeroCardState();
}

class _NeoHeroCardState extends State<NeoHeroCard> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    // Current balance display
    final balance = widget.totalBudget - widget.totalSpent;
    final formattedBalance = _isBalanceVisible
        ? CurrencyFormatter.formatVND(balance > 0 ? balance : widget.totalBudget)
        : '••••••••';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Bar: User Greeting + Search & Notifications
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Avatar & Name
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Container(
                      color: AppColors.inkCta,
                      child: const Center(
                        child: Text(
                          'CB',
                          style: TextStyle(
                            color: AppColors.surfaceWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text('👋', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Ethan Carter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Action Icons (Search & Notifications Glass Buttons)
            Row(
              children: [
                // Search Glass Button
                InkWell(
                  onTap: widget.onSearchTap,
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Notification Bell Glass Button
                InkWell(
                  onTap: widget.onNotificationTap,
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF97316), // Orange dot
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 26),

        // Total Balance Section
        Text(
          'Total Balance',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),

        // Big Balance Number + Eye Toggle Icon
        Row(
          children: [
            Text(
              formattedBalance,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6,
                height: 1.1,
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isBalanceVisible = !_isBalanceVisible;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  _isBalanceVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 22,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Subtitle / Growth percentage
        Text(
          '+8.42% Today (+${CurrencyFormatter.formatVND(widget.totalSpent)})',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),

        // Quick Action Row: [+ Deposit] [⇅ Transfer] [[  ] Scan]
        Row(
          children: [
            // [+ Deposit] / [+ Thêm chi] White Pill Button
            Expanded(
              child: Material(
                color: Colors.white,
                borderRadius: AppStyles.borderPill,
                child: InkWell(
                  onTap: widget.onAddExpense,
                  borderRadius: AppStyles.borderPill,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_rounded,
                          color: AppColors.inkCta,
                          size: 20,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Deposit',
                          style: TextStyle(
                            color: AppColors.inkCta,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // [⇅ Transfer] / [⇅ Chuyển hũ] White Pill Button
            Expanded(
              child: Material(
                color: Colors.white,
                borderRadius: AppStyles.borderPill,
                child: InkWell(
                  onTap: widget.onViewJars,
                  borderRadius: AppStyles.borderPill,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.swap_vert_rounded,
                          color: AppColors.inkCta,
                          size: 20,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Transfer',
                          style: TextStyle(
                            color: AppColors.inkCta,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // [[  ]] Black Rounded Scan Button
            Material(
              color: AppColors.inkCta,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: widget.onScanReceipt,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.crop_free_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
