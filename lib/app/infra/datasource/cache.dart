import 'dart:convert';

import 'package:im_mottu_mobile/app/data/datasource/cache.dart';
import 'package:im_mottu_mobile/app/data/models/pokemon_model.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache implements ICache {
  static const String _pokemons = "pokemons";

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<List<PokemonEntity>> getListPokemon() async {
    final SharedPreferences prefs = await _prefs;

    final String? jsonData = prefs.getString(_pokemons);
    if (jsonData == null) {
      return [];
    }

    final dynamic data = json.decode(jsonData);

    return (data as List)
        .map((json) => PokemonModel.fromJsonNameAndImage(json))
        .toList();
  }

  @override
  Future<void> saveListPokemon(List<PokemonEntity> pokemons) async {
    final SharedPreferences prefs = await _prefs;

    final dynamic data = pokemons
        .map((pokemon) => PokemonModel.fromEntity(pokemon).toJson())
        .toList();
    final String pokemonsJson = json.encode(data);
    await prefs.setString(_pokemons, pokemonsJson);
  }

  @override
  Future<PokemonEntity?> getPokemon({required String name}) async {
    final SharedPreferences prefs = await _prefs;
    final String? data = prefs.getString(name);
    if (data == null) {
      return null;
    }

    return PokemonModel.fromJson(json.decode(data));
  }

  @override
  Future<void> savePokemon(PokemonEntity pokemon) async {
    final SharedPreferences prefs = await _prefs;

    final String data = json.encode(PokemonModel.fromEntity(pokemon).toJson());
    await prefs.setString(pokemon.name, data);
  }
}
