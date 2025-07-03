import 'package:im_mottu_mobile/app/data/datasource/get_pokemon_datasource.dart';
import 'package:im_mottu_mobile/app/data/datasource/get_pokemon_detail_datasource.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/domain/repositories/get_pokemon_detail_repository.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

import '../../domain/repositories/get_pokemon_repository.dart';

class GetPokemonDetailRepository implements IGetPokemonDetailRepository {
  final IGetPokemonDetailDatasource datasource;

  GetPokemonDetailRepository({required this.datasource});

  @override
  Future<DataManager<PokemonEntity>> call({required String name}) async {
    return await datasource(name: name);
  }
}
