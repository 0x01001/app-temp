import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../index.dart';

extension DateTimeExt on DateTime {
  String get toQueryFormattedString => DateFormat('yyyy-MM-dd').format(this);
  String get toFullQueryFormattedString => DateFormat('yyyy-MM-ddThh:mm:ss').format(this);
  String get toFullQueryFormattedStartDayString => DateFormat('yyyy-MM-ddT00:00:00').format(this);
  String get toFormattedStringShowing => DateFormat('dd/MM/yyyy').format(this);
  String get toFullDateTimeFormat => DateFormat('HH:mm:ss dd/MM/yyyy').format(this);
  String get toShowFullDayAndHour => DateFormat('EEE, HH:mm dd/MM/yyyy').format(this);

  String get helloString {
    return hour < 12
        ? 'good_morning'
        : hour < 18
            ? 'good_afternoon'
            : 'good_evening';
  }

  bool isSameDate(DateTime? other) {
    return year == other?.year && month == other?.month && day == other?.day;
  }

  String convertToDateStringWithFormat(String format, {String locale = 'vi_VN'}) {
    final DateFormat formatter = DateFormat(format, locale);
    return formatter.format(this);
  }

  String toStringWithFormat(String format) {
    return DateFormat(format).format(this);
  }

  DateTime get lastDateOfMonth {
    return DateTime(year, month + 1, 0);
  }

  Map<String, tz.Location> get getTimeZoneDatabase {
    tz.initializeTimeZones();

    return tz.timeZoneDatabase.locations;
  }

  int _getESTtoUTCDifference(String locationName) {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation(locationName);
    final tz.TZDateTime nowNY = tz.TZDateTime.now(locationNY);

    return nowNY.timeZoneOffset.inHours;
  }

  DateTime toESTzone(String locationName) {
    DateTime result = toUtc(); // local time to UTC
    result = result.add(Duration(hours: _getESTtoUTCDifference(locationName))); // convert UTC to EST

    return result;
  }

  DateTime fromESTzone(String locationName) {
    DateTime result = subtract(Duration(hours: _getESTtoUTCDifference(locationName))); // convert EST to UTC

    String dateTimeAsIso8601String = result.toIso8601String();
    dateTimeAsIso8601String += dateTimeAsIso8601String.characters.last.equalsIgnoreCase('Z') ? '' : 'Z';
    result = DateTime.parse(dateTimeAsIso8601String); // make isUtc to be true

    result = result.toLocal(); // convert UTC to local time

    return result;
  }

  DateTime toOneMonthAgo() {
    int targetMonth = month - 1;
    int targetYear = year;
    if (targetMonth < 1) {
      targetMonth = 12;
      targetYear--;
    }
    final int daysInMonth = DateTime(targetYear, targetMonth + 1, 0).day;
    final int targetDay = min(day, daysInMonth);
    final DateTime oneMonthAgo = DateTime(targetYear, targetMonth, targetDay);
    return oneMonthAgo;
  }

  DateTime toOneYearAgo() {
    final int targetYear = year - 1; // Subtract one year
    final int targetMonth = month; // Keep the same month

    // Find the last valid day in the target month and year
    final int daysInMonth = DateTime(targetYear, targetMonth + 1, 0).day;
    final int targetDay = min(day, daysInMonth);
    final DateTime oneYearAgo = DateTime(targetYear, targetMonth, targetDay);

    return oneYearAgo;
  }

  String toTimeAgo({String? lang, bool useShort = false}) {
    try {
      return timeago.format(this, locale: useShort ? 'en_short' : lang, allowFromNow: true);
    } catch (e) {
      return '';
    }
  }
}
