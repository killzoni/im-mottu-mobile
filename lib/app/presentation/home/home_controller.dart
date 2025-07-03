import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/app_router.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/domain/usecases/get_pokemon_usecase.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';
import 'package:im_mottu_mobile/app/utils/state_page.dart';

class HomeController extends GetxController {
  final IGetPokemonUsecase getPokemonUsecase;

  final Rx<StatePage<List<PokemonEntity>>> pokemonState = Rx(StateLoading());

  HomeController({required this.getPokemonUsecase});

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

      pokemonState.value = StateError(message: "Erro ao consultar os dados");
    } catch (e) {
      pokemonState.value = StateError(message: "Erro ao consultar os dados");
    }
  }

  void openDetailPage(PokemonEntity pokemon) {
    AppRouter.goToDetail(pokemon);
  }
}
