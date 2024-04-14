import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'app/index.dart';
import 'app_initializer.dart';
import 'shared/utils/log_utils.dart';

void main() => runZonedGuarded(_runMyApp, _reportError);

Future<void> _runMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  FlutterError.onError = _onError;
  FlutterError.demangleStackTrace = _demangleStackTrace;
  runApp(ProviderScope(
    observers: [RiverpodLogger()],
    child: MyApp(savedThemeMode: savedThemeMode),
  ));
  AppUtils.configLoading();
}

Future<void> _onError(FlutterErrorDetails details) async {
  Log.e('zone current print error: ${details}');
  Zone.current.handleUncaughtError(details.exception, details.stack!);
}

StackTrace _demangleStackTrace(StackTrace stack) {
  if (stack is stack_trace.Trace) return stack.vmTrace;
  if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
  return stack;
}

void _reportError(Object error, StackTrace stackTrace) {
  Log.e(error, stackTrace: stackTrace, name: 'Uncaught exception');
  // report by Firebase Crashlytics here
}
