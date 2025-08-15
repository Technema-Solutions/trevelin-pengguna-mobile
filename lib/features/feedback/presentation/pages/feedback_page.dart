import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controllers/feedback_controller.dart';

/// Page allowing users to send in-app feedback.
class FeedbackPage extends GetView<FeedbackController> {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.feedbackTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: l10n.subjectLabel),
              onChanged: controller.subject.call,
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(labelText: l10n.descriptionLabel),
              maxLines: 5,
              onChanged: controller.description.call,
            ),
            const SizedBox(height: 8),
            Obx(() => SwitchListTile(
                  title: Text(l10n.includeLogsLabel),
                  value: controller.includeLogs.value,
                  onChanged: (v) => controller.includeLogs.value = v,
                )),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await controller.submit();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.feedbackThanks)));
                  Get.back();
                }
              },
              child: Text(l10n.submitLabel),
            )
          ],
        ),
      ),
    );
  }
}
