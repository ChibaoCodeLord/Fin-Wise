import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_styles.dart';
import '../../app/state/app_state_manager.dart';
import '../models/receipt_model.dart';
import 'receipt_review_screen.dart';

class ReceiptScannerScreen extends StatefulWidget {
  final AppStateManager state;

  const ReceiptScannerScreen({super.key, required this.state});

  @override
  State<ReceiptScannerScreen> createState() => _ReceiptScannerScreenState();
}

class _ReceiptScannerScreenState extends State<ReceiptScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _laserController;
  late Animation<double> _laserAnimation;

  bool _isProcessing = false;
  String _processingStep = 'Đang phân tích hoá đơn...';
  int _selectedSampleIndex = 0;

  final List<ReceiptModel> _sampleReceipts = ReceiptModel.sampleReceipts;

  @override
  void initState() {
    super.initState();
    _laserController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _laserAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _laserController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _laserController.dispose();
    super.dispose();
  }

  void _startOcrProcess(ReceiptModel receipt) async {
    setState(() {
      _isProcessing = true;
      _processingStep = 'Tiền xử lý & Làm rõ hình ảnh...';
    });

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() {
      _processingStep = 'Nhận diện OCR: Cửa hàng & Tổng tiền...';
    });

    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _processingStep = 'Bóc tách ${receipt.items.length} mặt hàng & AI phân loại...';
    });

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    setState(() {
      _isProcessing = false;
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ReceiptReviewScreen(
          receipt: receipt,
          state: widget.state,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scanBoxWidth = size.width * 0.85;
    final scanBoxHeight = size.height * 0.52;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E17),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF10193B), Color(0xFF070A10)],
                ),
              ),
              child: Center(
                child: Opacity(
                  opacity: 0.25,
                  child: Icon(
                    Icons.receipt_long_rounded,
                    size: size.width * 0.7,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: Colors.white, size: 28),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: AppStyles.borderPill,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.auto_awesome, color: Color(0xFF60A5FA), size: 16),
                            SizedBox(width: 6),
                            Text(
                              'AI OCR Scanner',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.flash_on_outlined, color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: Container(
                    width: scanBoxWidth,
                    height: scanBoxHeight,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Stack(
                      children: [
                        ..._buildCornerBrackets(),
                        if (!_isProcessing)
                          AnimatedBuilder(
                            animation: _laserAnimation,
                            builder: (context, child) {
                              return Positioned(
                                top: _laserAnimation.value * (scanBoxHeight - 10),
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 3,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Color(0xFF60A5FA),
                                        Color(0xFF3B82F6),
                                        Color(0xFF60A5FA),
                                        Colors.transparent,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x993B82F6),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: AppStyles.borderPill,
                              ),
                              child: const Text(
                                'Căn chỉnh hoá đơn vào trong khung quét',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Text(
                        'Hoá đơn mẫu thực tế để thử OCR:',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_sampleReceipts.length, (index) {
                            final r = _sampleReceipts[index];
                            final isSelected = _selectedSampleIndex == index;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedSampleIndex = index;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF3B6FE0)
                                        : Colors.white.withValues(alpha: 0.12),
                                    borderRadius: AppStyles.borderPill,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    r.merchantName.split(' ')[0],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          _startOcrProcess(_sampleReceipts[_selectedSampleIndex]);
                        },
                        icon: const Icon(
                          Icons.photo_library_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                        tooltip: 'Chọn ảnh từ máy',
                      ),
                      GestureDetector(
                        onTap: () {
                          _startOcrProcess(_sampleReceipts[_selectedSampleIndex]);
                        },
                        child: Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Color(0xFF0B0E17),
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _startOcrProcess(_sampleReceipts[_selectedSampleIndex]);
                        },
                        icon: const Icon(
                          Icons.crop_free_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        tooltip: 'Tự động cắt khung',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isProcessing)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.85),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            strokeWidth: 3.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0B0E17)),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Đang xử lý OCR',
                          style: TextStyle(
                            color: Color(0xFF0B0E17),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _processingStep,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildCornerBrackets() {
    const double length = 24.0;
    const double thickness = 4.0;
    const Color color = Color(0xFF60A5FA);

    return [
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: length,
          height: thickness,
          decoration: const BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16)),
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: thickness,
          height: length,
          decoration: const BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16)),
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: length,
          height: thickness,
          decoration: const BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: thickness,
          height: length,
          decoration: const BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: length,
          height: thickness,
          decoration: const BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16)),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: thickness,
          height: length,
          decoration: const BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16)),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: length,
          height: thickness,
          decoration: const BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(16)),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: Container(
          width: thickness,
          height: length,
          decoration: const BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(16)),
          ),
        ),
      ),
    ];
  }
}
