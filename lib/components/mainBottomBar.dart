import 'package:flutter/material.dart';
import 'package:pokedex/components/mainBottomCard.dart';

class MainBottomBar extends StatelessWidget {
  Function changePokemonList;
  Function changeMoveList;
  Function changeItemList;
  int currentId = 1;

  MainBottomBar(
      {this.changePokemonList,
      this.changeMoveList,
      this.changeItemList,
      this.currentId})
      : assert(changeMoveList != null &&
            changeMoveList != null &&
            changeItemList != null &&
            currentId != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 0.5),
      height: 99,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          MainBottomCard(
            name: 'Pokemon',
            imageName: 'pokemons',
            function: changePokemonList,
            isActived: currentId == 1,
          ),
          MainBottomCard(
            name: 'Moves',
            imageName: 'moves',
            function: changeMoveList,
            isActived: currentId == 2,
          ),
          MainBottomCard(
            name: 'itens',
            imageName: 'itens',
            function: changeItemList,
            isActived: currentId == 3,
          ),
        ],
      ),
    );
  }
}
