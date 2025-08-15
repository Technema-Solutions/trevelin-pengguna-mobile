import 'package:flutter_test/flutter_test.dart';
import 'package:trevelin_mobile_app/core/utils/retry.dart';

void main() {
  test('retries until success or max attempts', () async {
    var attempts = 0;
    Future<void> failing() async {
      attempts++;
      if (attempts < 3) throw Exception('fail');
    }

    await retryWithBackoff(failing, maxAttempts: 3);
    expect(attempts, 3);
  });
}
