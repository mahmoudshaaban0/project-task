import 'package:intl/intl.dart';

abstract final class MoneyFormatter {
  static String format({
    required int amountInFils,
    required String currency,
    required String locale,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      name: currency,
      symbol: '$currency ',
      decimalDigits: 2,
    );

    return formatter.format(amountInFils / 100);
  }
}
