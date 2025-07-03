import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  PokemonModel({
    required super.name,
    super.image,
    super.height,
    super.weight,
  });

  factory PokemonModel.fromJsonOnlyName(Map<String, dynamic> json) {
    return PokemonModel(
      name: json["name"],
    );
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json["name"],
      image: json["sprites"]["front_default"],
      height: json["height"],
      weight: json["weight"],
    );
  }
}
