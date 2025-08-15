import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'features/speedboat/presentation/controllers/speedboat_controller.dart';
import 'features/packages/presentation/controllers/package_detail_controller.dart';
import 'features/speedboat/data/repositories/speedboat_repo_impl.dart';
import 'features/speedboat/data/datasources/speedboat_remote_mock.dart';
import 'features/packages/data/repositories/package_repo_impl.dart';
import 'features/packages/data/datasources/package_remote_mock.dart';
import 'features/payments/data/datasources/payment_gateway_mock.dart';
import 'features/payments/data/repositories/payment_repo_impl.dart';
import 'features/payments/presentation/controllers/payment_controller.dart';
import 'data/storage/local_store.dart';
import 'core/logging/app_logger.dart';
import 'core/telemetry/analytics.dart';
import 'core/telemetry/crash_reporter.dart';

Future<void> main() async {
  FlutterError.onError = (details) {
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  };

  late CrashReporter crash;

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    crash = CrashReporterConsole();
    await crash.init();
    final analytics = ConsoleAnalytics();
    await analytics.init();

    final speedboatRepo = SpeedboatRepoImpl(SpeedboatRemoteMock());
    final packageRepo = PackageRepoImpl(PackageRemoteMock());
    final store = await LocalStore.init();
    late PaymentRepositoryImpl payRepo;
    final gateway =
        PaymentGatewayMock(onWebhook: (p) => payRepo.handleWebhook(p));
    payRepo = PaymentRepositoryImpl(
        gateway: gateway, store: store, bookingRepo: speedboatRepo);
    Get.put(SpeedboatController(repo: speedboatRepo));
    Get.put(PackageDetailController(repo: packageRepo));
    Get.put(PaymentController(payRepo));
    runApp(TrevelinApp(analytics: analytics, crash: crash));
  }, (error, stack) {
    AppLogger.e('Uncaught zone error', error, stack);
    crash.recordError(error, stack);
  });
}

class TrevelinApp extends StatelessWidget {
  const TrevelinApp({super.key, required this.analytics, required this.crash});

  final Analytics analytics;
  final CrashReporter crash;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppLocalizations.of(context)?.appTitle ?? 'Trevelin',
      theme: AppTheme.light,
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.speedboat,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
