import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  String name, description, sprite;
  int cost;

  CardItem({this.name, this.description, this.sprite, this.cost});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  String getName(String name) {
    String newName = name.replaceAll("-", " ");
    return newName;
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => Navigator.pushNamed(
        context,
        '/itemPage',
        arguments: {
          'name': widget.name,
          'description': widget.description,
          'sprite': widget.sprite,
          'cost': widget.cost,
        },
      ),
      child: Container(
        color: Colors.white,
        height: 75,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 13),
              Text(
                getName(widget.name),
                style: TextStyle(fontSize: 19),
              ),
              Spacer(),
              Text(widget.cost.toString()),
              ImageIcon(
                AssetImage('assets/icons/costIcon.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
