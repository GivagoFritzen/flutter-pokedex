import 'package:dio/dio.dart';
import 'package:pokedex/models/itemModel.dart';

class ItemService {
  final baseUrl = 'https://pokeapi.co/api/v2/';
  final dio = Dio();

  String getItemIdFromUrl(String url) {
    String _id = url.replaceAll('${baseUrl}item/', '');
    _id = _id.replaceAll(_id.substring(_id.length - 1), '');
    return _id;
  }

  Future<ItemModel> getItemByName(String name) async {
    ItemModel _itemModel;

    try {
      final Response response = await dio.get('${baseUrl}item/${name}');

      _itemModel = ItemModel.fromJson(response.data);
      _itemModel.sprite = response.data['sprites']['default'];
      _itemModel.cost = response.data['cost'];
      _itemModel.description = response.data['effect_entries'][0]['effect'];
    } catch (e) {
      return null;
    }

    return _itemModel;
  }

  Future<List<ItemModel>> getListItems() async {
    List<ItemModel> listItemModel = [];

    try {
      final Response response = await dio.get('${baseUrl}item');
      var data = response.data['results'];

      for (var item in data) {
        ItemModel itemModel = ItemModel.fromJson(item);
        String _id = getItemIdFromUrl(item['url']);

        var itemDetail = await getItemDetails(_id);
        itemModel.sprite = itemDetail['sprites']['default'];
        itemModel.cost = itemDetail['cost'];

        itemModel.description = itemDetail['effect_entries'][0]['effect'];

        listItemModel.add(itemModel);
      }
    } catch (e) {
      print(e);
    }

    return listItemModel;
  }

  Future<dynamic> getItemDetails(String id) async {
    final Response response = await dio.get('${baseUrl}item/${id}');
    return response.data;
  }
}
