import 'package:get/get.dart';

import '../../../../core/diagnostics/device_info.dart';
import '../../data/feedback_sender.dart';

/// Controller powering the [FeedbackPage].
class FeedbackController extends GetxController {
  FeedbackController(this.sender);

  final FeedbackSender sender;

  final subject = ''.obs;
  final description = ''.obs;
  final includeLogs = false.obs;

  final Map<String, String> _deviceInfo = {};

  @override
  void onInit() {
    super.onInit();
    DeviceInfoCollector.collect().then(_deviceInfo.addAll);
  }

  Future<void> submit() async {
    final buffer = StringBuffer()
      ..writeln(description.value)
      ..writeln('\n---')
      ..writeln(_deviceInfo.entries.map((e) => '${e.key}: ${e.value}').join('\n'));
    await sender.send(subject.value, buffer.toString());
  }
}
