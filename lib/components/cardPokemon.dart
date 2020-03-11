import 'package:flutter/material.dart';
import 'package:pokedex/models/descriptionModel.dart';
import 'package:pokedex/models/pokemonModel.dart';
import 'package:pokedex/utils/string.dart';

class CardPokemon extends StatefulWidget {
  PokemonModel pokemonModel;

  CardPokemon({this.pokemonModel}) : assert(pokemonModel != null);

  @override
  _CardPokemonState createState() => _CardPokemonState();
}

class _CardPokemonState extends State<CardPokemon> {
  @override
  Widget build(BuildContext context) {
    DescriptionModel descriptionModel = widget.pokemonModel.descriptionModel;

    return RawMaterialButton(
      onPressed: () => Navigator.pushNamed(
        context,
        '/pokemonPage',
        arguments: {
          'descriptionModel': descriptionModel,
          'name': StringUtil.UppercaseFirstLetterOfEachWord(
              widget.pokemonModel.name),
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
              SizedBox(
                child: Image.network(descriptionModel.image),
                height: 45,
                width: 45,
              ),
              SizedBox(width: 13),
              Text(
                StringUtil.UppercaseFirstLetterOfEachWord(
                    widget.pokemonModel.name),
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
