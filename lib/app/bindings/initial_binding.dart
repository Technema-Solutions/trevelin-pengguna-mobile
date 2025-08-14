import 'package:get/get.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/home/presentation/controllers/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core dependencies
    Get.put<LoginUsecase>(LoginUsecase(), permanent: true);

    // Core controllers
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}
