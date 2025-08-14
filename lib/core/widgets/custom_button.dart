import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final IconData? icon;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 48,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: isOutlined
          ? OutlinedButton.icon(
              onPressed: isLoading ? null : onPressed,
              icon: _buildIcon(),
              label: _buildLabel(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: backgroundColor ?? AppTheme.oceanBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          : ElevatedButton.icon(
              onPressed: isLoading ? null : onPressed,
              icon: _buildIcon(),
              label: _buildLabel(),
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? AppTheme.oceanBlue,
                foregroundColor: textColor ?? AppTheme.snowWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
    );
  }

  Widget _buildIcon() {
    if (isLoading) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Icon(icon, size: 18);
    }

    return const SizedBox.shrink();
  }

  Widget _buildLabel() {
    return Text(
      isLoading ? 'Loading...' : text,
      style: AppTextStyles.button.copyWith(
        color: isOutlined
            ? (backgroundColor ?? AppTheme.oceanBlue)
            : (textColor ?? AppTheme.snowWhite),
      ),
    );
  }
}
