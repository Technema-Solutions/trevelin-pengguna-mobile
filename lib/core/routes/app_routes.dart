import 'package:get/get.dart';
import '../../features/speedboat/presentation/pages/speedboat_list_page.dart';
import '../../features/speedboat/presentation/pages/speedboat_detail_page.dart';
import '../../features/speedboat/presentation/pages/seat_map_page.dart';
import '../../features/speedboat/presentation/pages/booking_checkout_page.dart';
import '../../features/speedboat/presentation/pages/booking_success_page.dart';
import '../../features/packages/presentation/pages/package_detail_page.dart';
import '../../features/payments/presentation/pages/payment_method_page.dart';
import '../../features/payments/presentation/pages/payment_pending_page.dart';
import '../../features/feedback/presentation/pages/feedback_page.dart';
import '../../features/feedback/presentation/controllers/feedback_controller.dart';
import '../../features/feedback/data/feedback_sender.dart';
import '../../features/debugtools/presentation/pages/debug_menu_page.dart';

/// Application route names and GetX pages.
class AppRoutes {
  AppRoutes._();

  static const String speedboat = '/speedboat';
  static const String speedboatDetail = '/speedboat/:id';
  static const String seatMap = '/speedboat/:id/seat-map';
  static const String checkout = '/speedboat/checkout';
  static const String bookingSuccess = '/speedboat/success';
  static const String paymentMethod = '/payment/method';
  static const String paymentPending = '/payment/pending';
  static const String packageDetail = '/package/:id';
  static const String feedback = '/feedback';
  static const String debugMenu = '/debug';

  /// List of [GetPage] for GetMaterialApp.
  static final List<GetPage<dynamic>> pages = [
    GetPage(name: speedboat, page: () => const SpeedboatListPage()),
    GetPage(name: speedboatDetail, page: () => const SpeedboatDetailPage()),
    GetPage(name: seatMap, page: () => const SeatMapPage()),
    GetPage(name: checkout, page: () => const BookingCheckoutPage()),
    GetPage(name: bookingSuccess, page: () => const BookingSuccessPage()),
    GetPage(name: paymentMethod, page: () => const PaymentMethodPage()),
    GetPage(name: paymentPending, page: () => const PaymentPendingPage()),
    GetPage(name: packageDetail, page: () => const PackageDetailPage()),
    GetPage(
      name: feedback,
      page: () => const FeedbackPage(),
      binding: BindingsBuilder(() {
        Get.put(FeedbackController(EmailFeedbackSender()));
      }),
    ),
    GetPage(name: debugMenu, page: () => const DebugMenuPage()),
  ];
}
