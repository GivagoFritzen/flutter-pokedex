class PokemonStatusModel {
  String name;
  int value;

  PokemonStatusModel.fromJson(Map<String, dynamic> json)
      : assert(json != null) {
    name = json['stat']['name'];
    value = json['base_stat'];
  }
}
