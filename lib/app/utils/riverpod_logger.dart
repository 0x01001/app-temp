// ignore_for_file: avoid_print
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/index.dart';

class RiverpodLogger extends ProviderObserver {
  @override
  void didAddProvider(ProviderBase<dynamic> provider, Object? value, ProviderContainer container) {
    Log.i('didAddProvider → ${provider.name ?? provider.runtimeType}');
  }

  @override
  void didUpdateProvider(ProviderBase<dynamic> provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    Log.i('didUpdateProvider → ${provider.name ?? provider.runtimeType},  "newValue": "$newValue"');
  }

  @override
  void providerDidFail(ProviderBase<Object?> provider, Object error, StackTrace stackTrace, ProviderContainer container) {
    Log.i('providerDidFail → $provider threw $error at $stackTrace');
  }

  @override
  void didDisposeProvider(ProviderBase<dynamic> provider, ProviderContainer container) {
    Log.i('didDisposeProvider → ${provider.name ?? provider.runtimeType}');
  }
}
