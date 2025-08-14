import 'package:flutter/material.dart';

/// Tab bar used on the package detail page.
class PackageTabs extends StatelessWidget implements PreferredSizeWidget {
  const PackageTabs({super.key, required this.tabController});

  final TabController tabController;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      tabs: const [
        Tab(text: 'Overview'),
        Tab(text: 'Itinerary'),
        Tab(text: 'Location'),
        Tab(text: 'Reviews'),
      ],
    );
  }
}
