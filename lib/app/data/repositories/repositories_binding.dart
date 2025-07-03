import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/data/repositories/get_pokemon_detail_repository.dart';
import 'package:im_mottu_mobile/app/data/repositories/get_pokemon_repository.dart';
import 'package:im_mottu_mobile/app/domain/repositories/get_pokemon_detail_repository.dart';
import 'package:im_mottu_mobile/app/domain/repositories/get_pokemon_repository.dart';

class RepositoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGetPokemonRepository>(
      () => GetPokemonRepository(
        datasource: Get.find(),
        cache: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<IGetPokemonDetailRepository>(
      () => GetPokemonDetailRepository(
        datasource: Get.find(),
        cache: Get.find(),
      ),
      fenix: true,
    );
  }
}
