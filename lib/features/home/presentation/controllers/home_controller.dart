import 'package:get/get.dart';
import '../../../../core/data/mock_data_provider.dart';
import '../../../speedboat/domain/entities/speedboat_ticket.dart';
import '../../../speedboat/domain/entities/travel_package.dart';

class HomeController extends GetxController {
  // Observables
  final _isLoading = false.obs;
  final _popularRoutes = <SpeedboatTicket>[].obs;
  final _popularPackages = <TravelPackage>[].obs;
  final _recentActivities = <Map<String, dynamic>>[].obs;
  final _selectedIndex = 0.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  List<SpeedboatTicket> get popularRoutes => _popularRoutes;
  List<TravelPackage> get popularPackages => _popularPackages;
  List<Map<String, dynamic>> get recentActivities => _recentActivities;
  int get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    super.onInit();
    _loadDashboardData();
  }

  // Load dashboard data
  Future<void> _loadDashboardData() async {
    try {
      _isLoading.value = true;

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Load mock data
      _popularRoutes.value = MockDataProvider.popularSpeedboatRoutes;
      _popularPackages.value = MockDataProvider.popularTravelPackages;
      _recentActivities.value = MockDataProvider.recentActivities;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data dashboard: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  // Refresh dashboard data
  Future<void> refreshData() async {
    await _loadDashboardData();
  }

  // Navigation methods
  void navigateToSpeedboatSearch() {
    Get.toNamed('/speedboat-search');
  }

  void navigateToPackageSearch() {
    Get.toNamed('/package-search');
  }

  void navigateToSpeedboatDetail(String ticketId) {
    Get.toNamed('/speedboat-detail/$ticketId');
  }

  void navigateToPackageDetail(String packageId) {
    Get.toNamed('/package-detail/$packageId');
  }

  void navigateToTickets() {
    Get.toNamed('/tickets');
  }

  void navigateToProfile() {
    Get.toNamed('/profile');
  }

  // Bottom navigation
  void changeBottomNavIndex(int index) {
    _selectedIndex.value = index;
  }
}
