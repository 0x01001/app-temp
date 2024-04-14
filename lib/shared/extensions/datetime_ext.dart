import 'package:intl/intl.dart';

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
}
