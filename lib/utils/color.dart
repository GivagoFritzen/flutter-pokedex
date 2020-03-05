import 'package:flutter/material.dart';

class ColorUtil {
  static Color getColor(String pokemonType) {
    switch (pokemonType) {
      case 'bug':
        return Color(0xffAFC836);
      case 'electric':
        return Color(0xffFBE273);
      case 'fire':
        return Color(0xffFBAE46);
      case 'flying':
        return Color(0xffA6C2F2);
      case 'grass':
        return Color(0xff5AC178);
      case 'rock':
        return Color(0xffD7CD90);
      case 'dark':
        return Color(0xff6E7587);
      case 'fairy':
        return Color(0xffF3A7E7);
      case 'poison':
        return Color(0xffC261D4);
      case 'fighting':
        return Color(0xffE74347);
      case 'steel':
        return Color(0xff58A6AA);
      case 'ground':
        return Color(0xffD29463);
      case 'dragon':
        return Color(0xff0180C7);
      case 'ghost':
        return Color(0xff7773D4);
      case 'ice':
        return Color(0xff8CDDD4);
      case 'psychic':
        return Color(0xffFE9F92);
      case 'water':
        return Color(0xff6CBDE4);
      case 'normal':
      default:
        return Color(0xffA3A49E);
    }
  }
}
