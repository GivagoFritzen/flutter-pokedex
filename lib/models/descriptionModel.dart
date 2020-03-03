import 'package:pokedex/models/pokemonStatusModel.dart';

class DescriptionModel {
  int id;
  String image;
  List<String> types;
  List<PokemonStatusModel> pokemonStatusModel;

  DescriptionModel.fromJson(Map<String, dynamic> json) : assert(json != null) {
    id = json['id'];

    var _sprite = json['sprites'] as Map<String, dynamic>;
    image = _sprite['front_default'];

    /*
    types = json['types'].map((type) {
      return type['type']['name'];
    }).toList();

    final stats = json['stats'] as List<dynamic>;
    pokemonStatusModel = stats.map((stat) {
      return PokemonStatusModel.fromJson(stat);
    }).toList();
    */
  }
}
