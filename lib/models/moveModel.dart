class MoveModel {
  String name, type;
  int accuracy, pp, power;

  MoveModel.fromJson(Map<String, dynamic> json) : assert(json != null) {
    name = json['name'];
  }
}
