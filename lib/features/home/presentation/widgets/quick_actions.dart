import 'package:flutter/material.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/app_text_styles.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onSpeedboatTap;
  final VoidCallback onPackageTap;
  final VoidCallback onTicketsTap;

  const QuickActions({
    Key? key,
    required this.onSpeedboatTap,
    required this.onPackageTap,
    required this.onTicketsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.snowWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aksi Cepat',
            style: AppTextStyles.subtitle1.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  icon: Icons.directions_boat,
                  title: 'Speedboat',
                  subtitle: 'Pesan tiket',
                  color: AppTheme.oceanBlue,
                  onTap: onSpeedboatTap,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  icon: Icons.landscape,
                  title: 'Paket Wisata',
                  subtitle: 'Jelajahi destinasi',
                  color: AppTheme.seafoam,
                  onTap: onPackageTap,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionCard(
                  icon: Icons.confirmation_number,
                  title: 'Tiket Saya',
                  subtitle: 'Lihat booking',
                  color: AppTheme.coralOrange,
                  onTap: onTicketsTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppTheme.snowWhite,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTextStyles.body2.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.charcoal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.caption.copyWith(
                color: AppTheme.silver,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
