import 'package:flutter/material.dart';
import 'package:pokedex/models/itemModel.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  bool _isInit = true;
  bool isLoading = true;
  ItemModel _itemModel;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final data =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

      setState(() {
        _itemModel = ItemModel.fromJson(data);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
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
                    Text(
                      _itemModel.name,
                      style: TextStyle(fontSize: 40),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _itemModel.cost.toString(),
                          style:
                              TextStyle(fontSize: 19, color: Color(0xffA4A4A4)),
                        ),
                        ImageIcon(
                          AssetImage('assets/icons/costIcon.png'),
                          color: Color(0xffA4A4A4),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Text(
                      _itemModel.description,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -20,
              child: SizedBox(
                child: Image.network(_itemModel.sprite),
                height: 45,
                width: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
