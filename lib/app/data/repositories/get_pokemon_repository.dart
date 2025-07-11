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
  Future<DataManager<List<PokemonEntity>>> call({
    required int limit,
    required int offset,
  }) async {
    try {
      final List<PokemonEntity> cachedList = await cache.getListPokemon();

      final hasEnoughCached = cachedList.length >= offset + limit;
      if (hasEnoughCached) {
        debugPrint("Retornando pokémons da página $offset do cache");
        final pagedData = cachedList.sublist(offset, offset + limit);

        final int? totalItems = await cache.getTotalItemsPokemon();
        return DataManager.isSuccess(
          data: pagedData,
          totalItems: totalItems ?? 1302,
        );
      }
    } catch (e) {
      debugPrint("Erro ao acessar cache: $e");
    }

    final DataManager<List<PokemonEntity>> dataManager = await datasource(
      limit: limit,
      offset: offset,
    );

    if (dataManager.isSuccess) {
      try {
        cache.saveTotalItemsPokemon(dataManager.totalItems);

        final List<PokemonEntity> existing = await cache.getListPokemon();

        final List<PokemonEntity> updated = [...existing, ...dataManager.data!];

        final Set<String> seenNames = {};
        final List<PokemonEntity> uniqueUpdated = [];

        for (final pokemon in updated) {
          if (seenNames.add(pokemon.name)) {
            uniqueUpdated.add(pokemon);
          }
        }

        await cache.saveListPokemon(uniqueUpdated);
      } catch (e) {
        debugPrint("Erro ao salvar no cache: $e");
      }
    }

    return dataManager;
  }
}
