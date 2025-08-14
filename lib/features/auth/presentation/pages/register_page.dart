import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_input_field.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authController = Get.find<AuthController>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sandBeige,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.charcoal),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),

                const SizedBox(height: 32),

                // Full Name
                CustomInputField(
                  label: 'Nama Lengkap',
                  hint: 'Masukkan nama lengkap Anda',
                  controller: _nameController,
                  prefixIcon: Icons.person_outlined,
                  validator: _validateName,
                ),

                const SizedBox(height: 20),

                // Email
                CustomInputField(
                  label: 'Email',
                  hint: 'Masukkan email Anda',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: _validateEmail,
                ),

                const SizedBox(height: 20),

                // Phone
                CustomInputField(
                  label: 'Nomor Telepon',
                  hint: 'Masukkan nomor telepon Anda',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  validator: _validatePhone,
                ),

                const SizedBox(height: 20),

                // Password
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

                const SizedBox(height: 20),

                // Confirm Password
                CustomInputField(
                  label: 'Konfirmasi Password',
                  hint: 'Masukkan ulang password Anda',
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: _obscureConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onSuffixTap: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  validator: _validateConfirmPassword,
                ),

                const SizedBox(height: 24),

                // Terms & Conditions
                _buildTermsCheckbox(),

                const SizedBox(height: 32),

                // Register Button
                Obx(() => CustomButton(
                      text: 'Daftar',
                      onPressed: _agreeToTerms ? _handleRegister : null,
                      isLoading: _authController.isLoading,
                      icon: Icons.person_add,
                    )),

                const SizedBox(height: 24),

                // Login Link
                _buildLoginLink(),
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
        Text(
          'Daftar Akun Baru',
          style: AppTextStyles.headline1,
        ),
        const SizedBox(height: 8),
        Text(
          'Buat akun untuk menikmati semua fitur Trevelin',
          style: AppTextStyles.body1.copyWith(
            color: AppTheme.silver,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
          activeColor: AppTheme.oceanBlue,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _agreeToTerms = !_agreeToTerms;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.body2,
                  children: [
                    const TextSpan(text: 'Saya setuju dengan '),
                    TextSpan(
                      text: 'Syarat & Ketentuan',
                      style: AppTextStyles.body2.copyWith(
                        color: AppTheme.oceanBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: ' dan '),
                    TextSpan(
                      text: 'Kebijakan Privasi',
                      style: AppTextStyles.body2.copyWith(
                        color: AppTheme.oceanBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sudah punya akun? ',
          style: AppTextStyles.body2,
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: Text(
            'Masuk di sini',
            style: AppTextStyles.body2.copyWith(
              color: AppTheme.oceanBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // Validation methods
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (value.length < 2) {
      return 'Nama minimal 2 karakter';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    if (value.length < 10) {
      return 'Nomor telepon minimal 10 digit';
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    if (value != _passwordController.text) {
      return 'Password tidak sama';
    }
    return null;
  }

  // Event handlers
  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        Get.snackbar(
          'Error',
          'Anda harus menyetujui syarat & ketentuan',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      _authController.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
      );
    }
  }
}
