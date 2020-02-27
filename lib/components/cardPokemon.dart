import 'package:flutter/material.dart';

class CardPokemon extends StatefulWidget {
  String name, id, image;

  CardPokemon({this.name, this.id, this.image}) : assert(name != null);

  @override
  _CardPokemonState createState() => _CardPokemonState();
}

class _CardPokemonState extends State<CardPokemon> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => Navigator.pushNamed(
        context,
        '/pokemonPage',
        arguments: {'id': 1, 'imageUrl': ''},
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
              SizedBox(
                child: Image.network(widget.image),
                height: 45,
                width: 45,
              ),
              SizedBox(width: 13),
              Text(
                widget.name,
                style: TextStyle(fontSize: 19),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
