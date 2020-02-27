import 'package:pokedex/models/pokemonStatusModel.dart';

class DescriptionModel {
  String id;
  String image;
  List<String> types;
  List<PokemonStatusModel> pokemonStatusModel;

  DescriptionModel.fromJson(Map<String, dynamic> json) : assert(json != null) {
    id = json['id'];
    image = json['sprites']['front_default'];

    types = json['types'].map((type) {
      return type['type']['name'];
    }).toList();

    final stats = json['stats'] as List<dynamic>;
    pokemonStatusModel = stats.map((stat) {
      return PokemonStatusModel.fromJson(stat);
    }).toList();
  }
}
