import 'package:dio/dio.dart';
import 'package:pokedex/models/movesModel.dart';
import 'package:pokedex/models/descriptionModel.dart';
import 'package:pokedex/models/pokemonModel.dart';

class PokemonService {
  //final baseUrl = 'http://localhost:3000/';
  final baseUrl = 'https://pokeapi.co/api/v2/';
  final dio = Dio();

  Future<List<MovesModel>> getListMoves() async {
    try {
      final Response response = await dio.get('${baseUrl}moves');
      final List data = response.data;
      return data.map((move) => MovesModel.fromJson(move)).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<List<PokemonModel>> getListPokemon() async {
    final Response response = await dio.get('${baseUrl}pokemon');
    final data = response.data['results'];

    List<PokemonModel> listPokemonModel = [];
    data.forEach((pokemon) {
      listPokemonModel.add(PokemonModel.fromJson(pokemon));
    });

    listPokemonModel.forEach((pokemon) async {
      pokemon.descriptionModel = await getPokemonDescription(pokemon.url);
    });

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
