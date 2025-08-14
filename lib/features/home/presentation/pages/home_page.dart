import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/quick_actions.dart';
import '../widgets/popular_routes_section.dart';
import '../../widgets/popular_packages_section.dart';
import '../widgets/recent_activities_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppTheme.sandBeige,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: homeController.refreshData,
          color: AppTheme.oceanBlue,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Dashboard Header
                DashboardHeader(
                  user: authController.user,
                  onProfileTap: homeController.navigateToProfile,
                ),

                // Quick Actions
                QuickActions(
                  onSpeedboatTap: homeController.navigateToSpeedboatSearch,
                  onPackageTap: homeController.navigateToPackageSearch,
                  onTicketsTap: homeController.navigateToTickets,
                ),

                // Promotional Banner (Placeholder)
                _buildPromoBanner(),

                // Popular Routes Section
                Obx(() => PopularRoutesSection(
                      routes: homeController.popularRoutes,
                      isLoading: homeController.isLoading,
                      onRouteTap: homeController.navigateToSpeedboatDetail,
                      onSeeAllTap: homeController.navigateToSpeedboatSearch,
                    )),

                // Popular Packages Section
                Obx(() => PopularPackagesSection(
                      packages: homeController.popularPackages,
                      isLoading: homeController.isLoading,
                      onPackageTap: homeController.navigateToPackageDetail,
                      onSeeAllTap: homeController.navigateToPackageSearch,
                    )),

                // Recent Activities Section
                Obx(() => RecentActivitiesSection(
                      activities: homeController.recentActivities,
                      isLoading: homeController.isLoading,
                    )),

                const SizedBox(height: 100), // Bottom padding for FAB
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(homeController),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildPromoBanner() {
    final List<String> promoImages = [
      'https://images.unsplash.com/photo-1544551763-46a013bb70d5',
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
      'https://images.unsplash.com/photo-1500375592092-40eb2168fd21',
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 160,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          enlargeCenterPage: true,
          viewportFraction: 0.9,
        ),
        items: promoImages.map((imageUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jelajahi Keindahan Kalimantan Utara',
                          style: AppTextStyles.subtitle1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Dapatkan diskon hingga 30% untuk paket wisata terpilih',
                          style: AppTextStyles.body2.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBottomNavigation(HomeController homeController) {
    return Obx(() => BottomAppBar(
          color: AppTheme.snowWhite,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home,
                  label: 'Beranda',
                  isSelected: homeController.selectedIndex == 0,
                  onTap: () => homeController.changeBottomNavIndex(0),
                ),
                _buildNavItem(
                  icon: Icons.directions_boat,
                  label: 'Speedboat',
                  isSelected: homeController.selectedIndex == 1,
                  onTap: () {
                    homeController.changeBottomNavIndex(1);
                    homeController.navigateToSpeedboatSearch();
                  },
                ),
                const SizedBox(width: 40), // Space for FAB
                _buildNavItem(
                  icon: Icons.landscape,
                  label: 'Paket Wisata',
                  isSelected: homeController.selectedIndex == 2,
                  onTap: () {
                    homeController.changeBottomNavIndex(2);
                    homeController.navigateToPackageSearch();
                  },
                ),
                _buildNavItem(
                  icon: Icons.person,
                  label: 'Profil',
                  isSelected: homeController.selectedIndex == 3,
                  onTap: () {
                    homeController.changeBottomNavIndex(3);
                    homeController.navigateToProfile();
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppTheme.oceanBlue : AppTheme.silver,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isSelected ? AppTheme.oceanBlue : AppTheme.silver,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.bottomSheet(
          _buildQuickBookingSheet(),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
        );
      },
      backgroundColor: AppTheme.oceanBlue,
      child: const Icon(
        Icons.add,
        color: AppTheme.snowWhite,
        size: 28,
      ),
    );
  }

  Widget _buildQuickBookingSheet() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppTheme.snowWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.silver,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Booking Cepat',
            style: AppTextStyles.headline2,
          ),
          const SizedBox(height: 24),
          _buildQuickBookingOption(
            icon: Icons.directions_boat,
            title: 'Pesan Speedboat',
            subtitle: 'Cari rute dan pesan tiket speedboat',
            onTap: () {
              Get.back();
              Get.toNamed('/speedboat-search');
            },
          ),
          const SizedBox(height: 16),
          _buildQuickBookingOption(
            icon: Icons.landscape,
            title: 'Pesan Paket Wisata',
            subtitle: 'Jelajahi paket wisata menarik',
            onTap: () {
              Get.back();
              Get.toNamed('/package-search');
            },
          ),
          const SizedBox(height: 16),
          _buildQuickBookingOption(
            icon: Icons.confirmation_number,
            title: 'Tiket Saya',
            subtitle: 'Lihat semua tiket dan booking',
            onTap: () {
              Get.back();
              Get.toNamed('/tickets');
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildQuickBookingOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.sandBeige,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.silver.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.oceanBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppTheme.snowWhite,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.subtitle2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.body2.copyWith(
                      color: AppTheme.silver,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.silver,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
