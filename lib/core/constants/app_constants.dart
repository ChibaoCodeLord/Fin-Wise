class AppConstants {
  static const String appName = 'FinWise';
  static const String appTagline = 'Quản lý chi tiêu & Quét hoá đơn OCR';
  static const String currencySymbol = 'đ';
  
  // Default values
  static const double defaultMonthlyBudget = 5000000.0; // 5.000.000đ
  
  // Thresholds
  static const double warningThresholdModerate = 0.50; // 50%
  static const double warningThresholdHigh = 0.80; // 80%
  static const double warningThresholdDanger = 1.00; // 100%
}

enum JarPeriod {
  weekly('Hàng tuần'),
  monthly('Hàng tháng'),
  custom('Tùy chỉnh');

  final String label;
  const JarPeriod(this.label);
}

enum PaymentMethod {
  cash('Tiền mặt', 'Cash'),
  creditCard('Thẻ tín dụng', 'Visa/Mastercard'),
  bankTransfer('Chuyển khoản', 'Bank Transfer'),
  eWallet('Ví điện tử', 'Momo/ZaloPay');

  final String title;
  final String subtitle;
  const PaymentMethod(this.title, this.subtitle);
}

enum AnalysisPeriod {
  daily('Ngày'),
  weekly('Tuần'),
  monthly('Tháng'),
  yearly('Năm');

  final String title;
  const AnalysisPeriod(this.title);
}
