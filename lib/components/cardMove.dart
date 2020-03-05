import 'package:flutter/material.dart';
import 'package:pokedex/components/cardType.dart';

class CardMove extends StatefulWidget {
  String name, type;
  int accuracy, pp, power;

  CardMove({this.name, this.type, this.accuracy, this.pp, this.power})
      : assert(name != null && type != null);

  @override
  _CardMoveState createState() => _CardMoveState();
}

class _CardMoveState extends State<CardMove> {
  String getName(String name) {
    String newName = name.replaceAll("-", " ");
    return newName;
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => Navigator.pushNamed(
        context,
        '/movePage',
        arguments: {
          'accuracy': widget.accuracy,
          'name': widget.name,
          'type': widget.type,
          'pp': widget.pp,
          'power': widget.power,
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
              CardType(pokemonType: widget.type.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
