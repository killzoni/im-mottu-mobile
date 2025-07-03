import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/data/datasource/get_pokemon_datasource.dart';
import 'package:im_mottu_mobile/app/infra/datasource/get_pokemon_datasource.dart';

class DatasourcesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGetPokemonDatasource>(
      () => GetPokemonDatasource(dio: Get.find()),
      fenix: true,
    );
  }
}
