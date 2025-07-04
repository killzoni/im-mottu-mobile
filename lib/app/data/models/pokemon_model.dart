import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  PokemonModel({
    required super.name,
    super.image,
    super.height,
    super.weight,
    super.types,
  });

  factory PokemonModel.fromEntity(PokemonEntity entity) {
    return PokemonModel(
      name: entity.name,
      image: entity.image,
      height: entity.height,
      weight: entity.weight,
      types: entity.types,
    );
  }

  factory PokemonModel.fromJsonNameAndImage(Map<String, dynamic> json) {
    return PokemonModel(
      name: json["name"] ?? "",
      image: json["sprites"]["front_default"],
    );
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json["name"],
      image: json["sprites"]["front_default"],
      height: json["height"],
      weight: json["weight"],
      types: (json["types"] as List)
          .map((json) => json["type"]?["name"]?.toString() ?? "")
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "sprites": {
          "front_default": image,
        },
        "height": height,
        "weight": weight,
        "types": types
                ?.map((typeName) => {
                      "type": {
                        "name": typeName,
                      }
                    })
                .toList() ??
            [],
      };
}
