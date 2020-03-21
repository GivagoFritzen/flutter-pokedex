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
      final Response response = await dio.get('${baseUrl}move/${name.toLowerCase()}');

      MoveModel _moveModel = MoveModel.fromJson(response.data);
      setMoveDetails(response.data, _moveModel);

      return _moveModel;
    } catch (e) {
      return null;
    }
  }

  Future<List<MoveModel>> getListMoves() async {
    List<MoveModel> listMovesModel = [];

    try {
      final Response response = await dio.get('${baseUrl}move');
      var data = response.data['results'];

      for (var move in data) {
        MoveModel _movePokemon = MoveModel.fromJson(move);
        String _id = getMoveIdFromUrl(move['url']);

        var moveDetails = await getMoveDetails(_id);
        setMoveDetails(moveDetails, _movePokemon);

        listMovesModel.add(_movePokemon);
      }
    } catch (e) {
      print(e);
    }

    return listMovesModel;
  }

  MoveModel setMoveDetails(Map<String, dynamic> json, MoveModel movePokemon) {
    movePokemon.accuracy = json['accuracy'];
    movePokemon.power = json['power'];
    movePokemon.pp = json['pp'];
    movePokemon.type = json['type']['name'];
  }

  Future<dynamic> getMoveDetails(String id) async {
    final Response response = await dio.get('${baseUrl}move/${id}');
    return response.data;
  }
}
