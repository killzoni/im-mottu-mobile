import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/data/usecases/get_pokemon_detail_usecase.dart';
import 'package:im_mottu_mobile/app/data/usecases/get_pokemon_usecase.dart';
import 'package:im_mottu_mobile/app/domain/usecases/get_pokemon_detail_usecase.dart';
import 'package:im_mottu_mobile/app/domain/usecases/get_pokemon_usecase.dart';

class UsecaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGetPokemonUsecase>(
      () => GetPokemonUsecase(repository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<IGetPokemonDetailUsecase>(
      () => GetPokemonDetailUsecase(repository: Get.find()),
      fenix: true,
    );
  }
}
