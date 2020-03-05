import 'package:flutter/material.dart';
import 'package:pokedex/components/cardType.dart';
import 'package:pokedex/components/pokemonStatus.dart';
import 'package:pokedex/models/descriptionModel.dart';
import 'package:pokedex/utils/color.dart';

class PokemonPage extends StatefulWidget {
  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  bool _isInit = true;
  bool _wasLoading = true;
  bool isLoading = true;

  DescriptionModel _pokemonDescriptionModel;
  String name;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _getPokemonData();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _getPokemonData() async {
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    setState(() {
      _pokemonDescriptionModel = data['descriptionModel'];
      name = data['name'];
    });
  }

  Widget _getTypes() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _pokemonDescriptionModel.types
            .map(
              (type) => SizedBox(
                height: 30,
                width: 94,
                child: CardType(
                  pokemonType: type.toString(),
                  bigCard: true,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void _loadFullPage() {
    Future.delayed(Duration(milliseconds: 360), () {
      setState(() {
        _wasLoading = false;
      });
    });
  }

  Widget preLoader() {
    _loadFullPage();
    return Center(
      child: SizedBox(
        child: Hero(
          tag: _pokemonDescriptionModel.id,
          child: Image.network(_pokemonDescriptionModel.image),
        ),
        height: 3160,
        width: 3160,
      ),
    );
  }

  Widget getBody() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: new Radius.circular(45),
                topLeft: new Radius.circular(45),
              ),
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 35, 15, 30),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 24),
                  ),
                  _getTypes(),
                  PokemonStatus(
                    color: ColorUtil.getColor(
                        _pokemonDescriptionModel.types.first),
                    pokemonStatusModel:
                        _pokemonDescriptionModel.pokemonStatusModel,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            child: SizedBox(
              child: Hero(
                tag: _pokemonDescriptionModel.id,
                child: Image.network(_pokemonDescriptionModel.image),
              ),
              height: 90,
              width: 90,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.getColor(_pokemonDescriptionModel.types.first),
      body: _wasLoading ? preLoader() : getBody(),
    );
  }
}
