/// Retry a future-returning function with exponential backoff.
import 'dart:math';

/// Retry a future-returning function with jittered exponential backoff.
///
/// Each retry waits for `baseDelay * 2^(attempt-1)` and applies random jitter
/// up to that duration to prevent thundering herds.
Future<T> retryWithBackoff<T>(
  Future<T> Function() fn, {
  int maxAttempts = 6,
  Duration baseDelay = const Duration(milliseconds: 500),
}) async {
  var attempt = 0;
  final rand = Random();
  while (true) {
    try {
      return await fn();
    } catch (_) {
      attempt++;
      if (attempt >= maxAttempts) rethrow;
      final exp = baseDelay.inMilliseconds * pow(2, attempt - 1);
      final jitterMs = rand.nextInt(exp.toInt() + 1);
      await Future.delayed(Duration(milliseconds: jitterMs));
    }
  }
}
