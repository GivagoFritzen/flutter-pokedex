import 'descriptionModel.dart';

class PokemonModel {
  String name;
  String id;
  String url;
  DescriptionModel descriptionModel;

  PokemonModel.fromJson(Map<String, dynamic> json) : assert(json != null) {
    name = json['name'];
    url = json['url'] as String;

    if (json['id'] != null) {
      id = json['id'].toString();
      url = 'https://pokeapi.co/api/v2/pokemon/${id}';
    } else {
      String _id = url.replaceAll('https://pokeapi.co/api/v2/pokemon/', '');
      id = _id.replaceAll(_id.substring(_id.length - 1), '');
    }
  }
}
