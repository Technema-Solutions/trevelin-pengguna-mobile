import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Collects basic device and application information for diagnostics/feedback.
class DeviceInfoCollector {
  DeviceInfoCollector._();

  static Future<Map<String, String>> collect() async {
    final deviceInfo = DeviceInfoPlugin();
    final package = await PackageInfo.fromPlatform();
    final data = <String, String>{
      'appName': package.appName,
      'packageName': package.packageName,
      'version': package.version,
      'buildNumber': package.buildNumber,
    };
    try {
      final android = await deviceInfo.androidInfo;
      data.addAll({
        'platform': 'android',
        'model': android.model ?? '',
        'sdkInt': '${android.version.sdkInt}',
      });
    } catch (_) {
      try {
        final ios = await deviceInfo.iosInfo;
        data.addAll({
          'platform': 'ios',
          'model': ios.utsname.machine ?? '',
          'systemVersion': ios.systemVersion ?? '',
        });
      } catch (_) {}
    }
    return data;
  }
}
