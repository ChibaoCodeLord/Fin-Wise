import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _vndFormat = NumberFormat('#,###', 'vi_VN');

  /// Formats amount to standard VND: e.g. 3.250.000đ
  static String formatVND(double amount, {bool showSymbol = true}) {
    final formatted = _vndFormat.format(amount.round());
    return showSymbol ? '$formattedđ' : formatted;
  }

  /// Compact format for charts or badges: e.g. 3.2M, 500k
  static String formatCompact(double amount) {
    if (amount >= 1000000) {
      final val = amount / 1000000;
      return '${val.toStringAsFixed(val.truncateToDouble() == val ? 0 : 1)}tr';
    } else if (amount >= 1000) {
      final val = amount / 1000;
      return '${val.toStringAsFixed(val.truncateToDouble() == val ? 0 : 0)}k';
    }
    return formatVND(amount);
  }
}
