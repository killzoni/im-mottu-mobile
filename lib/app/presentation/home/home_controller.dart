import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/app_router.dart';
import 'package:im_mottu_mobile/app/data/datasource/cache.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/domain/usecases/get_pokemon_usecase.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';
import 'package:im_mottu_mobile/app/utils/state_page.dart';

class HomeController extends GetxController {
  final IGetPokemonUsecase getPokemonUsecase;
  final ICache cache;

  final Rx<StatePage<List<PokemonEntity>>> pokemonState = Rx(StateLoading());

  HomeController({
    required this.getPokemonUsecase,
    required this.cache,
  });

  @override
  void onInit() {
    getPokemon();
    super.onInit();
  }

  Future<void> getPokemon() async {
    pokemonState.value = StateLoading();
    try {
      final DataManager<List<PokemonEntity>> dataManager =
          await getPokemonUsecase();

      if (dataManager.isSuccess) {
        pokemonState.value = StateSuccess(data: dataManager.data);
        return;
      }

      pokemonState.value = StateError(
        message: dataManager.messageError ?? "Erro ao consultar os dados",
      );
    } catch (e) {
      pokemonState.value = StateError(message: "Erro ao consultar os dados");
    }
  }

  void openDetailPage(PokemonEntity pokemon) {
    AppRouter.goToDetail(pokemon);
  }

  Future<void> filterByName(String value) async {
    if (value.isEmpty) {
      final List<PokemonEntity> data = await cache.getListPokemon();
      pokemonState.value = StateSuccess(data: data);
      return;
    }

    if (pokemonState.value is StateSuccess) {
      final List<PokemonEntity> data =
          (pokemonState.value as StateSuccess).data;
      final List<PokemonEntity> filterData = data
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      pokemonState.value = StateSuccess(data: filterData);
    }
  }
}
