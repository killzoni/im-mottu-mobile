import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/presentation/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(),
      fenix: true,
    );
  }
}
