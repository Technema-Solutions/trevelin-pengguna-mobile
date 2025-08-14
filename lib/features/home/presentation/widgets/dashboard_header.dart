import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/domain/entities/user.dart';

class DashboardHeader extends StatelessWidget {
  final User? user;
  final VoidCallback onProfileTap;

  const DashboardHeader({
    Key? key,
    this.user,
    required this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeFormatter = DateFormat('HH:mm');
    final dateFormatter = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.oceanBlue,
            AppTheme.aquaTeal,
          ],
        ),
      ),
      child: Column(
        children: [
          // Top row with greeting and profile
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getGreeting(),
                      style: AppTextStyles.body1.copyWith(
                        color: AppTheme.snowWhite.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.name ?? 'Tamu',
                      style: AppTextStyles.headline2.copyWith(
                        color: AppTheme.snowWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onProfileTap,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppTheme.snowWhite,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.sandBeige,
                    backgroundImage: user?.avatar != null
                        ? NetworkImage(user!.avatar!)
                        : null,
                    child: user?.avatar == null
                        ? Icon(
                            Icons.person,
                            color: AppTheme.oceanBlue,
                            size: 28,
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Date and time info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.snowWhite.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.snowWhite.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: AppTheme.snowWhite,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timeFormatter.format(now),
                        style: AppTextStyles.subtitle1.copyWith(
                          color: AppTheme.snowWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dateFormatter.format(now),
                        style: AppTextStyles.body2.copyWith(
                          color: AppTheme.snowWhite.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.seafoam,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Aktif',
                    style: AppTextStyles.caption.copyWith(
                      color: AppTheme.snowWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Selamat Pagi';
    } else if (hour >= 12 && hour < 15) {
      return 'Selamat Siang';
    } else if (hour >= 15 && hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }
}
