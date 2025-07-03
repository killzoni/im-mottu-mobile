import 'package:flutter/material.dart';
import 'package:im_mottu_mobile/app/data/datasource/cache.dart';
import 'package:im_mottu_mobile/app/data/datasource/get_pokemon_datasource.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

import '../../domain/repositories/get_pokemon_repository.dart';

class GetPokemonRepository implements IGetPokemonRepository {
  final IGetPokemonDatasource datasource;
  final ICache cache;

  GetPokemonRepository({
    required this.datasource,
    required this.cache,
  });

  @override
  Future<DataManager<List<PokemonEntity>>> call() async {
    try {
      final List<PokemonEntity> listCache = await cache.getListPokemon();
      if (listCache.isNotEmpty) {
        debugPrint("return pokemon from cache");
        return DataManager.isSuccess(data: listCache);
      }
    } catch (_) {
      debugPrint("Error get pokemon in cache");
    }

    final DataManager<List<PokemonEntity>> dataManager = await datasource();
    if (dataManager.isSuccess) {
      try {
        cache.saveListPokemon(dataManager.data ?? []);
      } catch (_) {
        debugPrint("Error save pokemon in cache");
      }
    }
    return dataManager;
  }
}
