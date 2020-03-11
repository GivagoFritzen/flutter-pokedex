import 'package:flutter/material.dart';
import 'package:pokedex/pages/homePage.dart';
import 'package:pokedex/pages/itemPage.dart';
import 'package:pokedex/pages/movePage.dart';
import 'package:pokedex/pages/pokemonPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        bottom: true,
        top: true,
        child: HomePage(),
      ),
      routes: {
        '/home': (context) => HomePage(),
        '/pokemonPage': (context) => PokemonPage(),
        '/movePage': (context) => MovePage(),
        '/itemPage': (context) => ItemPage(),
      },
    );
  }
}
