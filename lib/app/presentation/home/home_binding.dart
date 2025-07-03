import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/presentation/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(getPokemonUsecase: Get.find()),
      fenix: true,
    );
  }
}
