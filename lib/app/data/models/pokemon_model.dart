import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  PokemonModel({
    required super.name,
    super.image,
    super.height,
    super.weight,
  });

  factory PokemonModel.fromEntity(PokemonEntity entity) {
    return PokemonModel(
      name: entity.name,
      image: entity.image,
      height: entity.height,
      weight: entity.weight,
    );
  }

  factory PokemonModel.fromJsonNameAndImage(Map<String, dynamic> json) {
    int extractIdFromUrl(String url) {
      final Uri uri = Uri.parse(url);
      final List<String >segments = uri.pathSegments;

      if (segments.isNotEmpty) {
        final lastSegment = segments.where((s) => s.isNotEmpty).last;
        return int.tryParse(lastSegment) ?? -1;
      }

      return -1;
    }

    final int imageId = extractIdFromUrl(json["url"]);
    return PokemonModel(
        name: json["name"],
        image:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$imageId.png");
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json["name"],
      image: json["sprites"]["front_default"],
      height: json["height"],
      weight: json["weight"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "height": height,
        "weight": weight,
      };
}
