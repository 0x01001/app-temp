// ignore: depend_on_referenced_packages

import 'package:intl/intl.dart';

import '../index.dart';

const double screenWidthInDesign = 375.0;
const double screenHeightInDesign = 812.0;

extension ExtendedNumber on num {
  double get toScreenSize {
    return (this / screenWidthInDesign) * AppSize.screenWidth;
  }

  double get toScreenWidthHeight {
    const double designRatio = screenWidthInDesign / screenHeightInDesign; // iphone 12 pro max
    return (this * designRatio) / AppSize.sizeRatio;
  }

  String get toCurrencyString {
    // return NumberFormat.currency(locale: 'vi_VN').format(this);
    final oCcy = NumberFormat('#,###.##', 'en_US');
    return '${oCcy.format(this)} VND';
  }

  String get toCurrency {
    final oCcy = NumberFormat('#,###.##', 'en_US');
    return oCcy.format(this);
  }

  String get toNonZerosTrailingString {
    final RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    return toString().replaceAll(regex, '');
  }

  String get fromMetToKilometShowingInRace {
    return (((this as double?) ?? 0.0) / 1000).toStringAsFixed(2);
  }
}

extension MapToNum on Map<dynamic, dynamic> {
  int? toIntSafety(String key) {
    if ((this[key] is String) == true) {
      return int.tryParse(this[key]);
    }
    return (this[key] as num?)?.toInt();
  }

  double? toDoubleSafety(String key) {
    if ((this[key] is String) == true) {
      return double.tryParse(this[key]);
    }
    return (this[key] as num?)?.toDouble();
  }
}

extension IntervalNumber on num {
  // get duration by seconds
  Duration get s {
    return Duration(seconds: toInt());
  }

  // get duration by miliseconds
  Duration get ms {
    return Duration(milliseconds: toInt());
  }
}
