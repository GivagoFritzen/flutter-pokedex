import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MainAppBar extends StatefulWidget {
  Function filterByName;

  MainAppBar({this.filterByName}) : assert(filterByName != null);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 0.5),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Text('Pokemon', style: TextStyle(fontSize: 20)),
              SizedBox(height: 15),
              TextField(
                onChanged: (String text) {
                  widget.filterByName(text);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(900),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  labelText: 'Search',
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
