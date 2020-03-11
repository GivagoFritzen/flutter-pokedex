import 'package:flutter/material.dart';

class MainBottomCard extends StatelessWidget {
  String name;
  String imageName;
  Function function;
  bool isActived;

  MainBottomCard({this.name, this.imageName, this.function, this.isActived})
      : assert(name != null && imageName != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
        onPressed: function,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageIcon(
              AssetImage('assets/buttons/$imageName.png'),
              color: isActived ? Colors.black : Colors.grey,
            ),
            Text(name),
          ],
        ),
      ),
    );
  }
}
