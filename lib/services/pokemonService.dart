import 'package:dio/dio.dart';
import 'package:pokedex/models/moveModel.dart';
import 'package:pokedex/models/descriptionModel.dart';
import 'package:pokedex/models/pokemonModel.dart';

class PokemonService {
  final baseUrl = 'https://pokeapi.co/api/v2/';
  final dio = Dio();

  String getMoveIdFromUrl(String url) {
    String _id = url.replaceAll('${baseUrl}move/', '');
    _id = _id.replaceAll(_id.substring(_id.length - 1), '');
    return _id;
  }

  Future<List<MoveModel>> getListMoves() async {
    try {
      final Response response = await dio.get('${baseUrl}move');
      var data = response.data['results'];

      List<MoveModel> listMovesModel = [];
      for (var move in data) {
        MoveModel _movePokemon = MoveModel.fromJson(move);
        String _id = getMoveIdFromUrl(move['url']);

        var moveDetails = await getMoveDetails(_id);
        _movePokemon.accuracy = moveDetails['accuracy'];
        _movePokemon.power = moveDetails['power'];
        _movePokemon.pp = moveDetails['pp'];
        _movePokemon.type = moveDetails['type']['name'];

        listMovesModel.add(_movePokemon);
      }

      return listMovesModel;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getMoveDetails(String id) async {
    final Response response = await dio.get('${baseUrl}move/${id}');
    return response.data;
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
