import 'package:dio/dio.dart';
import 'package:pokedex/models/descriptionModel.dart';
import 'package:pokedex/models/pokemonModel.dart';

class PokemonService {
  final baseUrl = 'https://pokeapi.co/api/v2/';
  final dio = Dio();

  Future<PokemonModel> getPokemonByName(String name) async {
    try {
      final Response response = await dio.get('${baseUrl}pokemon/${name}');

      PokemonModel _pokemonModel = PokemonModel.fromJson(response.data);
      _pokemonModel.descriptionModel = DescriptionModel.fromJson(response.data);

      return _pokemonModel;
    } catch (e) {
      return null;
    }
  }

  Future<List<PokemonModel>> getListPokemon() async {
    final Response response = await dio.get('${baseUrl}pokemon');
    final data = response.data['results'];

    List<PokemonModel> listPokemonModel = [];
    for (var pokemon in data) {
      PokemonModel _pokemonModel = PokemonModel.fromJson(pokemon);
      _pokemonModel.descriptionModel =
          await getPokemonDescription(_pokemonModel.url);
      listPokemonModel.add(_pokemonModel);
    }

    return listPokemonModel;
  }

  Future<DescriptionModel> getPokemonDescription(String url) async {
    try {
      final Response response = await dio.get(url);
      return DescriptionModel.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }
}
