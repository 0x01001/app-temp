import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension StringExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');

  String removeDuplicateWhitespaces() {
    return replaceAll(RegExp(' +'), ' ');
  }

  String convertToSnakeString() {
    return trim().removeDuplicateWhitespaces().replaceAll(' ', '_');
  }

  String get fromSecondToMinutesgInRace {
    final int second = int.tryParse(this) ?? 0;
    final hours = Duration(seconds: second).inHours;
    final minutes = Duration(seconds: second - (hours * 3600)).inMinutes;
    final seconds = second - (hours * 3600) - (minutes * 60);
    final String resultHours = hours > 0 ? '${hours}h:' : '';
    final String resultMinutes = minutes > 0 ? '${minutes}m:' : '';
    final String resultSeconds = '${seconds}s';
    return resultHours + resultMinutes + resultSeconds;
  }

  String get fromSecondToMinutes {
    final int resource = int.tryParse(this) ?? 0;
    final minutes = Duration(seconds: resource).inMinutes;
    final seconds = resource - (minutes * 60);
    final String resultSeconds = seconds < 10 ? '0$seconds' : seconds.toString();
    final String resultMinutes = minutes <= 9 ? '0$minutes' : minutes.toString();
    return '$resultMinutes:$resultSeconds';
  }

  DateTime get fromStringToDate {
    return DateTime.parse(this);
  }

  DateTime get fromStringToDateWithFormatDDMMYYYY {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.parse(this);
  }

  String get getDateFromString {
    final DateFormat transactionDateFormatToServer = DateFormat('dd/MM/yyyy');
    return transactionDateFormatToServer.format(DateTime.parse(this));
  }

  String convertToDateStringWithFormat(String format, {String locale = 'vi_VN'}) {
    final DateFormat formatter = DateFormat(format, locale);
    return formatter.format(DateTime.parse(this));
  }

  String get getDateMonthFromString {
    final DateFormat transactionDateFormatToServer = DateFormat('dd/MM | hh:mm a');
    return transactionDateFormatToServer.format(DateTime.parse(this));
  }

  int? get tryToParseInt {
    return int.tryParse(this);
  }

  String get getDateTimeFromString {
    final DateTime tempDate = DateTime.parse('${this}z');
    final DateFormat transactionDateFormat = DateFormat('dd/MM/yyyy_hh:mm a');
    return transactionDateFormat.format(tempDate.toLocal());
  }

  String get getNameInMail {
    return substring(0, (contains('@')) ? indexOf('@') : null).toCapitalized();
  }

  String get getDateTimeFromStringToVPRace {
    final DateTime tempDate = DateTime.parse('${this}z');
    final DateFormat transactionDateFormat = DateFormat('HH:mm - dd/MM/yyyy');
    return transactionDateFormat.format(tempDate);
  }

  String get getDateTimeFromStringToEvent {
    final DateTime tempDate = DateTime.parse('${this}z');
    final DateFormat transactionDateFormat = DateFormat('HH:mm - dd/MM/yyyy');
    return transactionDateFormat.format(tempDate);
  }

  String get timeUntil {
    final date = fromStringToDate;
    return timeago.format(date, locale: 'vi', allowFromNow: true);
  }

  String get timeUntilShort {
    final date = fromStringToDate;
    return timeago.format(date, locale: 'vi', allowFromNow: true);
  }

  static const fullWidthRegExp = r'([\uff01-\uff5e])';
  static const halfWidthRegExp = r'([\u0021-\u007e])';
  static const halfFullWidthDelta = 0xfee0;

  String _convertWidth(String regExpPattern, int delta) {
    return replaceAllMapped(RegExp(regExpPattern), (m) => String.fromCharCode(m[1]!.codeUnits[0] + delta));
  }

  String toFullWidth() => _convertWidth(halfWidthRegExp, halfFullWidthDelta);
  String toHalfWidth() => _convertWidth(fullWidthRegExp, -halfFullWidthDelta);

  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r'^\+?0[0-9]{10}$');
    return phoneRegExp.hasMatch(this);
  }

  String plus(String other) {
    return this + other;
  }

  String? get firstOrNull => isNotEmpty ? this[0] : null;

  bool equalsIgnoreCase(String secondString) => toLowerCase().contains(secondString.toLowerCase());

  bool containsIgnoreCase(String secondString) => toLowerCase().contains(secondString.toLowerCase());

  String replaceLast({
    required Pattern pattern,
    required String replacement,
  }) {
    final match = pattern.allMatches(this).lastOrNull;
    if (match == null) {
      return this;
    }
    final prefix = substring(0, match.start);
    final suffix = substring(match.end);

    return '$prefix$replacement$suffix';
  }

  String get hardcoded => this;
}
