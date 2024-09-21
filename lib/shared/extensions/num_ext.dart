// ignore: depend_on_referenced_packages

import 'package:intl/intl.dart';

import '../index.dart';

extension NumberExtensions on num {
  double get toScreenSize {
    return (this / Constant.designDeviceWidth) * AppSize.screenWidth;
  }

  double get toScreenWidthHeight {
    const double designRatio = Constant.designDeviceWidth / Constant.designDeviceHeight; // iphone 12 pro max
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

  // get duration by seconds
  Duration get s {
    return Duration(seconds: toInt());
  }

  // get duration by miliseconds
  Duration get ms {
    return Duration(milliseconds: toInt());
  }

  num plus(num other) {
    return this + other;
  }

  num minus(num other) {
    return this - other;
  }

  num times(num other) {
    return this * other;
  }

  num div(num other) {
    return this / other;
  }
}

extension IntExtensions on int {
  int plus(int other) {
    return this + other;
  }

  int minus(int other) {
    return this - other;
  }

  int times(int other) {
    return this * other;
  }

  double div(int other) {
    return this / other;
  }

  int truncateDiv(int other) {
    return this ~/ other;
  }
}

extension DoubleExtensions on double {
  double plus(double other) {
    return this + other;
  }

  double minus(double other) {
    return this - other;
  }

  double times(double other) {
    return this * other;
  }

  double div(double other) {
    return this / other;
  }
}
