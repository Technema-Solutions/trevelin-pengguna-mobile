import 'package:logger/logger.dart';

/// Global application logger using the [logger] package.
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  static void d(String message, [dynamic data]) => _logger.d(message, data);

  static void e(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);
}
