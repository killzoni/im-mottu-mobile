import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  PokemonModel({
    required super.id,
    required super.name,
    required super.image,
    required super.height,
    required super.weight,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      height: json["height"],
      weight: json["weight"],
    );
  }
}
