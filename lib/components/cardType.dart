import 'package:flutter/material.dart';
import 'package:pokedex/utils/color.dart';

class CardType extends StatelessWidget {
  String pokemonType;
  bool bigCard = false;

  CardType({this.pokemonType, this.bigCard = false})
      : assert(pokemonType != null);

  BoxShadow getShadown() {
    return BoxShadow(
      color: ColorUtil.getColor(pokemonType),
      blurRadius: 3.0,
      spreadRadius: 0.5,
    );
  }

  BoxDecoration getCardDecoration() {
    if (bigCard)
      return getBigDecorationCard();
    else
      return getSmallDecorationCard();
  }

  BoxDecoration getBigDecorationCard() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      boxShadow: [getShadown()],
      color: ColorUtil.getColor(pokemonType),
    );
  }

  BoxDecoration getSmallDecorationCard() {
    return BoxDecoration(
      boxShadow: [getShadown()],
      color: ColorUtil.getColor(pokemonType),
      shape: BoxShape.circle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: getCardDecoration(),
      child: ImageIcon(
        AssetImage('assets/types/$pokemonType.png'),
        color: Colors.white,
      ),
    );
  }
}
