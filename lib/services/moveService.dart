import 'package:dio/dio.dart';
import 'package:pokedex/models/moveModel.dart';

class MoveService {
  final baseUrl = 'https://pokeapi.co/api/v2/';
  final dio = Dio();

  String getMoveIdFromUrl(String url) {
    String _id = url.replaceAll('${baseUrl}move/', '');
    _id = _id.replaceAll(_id.substring(_id.length - 1), '');
    return _id;
  }

  Future<MoveModel> getMoveByName(String name) async {
    try {
      final Response response = await dio.get('${baseUrl}move/${name}');

      MoveModel _moveModel = MoveModel.fromJson(response.data);

      return _moveModel;
    } catch (e) {
      return null;
    }
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
}
