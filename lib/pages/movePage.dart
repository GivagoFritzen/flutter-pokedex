import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokedex/components/cardType.dart';
import 'package:pokedex/utils/color.dart';

class MovePage extends StatefulWidget {
  @override
  _MovePageState createState() => _MovePageState();
}

class _MovePageState extends State<MovePage> {
  bool _isInit = true;
  bool isLoading = true;

  String name, type;
  int accuracy, pp, power;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final data =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

      setState(() {
        accuracy = data['accuracy'];
        name = data['name'];
        type = data['type'];
        pp = data['pp'];
        power = data['power'];
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget _getTypes() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 30,
        width: 94,
        child: CardType(
          pokemonType: type.toString(),
          bigCard: true,
        ),
      ),
    );
  }

  Widget _getPowerInfo() {
    if (accuracy == null || power == null || pp == null) {
      return Container();
    } else {
      return Table(
        children: [
          TableRow(children: [
            Text(
              'Base Power',
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorUtil.getColor(type), fontSize: 15),
            ),
            Text(
              'Accuracy',
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorUtil.getColor(type), fontSize: 15),
            ),
            Text(
              'PP',
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorUtil.getColor(type), fontSize: 15),
            ),
          ]),
          TableRow(children: [
            Text(
              power.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19),
            ),
            Text(
              accuracy.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19),
            ),
            Text(
              pp.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19),
            ),
          ])
        ],
      );
    }
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
                  Padding(padding: EdgeInsets.only(top: 30)),
                  _getPowerInfo(),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            child: SizedBox(
              child: CardType(
                pokemonType: type.toString(),
              ),
              height: 70,
              width: 70,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.getColor(type),
      body: getBody(),
    );
  }
}
