import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._internal();
  static final DateFormatter _instance = DateFormatter._internal();
  static DateFormatter get instance => _instance;

  static String formatDate(DateTime date, {String locale = 'en_US'}) {
    return DateFormat.yMMMd(locale).format(date);
  }

  static String formatDateWithTime(DateTime date) {
    // English format: Sep 12, 2025 12:00 PM
    return DateFormat.yMMMd(['en_US']).add_Hm().format(date);
  }

  static String formatDateWithTimeAndSeconds(DateTime date) {
    // English format: Sep 12, 2025 12:00:00 PM
    return DateFormat.yMMMd(['en_US']).add_Hms().format(date);
  }
}
