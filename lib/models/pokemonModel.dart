import 'descriptionModel.dart';

class PokemonModel {
  String name;
  String id;
  String url;
  DescriptionModel descriptionModel;

  PokemonModel.fromJson(Map<String, dynamic> json) : assert(json != null) {
    name = json['name'];
    url = json['url'] as String;

    String _id = url.replaceAll('https://pokeapi.co/api/v2/pokemon/', '');
    id = _id.replaceAll(_id.substring(_id.length - 1), '');
  }
}
