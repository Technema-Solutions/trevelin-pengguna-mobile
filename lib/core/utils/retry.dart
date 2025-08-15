/// Retry a future-returning function with exponential backoff.
Future<T> retryWithBackoff<T>(
  Future<T> Function() fn, {
  int maxAttempts = 6,
}) async {
  var attempt = 0;
  var delay = const Duration(seconds: 1);
  late T result;
  while (true) {
    try {
      result = await fn();
      return result;
    } catch (_) {
      attempt++;
      if (attempt >= maxAttempts) rethrow;
      await Future.delayed(delay);
      delay *= 2;
    }
  }
}
