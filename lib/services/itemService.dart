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

  Future<List<ItemModel>> getListItems() async {
    try {
      final Response response = await dio.get('${baseUrl}item');
      var data = response.data['results'];

      List<ItemModel> listItemModel = [];
      for (var item in data) {
        ItemModel itemModel = ItemModel.fromJson(item);
        String _id = getItemIdFromUrl(item['url']);

        var itemDetail = await getItemDetails(_id);
        itemModel.sprite = itemDetail['sprites']['default'];
        itemModel.cost = itemDetail['cost'];

        itemModel.description = itemDetail['effect_entries'][0]['effect'];

        listItemModel.add(itemModel);
      }

      return listItemModel;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getItemDetails(String id) async {
    final Response response = await dio.get('${baseUrl}item/${id}');
    return response.data;
  }
}
