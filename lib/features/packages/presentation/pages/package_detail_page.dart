import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/package_detail_controller.dart';
import '../widgets/package_gallery.dart';
import '../widgets/package_tabs.dart';
import '../widgets/itinerary_timeline.dart';
import '../widgets/review_list.dart';

/// Page displaying details of a travel package including tabs.
class PackageDetailPage extends StatefulWidget {
  const PackageDetailPage({super.key});

  @override
  State<PackageDetailPage> createState() => _PackageDetailPageState();
}

class _PackageDetailPageState extends State<PackageDetailPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final PackageDetailController controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    controller = Get.find<PackageDetailController>();
    controller.loadPackage(Get.parameters['id'] ?? 'pkg-001');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package Detail'),
        bottom: PackageTabs(tabController: _tabController),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.shopping_bag),
      ),
      body: Obx(() {
        final pkg = controller.pkg.value;
        if (pkg == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PackageGallery(images: pkg.gallery),
                  const SizedBox(height: 8),
                  Text(pkg.overview),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ItineraryTimeline(days: pkg.itinerary),
            ),
            Center(
                child: Text(
                    'Location: ${pkg.latitude}, ${pkg.longitude}')), // placeholder
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ReviewList(reviews: pkg.reviews),
            ),
          ],
        );
      }),
    );
  }
}
