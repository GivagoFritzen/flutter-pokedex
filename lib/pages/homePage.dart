import 'package:flutter/material.dart';
import 'package:pokedex/components/cardItem.dart';
import 'package:pokedex/components/cardMove.dart';
import 'package:pokedex/models/itemModel.dart';
import 'package:pokedex/models/moveModel.dart';
import 'package:pokedex/models/pokemonModel.dart';
import 'package:pokedex/services/pokemonService.dart';
import 'package:pokedex/components/mainAppBar.dart';
import 'package:pokedex/components/cardPokemon.dart';
import 'package:pokedex/components/mainBottomBar.dart';
import 'package:pokedex/utils/color.dart';
import 'package:pokedex/utils/string.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pokemonService = PokemonService();
  int currentIndex = 1;
  bool isLoading = true;

  List<PokemonModel> _pokemonList;
  List<MoveModel> _movesList;
  List<ItemModel> _itemList;
  int currentMenuSelected = 1;

  @override
  void initState() {
    getPokemons();
    super.initState();
  }

  void getPokemons() async {
    final json = await _pokemonService.getListPokemon();

    setState(() {
      _pokemonList = json;
      isLoading = false;
    });
  }

  void getMoves() async {
    final json = await _pokemonService.getListMoves();

    setState(() {
      _movesList = json;
      isLoading = false;
    });
  }

  void getItems() async {
    final json = await _pokemonService.getListItems();

    setState(() {
      _itemList = json;
      isLoading = false;
    });
  }

  void changeList(int index) {
    currentMenuSelected = index;

    if (index == 1) {
      if (_pokemonList == null) {
        getPokemons();
      }
    } else if (index == 2) {
      if (_movesList == null) {
        getMoves();
      }
    } else {
      if (_itemList == null) {
        getItems();
      }
    }

    setState(() {
      currentIndex = index;
    });
  }

  Widget getList() {
    if (currentIndex == 1) {
      return getWidgetsPokemonList();
    } else if (currentIndex == 2) {
      return getWidgetsMoveList();
    } else {
      return getWidgetsItemList();
    }
  }

  Widget getWidgetsPokemonList() {
    if (_pokemonList != null && _pokemonList.length > 0) {
      return Expanded(
        child: ListView.builder(
          itemCount: _pokemonList.length,
          itemBuilder: (BuildContext context, int index) {
            return CardPokemon(
              pokemonModel: _pokemonList[index],
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget getWidgetsMoveList() {
    if (_movesList != null && _movesList.length > 0) {
      return Expanded(
        child: ListView.builder(
          itemCount: _movesList.length,
          itemBuilder: (BuildContext context, int index) {
            MoveModel currentMove = _movesList[index];
            return CardMove(
              accuracy: currentMove.accuracy,
              name: StringUtil.UppercaseFirstLetterOfEachWord(currentMove.name),
              type: currentMove.type,
              pp: currentMove.pp,
              power: currentMove.power,
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget getWidgetsItemList() {
    if (_itemList != null && _itemList.length > 0) {
      return Expanded(
        child: ListView.builder(
          itemCount: _itemList.length,
          itemBuilder: (BuildContext context, int index) {
            ItemModel currentitem = _itemList[index];
            return CardItem(
                name:
                    StringUtil.UppercaseFirstLetterOfEachWord(currentitem.name),
                description: currentitem.description,
                sprite: currentitem.sprite,
                cost: currentitem.cost);
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget getHome() {
    return Container(
      decoration: BoxDecoration(gradient: ColorUtil.getBackgroundColorHome()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MainAppBar(),
          getList(),
          MainBottomBar(
            currentId: currentMenuSelected,
            changePokemonList: () => changeList(1),
            changeMoveList: () => changeList(2),
            changeItemList: () => changeList(3),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: isLoading ? Container() : getHome());
  }
}
