import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feedback/data/feedback_sender.dart';
import '../../feedback/presentation/controllers/feedback_controller.dart';
import '../../feedback/presentation/pages/feedback_page.dart';

/// Simple debug menu available only in non-release builds.
class DebugMenuPage extends StatelessWidget {
  const DebugMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode) {
      return const SizedBox.shrink();
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Menu')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Throw test error'),
            onTap: () => throw Exception('Test error from debug menu'),
          ),
          ListTile(
            title: const Text('Open feedback'),
            onTap: () => Get.to(() => const FeedbackPage(),
                binding: BindingsBuilder(() {
                  Get.put(FeedbackController(EmailFeedbackSender()));
                })),
          ),
        ],
      ),
    );
  }
}
