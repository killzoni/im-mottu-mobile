import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';

abstract class ICache {
  Future<void> saveListPokemon(List<PokemonEntity> pokemon);

  Future<List<PokemonEntity>> getListPokemon();

  Future<void> savePokemon(PokemonEntity pokemon);

  Future<PokemonEntity?> getPokemon({required String name});
}
