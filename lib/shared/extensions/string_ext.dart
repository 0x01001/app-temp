// import 'dart:ui';

// import 'package:intl/intl.dart'; 
// import 'package:timeago/timeago.dart' as timeago;

// extension StringCasingExtension on String {
//   String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
//   String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');

//   String removeDuplicateWhitespaces() {
//     return replaceAll(RegExp(' +'), ' ');
//   }

//   String convertToSnakeString() {
//     return trim().removeDuplicateWhitespaces().replaceAll(' ', '_');
//   }

//   String get fromSecondToMinutesgInRace {
//     final int second = int.tryParse(this) ?? 0;
//     final hours = Duration(seconds: second).inHours;
//     final minutes = Duration(seconds: second - (hours * 3600)).inMinutes;
//     final seconds = second - (hours * 3600) - (minutes * 60);
//     final String resultSeconds = '${seconds}s';
//     final String resultHours = hours > 0 ? '${hours}h:' : '';
//     final String resultMinutes = minutes > 0 ? '${minutes}m:' : '';
//     return resultHours + resultMinutes + resultSeconds;
//   }

//   String get fromSecondToMinutes {
//     final int resource = int.tryParse(this) ?? 0;
//     final minutes = Duration(seconds: resource).inMinutes;
//     final seconds = resource - (minutes * 60);
//     final String resultSeconds = seconds < 10 ? '0$seconds' : seconds.toString();
//     final String resultMinutes = minutes <= 9 ? '0$minutes' : minutes.toString();
//     return '$resultMinutes:$resultSeconds';
//   }

//   String get getLetterFullName {
//     if (isEmpty) return '';
//     final notDiacriticName = Functions.removeDiacritics(this);
//     if (length == 1) return notDiacriticName.toUpperCase();
//     String nameRaw = notDiacriticName.trim();
//     var listName = nameRaw.split(' ');
//     listName.removeWhere((element) => element == '');
//     if (listName.length == 1) {
//       return (listName[0][0] + listName[0][1]).toUpperCase();
//     }
//     return (listName[0][0] + listName.last[0]).toUpperCase();
//   }

//   bool get checkPhoneNumber {
//     const String phoneNumberlPattern = r'(09|03|07|08|05)+([0-9]{8})';
//     final RegExp regexPhoneNumber = RegExp(phoneNumberlPattern);
//     return regexPhoneNumber.hasMatch(this) && length == 10;
//   }

//   String get shortName => getLetterFullName;

//   String getStringAfterHashtag(List<String?> mentions) {
//     final listMatch = RegexPattern.regexMention.allMatches(this).toList();
//     String textCheck = '';
//     for (var element in listMatch) {
//       if (!mentions.contains(substring(element.start + 1, element.end).toLowerCase())) {
//         textCheck = substring(element.start + 1, element.end);
//       }
//     }
//     return textCheck.contains(' ') ? '' : textCheck;
//   }

//   String get getLetterFirstName {
//     if (length == 1) return toUpperCase();
//     String nameRaw = trim();
//     var listName = nameRaw.split('');
//     return listName[0].toUpperCase();
//   }

//   DateTime get fromStringToDate {
//     return DateTime.parse(this);
//   }

//   DateTime get fromStringToDateWithFormatDDMMYYYY {
//     DateFormat dateFormat = DateFormat('dd/MM/yyyy');
//     return dateFormat.parse(this);
//   }

//   String get getDateFromString {
//     DateFormat transactionDateFormatToServer = DateFormat('dd/MM/yyyy');
//     return transactionDateFormatToServer.format(DateTime.parse(this));
//   }

//   String convertToDateStringWithFormat(String format, {String locale = 'vi_VN'}) {
//     DateFormat formatter = DateFormat(format, locale);
//     return formatter.format(DateTime.parse(this));
//   }

//   String get getDateMonthFromString {
//     DateFormat transactionDateFormatToServer = DateFormat('dd/MM | hh:mm a');
//     return transactionDateFormatToServer.format(DateTime.parse(this));
//   }

//   int? get tryToParseInt {
//     return int.tryParse(this);
//   }

//   String get getDateTimeFromString {
//     DateTime tempDate = DateTime.parse('${this}z');
//     DateFormat transactionDateFormat = DateFormat('dd/MM/yyyy_hh:mm a');
//     return transactionDateFormat.format(tempDate.toLocal());
//   }

//   String get getNameInMail {
//     return (substring(0, (contains('@')) ? indexOf('@') : null)).toCapitalized();
//   }

//   String get getDateTimeFromStringToVPRace {
//     DateTime tempDate = DateTime.parse('${this}z');
//     DateFormat transactionDateFormat = DateFormat('HH:mm - dd/MM/yyyy');
//     return transactionDateFormat.format(tempDate);
//   }

//   String get getDateTimeFromStringToEvent {
//     DateTime tempDate = DateTime.parse('${this}z');
//     DateFormat transactionDateFormat = DateFormat('HH:mm - dd/MM/yyyy');
//     return transactionDateFormat.format(tempDate);
//   }

//   String get timeUntil {
//     final date = fromStringToDate;
//     return timeago.format(date, locale: 'vi', allowFromNow: true);
//   }

//   String get timeUntilShort {
//     final date = fromStringToDate;
//     // timeago.setLocaleMessages('vi', timeago.ViShortMessages());
//     // timeago.setLocaleMessages('vi', timeago.ViMessages());
//     return timeago.format(date, locale: 'vi', allowFromNow: true);
//   }

//   Color get getColorForLetterFullName {
//     const list = ColorPalette.collectionColor;
//     if (isEmpty) return list[0];
//     final removedDiacriticsName = notDiacriticsString;
//     final firstLetter = removedDiacriticsName[0].toUpperCase();
//     if ([
//       'A',
//       'B',
//       'C',
//     ].contains(firstLetter)) {
//       return list[0];
//     } else if ([
//       'D',
//       'E',
//       'F',
//     ].contains(firstLetter)) {
//       return list[1];
//     } else if ([
//       'G',
//       'H',
//       'I',
//     ].contains(firstLetter)) {
//       return list[2];
//     } else if ([
//       'J',
//       'K',
//       'L',
//     ].contains(firstLetter)) {
//       return list[3];
//     } else if ([
//       'M',
//       'N',
//       'O',
//     ].contains(firstLetter)) {
//       return list[4];
//     } else if ([
//       'P',
//       'Q',
//       'R',
//     ].contains(firstLetter)) {
//       return list[5];
//     } else if ([
//       'S',
//       'T',
//       'U',
//     ].contains(firstLetter)) {
//       return list[6];
//     } else if ([
//       'V',
//       'W',
//       'X',
//     ].contains(firstLetter)) {
//       return list[7];
//     } else if ([
//       'Y',
//       'Z',
//     ].contains(firstLetter)) {
//       return list[8];
//     } else {
//       return list[8];
//     }
//   }

//   String get notDiacriticsString {
//     return Functions.removeDiacritics(this);
//   }

//   String get removeDiacritics {
//     return Functions.removeDiacritics(this).toLowerCase();
//   }

//   bool get isNotBlank {
//     if (this != '') {
//       return true;
//     }
//     return false;
//   }
// }
