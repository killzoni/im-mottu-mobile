import 'package:flutter/material.dart';
import 'package:im_mottu_mobile/app/data/datasource/cache.dart';
import 'package:im_mottu_mobile/app/data/datasource/get_pokemon_detail_datasource.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/domain/repositories/get_pokemon_detail_repository.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

class GetPokemonDetailRepository implements IGetPokemonDetailRepository {
  final IGetPokemonDetailDatasource datasource;
  final ICache cache;

  GetPokemonDetailRepository({
    required this.datasource,
    required this.cache,
  });

  @override
  Future<DataManager<PokemonEntity>> call({required String name}) async {
    try {
      final PokemonEntity? pokemonCache = await cache.getPokemon(name: name);
      if (pokemonCache != null) {
        debugPrint("return pokemon from cache");
        return DataManager.isSuccess(data: pokemonCache);
      }
    } catch (_) {
      debugPrint("Error get pokemon in cache");
    }

    final DataManager<PokemonEntity> dataManager = await datasource(name: name);
    if (dataManager.isSuccess) {
      try {
        if (dataManager.data != null) {
          cache.savePokemon(dataManager.data!);
        }
      } catch (_) {
        debugPrint("Error save pokemon in cache");
      }
    }
    return dataManager;
  }
}
