import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_input_field.dart';
import '../../presentation/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = Get.find<AuthController>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sandBeige,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Header
                _buildHeader(),

                const SizedBox(height: 40),

                // Email Input
                CustomInputField(
                  label: 'Email',
                  hint: 'Masukkan email Anda',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: _validateEmail,
                ),

                const SizedBox(height: 20),

                // Password Input
                CustomInputField(
                  label: 'Password',
                  hint: 'Masukkan password Anda',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onSuffixTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  validator: _validatePassword,
                ),

                const SizedBox(height: 12),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _handleForgotPassword,
                    child: Text(
                      'Lupa Password?',
                      style: AppTextStyles.body2.copyWith(
                        color: AppTheme.oceanBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Login Button
                Obx(() => CustomButton(
                      text: 'Masuk',
                      onPressed: _handleLogin,
                      isLoading: _authController.isLoading,
                      icon: Icons.login,
                    )),

                const SizedBox(height: 16),

                // Biometric Login
                CustomButton(
                  text: 'Login dengan Biometric',
                  onPressed: _authController.loginWithBiometric,
                  isOutlined: true,
                  icon: Icons.fingerprint,
                ),

                const SizedBox(height: 32),

                // Register Link
                _buildRegisterLink(),

                const SizedBox(height: 24),

                // Guest Access
                _buildGuestAccess(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo placeholder
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppTheme.oceanBlue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.directions_boat,
            color: AppTheme.snowWhite,
            size: 32,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          'Selamat Datang!',
          style: AppTextStyles.headline1,
        ),

        const SizedBox(height: 8),

        Text(
          'Masuk ke akun Anda untuk melanjutkan perjalanan',
          style: AppTextStyles.body1.copyWith(
            color: AppTheme.silver,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Belum punya akun? ',
          style: AppTextStyles.body2,
        ),
        GestureDetector(
          onTap: () => Get.toNamed('/register'),
          child: Text(
            'Daftar di sini',
            style: AppTextStyles.body2.copyWith(
              color: AppTheme.oceanBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuestAccess() {
    return Column(
      children: [
        Text(
          'atau',
          style: AppTextStyles.body2.copyWith(
            color: AppTheme.silver,
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => Get.offAllNamed('/home'),
          child: Text(
            'Lanjutkan sebagai Tamu',
            style: AppTextStyles.body2.copyWith(
              color: AppTheme.oceanBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Validation methods
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  // Event handlers
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _authController.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void _handleForgotPassword() {
    Get.dialog(
      AlertDialog(
        title: const Text('Reset Password'),
        content: const Text(
          'Fitur reset password akan diimplementasi di update selanjutnya.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
