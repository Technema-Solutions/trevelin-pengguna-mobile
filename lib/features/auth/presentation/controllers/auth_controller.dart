import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';

class AuthController extends GetxController {
  // Dependencies
  final LoginUsecase _loginUsecase = Get.find();
  final GetStorage _storage = GetStorage();

  // Observables
  final _isLoading = false.obs;
  final _user = Rxn<User>();
  final _isLoggedIn = false.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  User? get user => _user.value;
  bool get isLoggedIn => _isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  // Check if user is already logged in
  void _checkLoginStatus() {
    final userData = _storage.read('user');
    final token = _storage.read('auth_token');

    if (userData != null && token != null) {
      _user.value = User.fromJson(userData);
      _isLoggedIn.value = true;
    }
  }

  // Login method
  Future<void> login(String email, String password) async {
    try {
      _isLoading.value = true;

      // Call login usecase (will be mock for now)
      final result = await _loginUsecase.call(email, password);

      if (result.isSuccess) {
        _user.value = result.user;
        _isLoggedIn.value = true;

        // Save to local storage
        await _storage.write('user', result.user?.toJson());
        await _storage.write('auth_token', result.token);

        Get.snackbar(
          'Success',
          'Login berhasil! Selamat datang ${result.user?.name}',
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to home
        Get.offAllNamed('/home');
      } else {
        Get.snackbar(
          'Error',
          result.message ?? 'Login gagal',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  // Register method
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      _isLoading.value = true;

      // Mock registration success
      await Future.delayed(const Duration(seconds: 2));

      // Create mock user
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        createdAt: DateTime.now(),
      );

      _user.value = newUser;
      _isLoggedIn.value = true;

      // Save to storage
      await _storage.write('user', newUser.toJson());
      await _storage.write('auth_token', 'mock_token_${newUser.id}');

      Get.snackbar(
        'Success',
        'Registrasi berhasil! Selamat datang $name',
        snackPosition: SnackPosition.TOP,
      );

      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Registrasi gagal: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  // Logout method
  Future<void> logout() async {
    await _storage.erase();
    _user.value = null;
    _isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }

  // Biometric login (placeholder for now)
  Future<void> loginWithBiometric() async {
    Get.snackbar(
      'Info',
      'Fitur biometric akan diimplementasi di Phase 3',
      snackPosition: SnackPosition.TOP,
    );
  }
}
