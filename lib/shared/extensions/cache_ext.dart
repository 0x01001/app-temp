import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

extension CacheExtension on AutoDisposeRef<Object?> {
  /// Keeps the provider alive for [duration].
  void cache(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);

    // Optional: when the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);
  }
}

// you could use ref.onCancel/ref.onResume to destroy the state only if a provider hasn't been listened to for a specific amount of time.
// @riverpod
// Future<Object> example(ExampleRef ref) async {
//   /// Keeps the state alive for 5 minutes
//   ref.cacheFor(const Duration(minutes: 5));
//   return http.get(Uri.https('example.com'));
// }
