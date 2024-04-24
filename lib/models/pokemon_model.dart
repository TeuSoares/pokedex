class PokemonModel {
  int? userId;
  int? pokemonId;
  String? name;
  String? image;
  int? weight;
  int? height;
  List<dynamic>? types;

  PokemonModel({
    this.userId,
    this.pokemonId,
    this.name,
    this.image,
    this.weight,
    this.height,
    this.types,
  });

  PokemonModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    pokemonId = json['id'] ?? json['pokemonId'];
    name = json['name'];
    image = json['image'];
    weight = json['weight'];
    height = json['height'];
    types = json['types'];
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'pokemonId': pokemonId,
        'name': name,
        'image': image,
        'weight': weight,
        'height': height,
        'types': types,
      };
}
