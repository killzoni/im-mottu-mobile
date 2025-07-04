class PokemonEntity {
  final String name;
  final String? image;
  final int? height;
  final int? weight;
  final List<String>? types;

  PokemonEntity({
    required this.name,
    this.image,
    this.height,
    this.weight,
    this.types,
  });
}
