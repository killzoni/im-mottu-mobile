import 'package:im_mottu_mobile/app/data/datasource/get_pokemon_datasource.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

class GetPokemonDatasource implements IGetPokemonDatasource {
  @override
  Future<DataManager<List<PokemonEntity>>> call() async {
    await Future.delayed(const Duration(seconds: 2));
    return DataManager.isSuccess(
      data: List.generate(
        10,
        (index) => PokemonEntity(
          id: 10,
          name: "Teste $index",
          image:
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/35.png",
          height: 10,
          weight: 10,
        ),
      ).toList(),
    );
  }
}
