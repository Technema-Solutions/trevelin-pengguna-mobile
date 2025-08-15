import 'package:flutter/foundation.dart';

/// Abstraction around crash reporting so implementations can be swapped.
abstract class CrashReporter {
  Future<void> init();
  void recordError(Object error, StackTrace stack,
      {Map<String, String>? tags});
  void setUserId(String? id);
}

/// Default console implementation which simply prints errors.
class CrashReporterConsole implements CrashReporter {
  @override
  Future<void> init() async {}

  @override
  void recordError(Object error, StackTrace stack,
      {Map<String, String>? tags}) {
    debugPrint('[CRASH] $error\n$stack');
  }

  @override
  void setUserId(String? id) {}
}

// TODO: add CrashReporterFirebase implementation when Firebase is configured.
