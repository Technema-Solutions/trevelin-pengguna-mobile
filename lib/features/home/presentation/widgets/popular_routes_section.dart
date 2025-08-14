import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../speedboat/domain/entities/speedboat_ticket.dart';

class PopularRoutesSection extends StatelessWidget {
  final List<SpeedboatTicket> routes;
  final bool isLoading;
  final Function(String) onRouteTap;
  final VoidCallback onSeeAllTap;

  const PopularRoutesSection({
    Key? key,
    required this.routes,
    required this.isLoading,
    required this.onRouteTap,
    required this.onSeeAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          // Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.directions_boat,
                      color: AppTheme.oceanBlue,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Rute Populer',
                      style: AppTextStyles.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onSeeAllTap,
                  child: Text(
                    'Lihat Semua',
                    style: AppTextStyles.body2.copyWith(
                      color: AppTheme.oceanBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Routes List
          isLoading
              ? _buildLoadingState()
              : SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: routes.length,
                    itemBuilder: (context, index) {
                      final route = routes[index];
                      return Container(
                        width: 280,
                        margin: EdgeInsets.only(
                          right: index == routes.length - 1 ? 0 : 12,
                        ),
                        child: _buildRouteCard(route),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 280,
            margin: EdgeInsets.only(right: index == 2 ? 0 : 12),
            decoration: BoxDecoration(
              color: AppTheme.silver.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRouteCard(SpeedboatTicket route) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return GestureDetector(
      onTap: () => onRouteTap(route.id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.snowWhite,
          borderRadius: BorderRadius.circular(12),
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
            // Route and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        route.from,
                        style: AppTextStyles.subtitle2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: AppTheme.oceanBlue,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        route.to,
                        style: AppTextStyles.subtitle2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(route.status).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getStatusText(route.status),
                    style: AppTextStyles.caption.copyWith(
                      color: _getStatusColor(route.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Boat Info
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.oceanBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.directions_boat,
                    color: AppTheme.oceanBlue,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        route.boatName,
                        style: AppTextStyles.body2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        route.serviceType == ServiceType.reguler
                            ? 'Reguler'
                            : 'Non-Reguler',
                        style: AppTextStyles.caption.copyWith(
                          color: AppTheme.silver,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Time and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${route.departureTime} - ${route.arrivalTime}',
                      style: AppTextStyles.body2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      route.duration,
                      style: AppTextStyles.caption.copyWith(
                        color: AppTheme.silver,
                      ),
                    ),
                  ],
                ),
                Text(
                  currencyFormatter.format(route.price),
                  style: AppTextStyles.subtitle2.copyWith(
                    color: AppTheme.oceanBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'available':
        return AppTheme.seafoam;
      case 'limited':
        return AppTheme.coralOrange;
      case 'full':
        return Colors.red;
      default:
        return AppTheme.silver;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'available':
        return 'Tersedia';
      case 'limited':
        return 'Terbatas';
      case 'full':
        return 'Penuh';
      default:
        return 'Unknown';
    }
  }
}
