import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/app_router.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        AppRouter.goToHome();
      },
    );
    super.onInit();
  }
}
