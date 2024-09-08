import 'package:intl/intl.dart';

import '../index.dart';

class NumberFormatUtils {
  NumberFormatUtils._();

  static String formatYen(double price) {
    return NumberFormat.currency(symbol: Constant.yen, decimalDigits: 0).format(price);
  }

  static String formatNumber(int number) {
    return NumberFormat(Constant.numberFormat).format(number);
  }
}
