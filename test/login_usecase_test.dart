import 'package:flutter_test/flutter_test.dart';
import 'package:trevelin_mobile_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:trevelin_mobile_app/shared/domain/entities/user.dart';

void main() {
  final usecase = LoginUsecase();

  test('returns user and token for valid credentials', () async {
    final result = await usecase.call('user@example.com', 'password');
    expect(result.isSuccess, isTrue);
    expect(result.user, isA<User>());
    expect(result.token, isNotNull);
  });

  test('fails for invalid credentials', () async {
    final result = await usecase.call('wrong@example.com', 'invalid');
    expect(result.isSuccess, isFalse);
    expect(result.user, isNull);
    expect(result.token, isNull);
  });
}
