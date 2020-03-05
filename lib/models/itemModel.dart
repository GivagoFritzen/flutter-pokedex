class ItemModel {
  String name, description, sprite;
  int cost;

  ItemModel.fromJson(Map<String, dynamic> json) : assert(json != null) {
    name = json['name'];
  }
}
