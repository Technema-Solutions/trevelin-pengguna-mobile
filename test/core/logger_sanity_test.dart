import 'package:flutter_test/flutter_test.dart';
import 'package:trevelin_mobile_app/core/logging/app_logger.dart';

void main() {
  test('logger methods execute without throwing', () {
    expect(() => AppLogger.d('debug message'), returnsNormally);
    expect(
        () => AppLogger.e('error message', Exception('oops'), StackTrace.current),
        returnsNormally);
  });
}
