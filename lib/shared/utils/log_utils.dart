// import 'dart:async';
import 'dart:convert';

// import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

import '../index.dart';

class Log {
  const Log._();

  static const _enableLog = true; // Constant.enableGeneralLog; //TODO: need uncomment before go live
  static final _stopwatch = Stopwatch();

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

  static void start(Object? message) {
    if (_enableLog) {
      _stopwatch.reset();
      _stopwatch.start();
    }
    d(message);
  }

  static void end(Object? message) {
    if (_enableLog) _stopwatch.stop();
    d('${message ?? ''}: ${_stopwatch.elapsed.inMilliseconds} milliseconds');
  }

  static String prettyJson(Map<String, dynamic> json) {
    if (!Constant.isPrettyJson) {
      return json.toString();
    }

    final indent = '  ' * 2;
    final encoder = JsonEncoder.withIndent(indent);

    return encoder.convert(json);
  }

  static void _log(String message, {String name = '', DateTime? time, Object? error, StackTrace? stackTrace, int? colorCode}) {
    if (_enableLog) {
      var msg = '${time ?? DateTime.now()}:${name != '' ? ' $name:' : ''} $message';
      if (colorCode != null) {
        msg = '\u001b[$colorCode' 'm' '$msg' '\u001b[0m';
      }
      debugPrint(msg);
    }
  }

  /// Helper function to extract the current method name from the stack trace
  // ignore: unused_element
  static String _getCurrentMethodName() {
    final frames = StackTrace.current.toString().split('\n');
    // The second frame in the stack trace contains the current method
    final frame = frames.elementAtOrNull(1);
    if (frame != null) {
      // Extract the method name from the frame. For example, given this input string:
      // #1      LoggerAnalyticsClient.trackAppOpen (package:flutter_ship_app/src/monitoring/logger_analytics_client.dart:28:9)
      // The code will return: LoggerAnalyticsClient.trackAppOpen
      final tokens = frame.replaceAll('<anonymous closure>', '<anonymous_closure>').split(' ');
      final methodName = tokens.elementAtOrNull(tokens.length - 2);
      if (methodName != null) {
        // if the class name is included, remove it, otherwise return as is
        final methodTokens = methodName.split('.');
        // ignore_for_file:avoid-unsafe-collection-methods
        return methodTokens.length >= 2 && methodTokens[1] != '<anonymous_closure>' ? (methodTokens.elementAtOrNull(1) ?? '') : methodName;
      }
    }
    return '';
  }
}
