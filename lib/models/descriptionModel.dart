import 'dart:collection';
import 'package:pokedex/models/pokemonStatusModel.dart';

class DescriptionModel {
  int id;
  String image;
  Queue<String> types = new Queue<String>();
  List<PokemonStatusModel> pokemonStatusModel;

  DescriptionModel.fromJson(Map<String, dynamic> json) : assert(json != null) {
    id = json['id'];

    var _sprite = json['sprites'] as Map<String, dynamic>;
    image = _sprite['front_default'];

    json['types'].map((type) {
      types.addFirst(type['type']['name'] as String);
    }).toList();

    final stats = json['stats'] as List<dynamic>;
    pokemonStatusModel = stats.map((stat) {
      return PokemonStatusModel.fromJson(stat);
    }).toList();
  }
}
