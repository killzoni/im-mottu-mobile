import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/data/repositories/get_pokemon_repository.dart';
import 'package:im_mottu_mobile/app/domain/repositories/get_pokemon_repository.dart';

class RepositoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGetPokemonRepository>(
      () => GetPokemonRepository(datasource: Get.find()),
      fenix: true,
    );
  }
}
