import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/presentation/detail/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DetailController(getPokemonDetailUsecase: Get.find()),
      fenix: true,
    );
  }
}
