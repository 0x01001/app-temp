// import 'dart:async';
import 'dart:convert';
// import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

import '../index.dart';

class Log {
  const Log._();

  static const _enableLog = LogConfig.enableGeneralLog;

  static void d(Object? message, {String? name, DateTime? time, int? colorCode}) {
    _log('$message', name: name ?? '', time: time, colorCode: colorCode ?? 36);
  }

  static void w(Object? message, {String? name, DateTime? time, int? colorCode}) {
    _log('$message', name: name ?? '', time: time, colorCode: colorCode ?? 33);
  }

  static void i(Object? message, {String? name, DateTime? time, int? colorCode}) {
    _log('$message', name: name ?? '', time: time, colorCode: colorCode ?? 35);
  }

  static void r(Object? message, {String? name, DateTime? time, int? colorCode}) {
    _log('$message', name: name ?? '', time: time, colorCode: colorCode ?? 32);
  }

  static void e(Object? errorMessage, {String? name, Object? errorObject, StackTrace? stackTrace, DateTime? time, int? colorCode}) {
    _log('$errorMessage', name: name ?? '', error: errorObject, stackTrace: stackTrace, time: time, colorCode: colorCode ?? 31);
  }

  static String prettyJson(Map<String, dynamic> json) {
    if (!LogConfig.isPrettyJson) {
      return json.toString();
    }

    final indent = '  ' * 2;
    final encoder = JsonEncoder.withIndent(indent);

    return encoder.convert(json);
  }

  static void _log(
    String message, {
    // int level = 0,
    String name = '',
    DateTime? time,
    // int? sequenceNumber,
    // Zone? zone,
    Object? error,
    StackTrace? stackTrace,
    int? colorCode,
  }) {
    if (_enableLog) {
      var msg = '${time ?? DateTime.now()}:${name != '' ? ' $name:' : ''} $message';
      if (colorCode != null) {
        msg = '\u001b[$colorCode' 'm' '$msg' '\u001b[0m';
      }
      debugPrint(msg);
      // dev.log(
      //   message,
      //   name: name,
      //   time: time,
      //   // sequenceNumber: sequenceNumber,
      //   // level: level,
      //   // zone: zone,
      //   error: error,
      //   stackTrace: stackTrace,
      // );
    }
  }
}
