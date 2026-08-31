import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _dayMonthFormat = DateFormat('dd MMM', 'vi');

  static String formatDate(DateTime date) => _dateFormat.format(date);
  static String formatDateTime(DateTime date) => _dateTimeFormat.format(date);
  static String formatTime(DateTime date) => _timeFormat.format(date);
  static String formatDayMonth(DateTime date) => _dayMonthFormat.format(date);

  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final itemDate = DateTime(date.year, date.month, date.day);
    final difference = today.difference(itemDate).inDays;

    if (difference == 0) {
      return 'Hôm nay, ${_timeFormat.format(date)}';
    } else if (difference == 1) {
      return 'Hôm qua, ${_timeFormat.format(date)}';
    } else if (difference < 7) {
      return '$difference ngày trước';
    } else {
      return _dateFormat.format(date);
    }
  }
}
