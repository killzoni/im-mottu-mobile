import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/domain/usecases/get_pokemon_detail_usecase.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';
import 'package:im_mottu_mobile/app/utils/state_page.dart';

class DetailController extends GetxController {
  final IGetPokemonDetailUsecase getPokemonDetailUsecase;

  DetailController({required this.getPokemonDetailUsecase});

  final Rx<StatePage<PokemonEntity>> pokemonState = Rx(StateLoading());

  final PokemonEntity _pokemonArgs = Get.arguments["pokemon"];

  @override
  void onInit() {
    getPokemonByName();
    super.onInit();
  }

  String get getPokemonName => _pokemonArgs.name;

  Future<void> getPokemonByName() async {
    pokemonState.value = StateLoading();
    try {
      final DataManager<PokemonEntity> dataManager =
          await getPokemonDetailUsecase(
        name: getPokemonName,
      );

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
}
