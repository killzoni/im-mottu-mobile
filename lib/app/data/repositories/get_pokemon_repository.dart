import 'package:im_mottu_mobile/app/data/datasource/get_pokemon_datasource.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

import '../../domain/repositories/get_pokemon_repository.dart';

class GetPokemonRepository implements IGetPokemonRepository {
  final IGetPokemonDatasource datasource;

  GetPokemonRepository({required this.datasource});

  @override
  Future<DataManager<List<PokemonEntity>>> call() async {
    return await datasource();
  }
}
