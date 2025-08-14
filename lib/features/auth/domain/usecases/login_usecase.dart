import '../../../../shared/domain/entities/user.dart';

class LoginResult {
  final bool isSuccess;
  final User? user;
  final String? token;
  final String? message;

  LoginResult({
    required this.isSuccess,
    this.user,
    this.token,
    this.message,
  });
}

class LoginUsecase {
  Future<LoginResult> call(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (email == 'user@example.com' && password == 'password') {
      final user = User(
        id: '1',
        name: 'Example User',
        email: email,
        phone: '0800000000',
        createdAt: DateTime.now(),
      );
      return LoginResult(isSuccess: true, user: user, token: 'mock_token_1');
    }

    return LoginResult(
      isSuccess: false,
      message: 'Invalid email or password',
    );
  }
}
