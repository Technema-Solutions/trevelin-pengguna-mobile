import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/bindings/initial_binding.dart';
import 'core/constants/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage
  await GetStorage.init();

  runApp(const TrevelinApp());
}

class TrevelinApp extends StatelessWidget {
  const TrevelinApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Trevelin',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
