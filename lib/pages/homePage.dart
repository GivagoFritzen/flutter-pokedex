import 'package:flutter/material.dart';
import 'package:pokedex/components/cardItem.dart';
import 'package:pokedex/components/cardMove.dart';
import 'package:pokedex/components/loading.dart';
import 'package:pokedex/models/itemModel.dart';
import 'package:pokedex/models/moveModel.dart';
import 'package:pokedex/models/pokemonModel.dart';
import 'package:pokedex/services/itemService.dart';
import 'package:pokedex/services/moveService.dart';
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
  final _moveService = MoveService();
  final _itemService = ItemService();

  int currentIndex = 1;
  bool isLoading = true;

  ScrollController _pokemonScrollController = new ScrollController();
  ScrollController _moveScrollController = new ScrollController();
  ScrollController _itemScrollController = new ScrollController();

  List<PokemonModel> _pokemonList;
  List<MoveModel> _movesList;
  List<ItemModel> _itemList;
  int currentMenuSelected = 1;

  @override
  void initState() {
    getPokemons();
    super.initState();

    _pokemonScrollController.addListener(() {
      if (_pokemonScrollController.position.pixels ==
          _pokemonScrollController.position.maxScrollExtent) {
        getPokemons();
      }
    });

    _moveScrollController.addListener(() {
      if (_moveScrollController.position.pixels ==
          _moveScrollController.position.maxScrollExtent) {
        getMoves();
      }
    });

    _itemScrollController.addListener(() {
      if (_itemScrollController.position.pixels ==
          _itemScrollController.position.maxScrollExtent) {
        getItems();
      }
    });
  }

  @override
  void dispose() {
    _pokemonScrollController.dispose();
    _moveScrollController.dispose();
    _itemScrollController.dispose();
    super.dispose();
  }

  void getFilterByName(String findBy) async {
    isLoading = true;

    if (currentIndex == 1) {
      getPokemonByName(findBy);
    } else if (currentIndex == 2) {
      getMoveByName(findBy);
    } else {
      getItemByName(findBy);
    }
  }

  void getPokemonByName(String findBy) async {
    if (findBy == '') {
      getPokemons();
    } else {
      List<PokemonModel> _pokemon = new List<PokemonModel>();

      PokemonModel _pokemonModel =
          await _pokemonService.getPokemonByName(findBy);
      if (_pokemonModel != null) _pokemon.add(_pokemonModel);

      _pokemonList.clear();
      setState(() {
        _pokemonList = _pokemon;
        isLoading = false;
      });
    }
  }

  void getMoveByName(String findBy) async {
    if (findBy == '') {
      getMoves();
    } else {
      List<MoveModel> _moves = new List<MoveModel>();

      MoveModel _moveModel = await _moveService.getMoveByName(findBy);
      if (_moveModel != null) _moves.add(_moveModel);

      _movesList.clear();
      setState(() {
        _movesList = _moves;
        isLoading = false;
      });
    }
  }

  void getItemByName(String findBy) async {
    if (findBy == '') {
      getItems();
    } else {
      List<ItemModel> _items = new List<ItemModel>();

      ItemModel _itemsModel = await _itemService.getItemByName(findBy);
      if (_itemsModel != null) _items.add(_itemsModel);

      _itemList.clear();
      setState(() {
        _itemList = _items;
        isLoading = false;
      });
    }
  }

  void getPokemons() async {
    isLoading = true;
    int sizeList = _pokemonList != null ? _pokemonList.length : 0;
    final json = await _pokemonService.getListPokemon(sizeList);

    setState(() {
      if (_pokemonList == null)
        _pokemonList = json;
      else
        _pokemonList += json;

      isLoading = false;
    });
  }

  void getMoves() async {
    isLoading = true;
    int sizeList = _movesList != null ? _movesList.length : 0;
    final json = await _moveService.getListMoves(sizeList);

    setState(() {
      if (_movesList == null)
        _movesList = json;
      else
        _movesList += json;

      isLoading = false;
    });
  }

  void getItems() async {
    isLoading = true;
    int sizeList = _itemList != null ? _itemList.length : 0;
    final json = await _itemService.getListItems(sizeList);

    setState(() {
      if (_itemList == null)
        _itemList = json;
      else
        _itemList += json;

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
          controller: _pokemonScrollController,
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
          controller: _moveScrollController,
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
          controller: _itemScrollController,
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
          MainAppBar(filterByName: getFilterByName),
          isLoading ? Loading() : getList(),
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
    return Scaffold(body: getHome());
  }
}
